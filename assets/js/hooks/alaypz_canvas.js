// .AlaypzCanvas — neon 2D-canvas board for the focused game (live mode) and
// the history views (static mode).
//
// Live mode: the FocusedGame component pushes a "alaypz-frame" event on every
// engine state change; this hook keeps the latest frame and tweens the
// falling piece between the last two frames, so a single server tick renders
// as smooth motion for everyone (player and spectators).
//
// Static mode: `data-static` + `data-board` (200-char board string, one char
// per cell, "." empty) draws once on mount — no loop.
//
// Colors come from the .alaypz-board CSS custom properties (assets/css/app.css).

import { play as sfx } from "../sfx"

const TWEEN_MS = 110
const FLASH_MS = 350
const SHAKE_MS = 280
const SHAKE_AMP = 4

export default {
  mounted() {
    this.card = this.el.dataset.card !== undefined
    this.cell = Number(this.el.dataset.cell) || (this.card ? 10 : 26)
    this.mini = Math.round(this.cell * 0.46)
    this.cols = Number(this.el.dataset.cols) || 10
    this.rows = Number(this.el.dataset.rows) || 20
    this.static = this.el.dataset.static !== undefined
    this.fitHeight = this.el.dataset.fitHeight !== undefined
    this.fitCell()
    // Height fit needs the settled layout (HUD strip + controls heights);
    // re-measure after the first paint so the fit is exact (mobile only).
    if (this.fitHeight && window.matchMedia("(max-width: 767px)").matches) {
      requestAnimationFrame(() => this.fitCell(true))
    }
    this.bandH = this.card || this.static ? 0 : this.mini * 4 + 12
    this.el.width = this.cols * this.cell
    this.el.height = this.rows * this.cell + this.bandH
    this.onResize = () => this.fitCell(true)
    window.addEventListener("resize", this.onResize)
    this.ctx = this.el.getContext("2d")
    this.palette = this.readPalette()
    this.frame = null
    this.shownPiece = null
    this.tween = null
    this.lastLines = 0
    this.flashUntil = 0
    this.raf = null

    if (this.static) {
      this.drawBoard(this.decodeBoard(this.el.dataset.board || ""), null, null, 0)
    } else {
      this.raf = requestAnimationFrame(() => this.loop())
      if (this.card) {
        // A card canvas only draws frames for its own game.
        this.handleEvent("alaypz-card-frame", (msg) => {
          if (msg && msg.name === this.el.dataset.name) this.onFrame(msg.frame)
        })
      } else if (this.el.dataset.replay !== undefined) {
        // The replay page owns exactly one canvas: ReplayLive pushes a
        // "replay-frame" event per stepped tick.
        this.handleEvent("replay-frame", (frame) => this.onFrame(frame))
      } else {
        this.handleEvent("alaypz-frame", (frame) => this.onFrame(frame))
      }
    }
  },

  destroyed() {
    if (this.raf) cancelAnimationFrame(this.raf)
    window.removeEventListener("resize", this.onResize)
  },

  // Keep the board inside its container (a 280 px board overflows a 320 px
  // mobile viewport) and re-fit on window resizes such as device rotation.
  // The board div's own width is inflated by the canvas element, so the
  // available width comes from the nearest layout scope (section / max-w
  // container / viewport minus the page padding). Only clamps when the
  // board would actually overflow, so desktop sizes are untouched.
  // `reapply` resizes the canvas element itself.
  fitCell(reapply) {
    const board = this.el.parentElement
    if (!board) return
    const scope = board.closest("section") || board.closest("[class*='max-w-']")
    let avail = window.innerWidth - 32
    if (scope && scope.clientWidth) avail = Math.min(avail, scope.clientWidth)
    // Subtract the horizontal padding + border of every element between the
    // scope and the canvas, so the canvas fits the board's actual box at any
    // viewport (no guessed padding).
    for (let el = board; el && el !== scope; el = el.parentElement) {
      const cs = getComputedStyle(el)
      avail -=
        parseFloat(cs.paddingLeft) +
        parseFloat(cs.paddingRight) +
        parseFloat(cs.borderLeftWidth) +
        parseFloat(cs.borderRightWidth)
    }
    let cell =
      this.cols * this.cell > avail ? Math.max(8, Math.floor(avail / this.cols)) : this.cell

    // Height fit (the /play mobile game screen): shrink the cell so the
    // board + touch controls fill the viewport without scrolling. Desktop
    // keeps its natural board size (the page scrolls there). bandH is
    // mini*4+12 ≈ 1.84*cell + 12; the board adds ~18px of padding/border.
    const mobile = window.matchMedia("(max-width: 767px)").matches
    if (this.fitHeight && mobile) {
      const rect = board.getBoundingClientRect()
      let controlsH = 160
      let gap = 47
      const controls = document.querySelector("#play-controls")
      if (controls) {
        controlsH = controls.getBoundingClientRect().height
        gap = Math.max(0, controls.getBoundingClientRect().top - rect.bottom)
      }
      // board bottom (chrome = 18px padding/border) + gap + controls ≤ viewport
      // bandH = mini*4 + 12 ≈ 1.84*cell + 12
      const availH = window.innerHeight - rect.top - gap - controlsH
      const hCell = Math.floor((availH - 18 - 12) / (this.rows + 1.84))
      if (hCell < cell) cell = Math.max(8, hCell)
    }
    if (reapply && cell === this.cell) return
    this.cell = cell
    this.mini = Math.round(this.cell * 0.46)
    if (reapply) {
      this.bandH = this.card || this.static ? 0 : this.mini * 4 + 12
      this.el.width = this.cols * this.cell
      this.el.height = this.rows * this.cell + this.bandH
    }
  },

  onFrame(frame) {
    if (!frame) return
    this.frame = frame

    // Cards draw the piece instantly — no tween, no line-clear flash.
    if (this.card) {
      this.shownPiece = frame.piece
      this.tween = null
      return
    }

    // Sound events, derived from what changed between frames:
    //  rotate — same piece id, different orientation
    //  lock   — the board gained cells without lines being cleared (the
    //           engine locks and spawns the next piece in one frame, so a
    //           nil piece is never observed; the board diff is the signal)
    const ended = frame.status === "finished" || frame.status === "interrupted"
    const prev = this.prevFrame
    if (prev && !ended) {
      if (
        frame.piece &&
        prev.piece &&
        frame.piece_id === prev.piece_id &&
        frame.piece_state != null &&
        frame.piece_state !== prev.piece_state
      ) {
        sfx("rotate")
      }
      const boardChanged =
        JSON.stringify(frame.board || []) !== JSON.stringify(prev.board || [])
      if (boardChanged && frame.lines === prev.lines && prev.piece) sfx("lock")
    }
    this.prevFrame = frame

    if (frame.lines > this.lastLines) {
      this.lastLines = frame.lines
      const now = performance.now()
      this.flashUntil = now + FLASH_MS
      this.shakeUntil = now + SHAKE_MS
      sfx("clear")
    }

    const piece = frame.piece
    if (piece && this.shownPiece) {
      if (piece[0] !== this.shownPiece[0] || piece[1] !== this.shownPiece[1]) {
        this.tween = {
          from: this.shownPiece,
          to: piece,
          start: performance.now(),
          dur: TWEEN_MS,
        }
      }
    } else if (piece) {
      this.shownPiece = piece
      this.tween = null
    } else {
      this.shownPiece = null
      this.tween = null
    }
  },

  loop() {
    this.render()
    this.raf = requestAnimationFrame(() => this.loop())
  },

  // --- drawing -----------------------------------------------------------

  render() {
    const frame = this.frame
    const { ctx } = this

    const now = performance.now()
    ctx.clearRect(0, 0, this.el.width, this.el.height)
    ctx.fillStyle = this.palette.bg
    ctx.fillRect(0, 0, this.el.width, this.el.height)

    if (frame) {
      const piece = this.card ? frame.piece : this.piecePosition(frame)

      // Line-clear impact: the board content jitters for SHAKE_MS.
      ctx.save()
      if (!this.card && now < this.shakeUntil) {
        const t = (this.shakeUntil - now) / SHAKE_MS
        const amp = SHAKE_AMP * t
        ctx.translate((Math.random() - 0.5) * 2 * amp, (Math.random() - 0.5) * 2 * amp)
      }

      this.drawBoard(frame.board, frame.cells, frame.ghost, frame.status, piece)

      if (!this.card) {
        this.drawBand(frame)

        if (frame.lines > 0 && now < this.flashUntil) {
          const remain = this.flashUntil - now
          const t = remain / FLASH_MS
          // white impact core in the first 120ms, then the cyan glow fades
          const core = Math.max(0, (remain - (FLASH_MS - 120)) / 120)
          if (core > 0) {
            ctx.fillStyle = `rgba(255, 255, 255, ${0.5 * core})`
            ctx.fillRect(-8, this.bandH - 2, this.el.width + 16, this.rows * this.cell + 4)
          }
          ctx.fillStyle = `rgba(160, 240, 255, ${0.55 * t})`
          ctx.fillRect(0, this.bandH, this.el.width, this.rows * this.cell)
        }

        if (frame.status === "finished" || frame.status === "interrupted") {
          this.drawGameOver(frame.status)
        }
      }
      ctx.restore()
    }
  },

  // The piece position currently on screen: mid-tween when the server moved
  // it, settled otherwise.
  piecePosition(frame) {
    if (!frame.piece) return null
    if (!this.tween) return this.shownPiece || frame.piece
    const t = Math.min(1, (performance.now() - this.tween.start) / this.tween.dur)
    if (t >= 1) {
      this.tween = null
      this.shownPiece = frame.piece
      return frame.piece
    }
    const ease = t * t * (3 - 2 * t) // smoothstep
    const from = this.tween.from
    const to = this.tween.to
    this.shownPiece = [
      Math.round(from[0] + (to[0] - from[0]) * ease),
      Math.round(from[1] + (to[1] - from[1]) * ease),
    ]
    return this.shownPiece
  },

  drawBoard(board, cells, ghost, status, piecePos) {
    const { ctx, cell: c } = this
    const y0 = this.bandH

    // grid
    ctx.strokeStyle = this.palette.grid
    ctx.lineWidth = 1
    ctx.beginPath()
    for (let x = 0; x <= this.cols; x++) {
      ctx.moveTo(x * c + 0.5, y0)
      ctx.lineTo(x * c + 0.5, y0 + this.rows * c)
    }
    for (let y = 0; y <= this.rows; y++) {
      ctx.moveTo(0, y0 + y * c + 0.5)
      ctx.lineTo(this.cols * c, y0 + y * c + 0.5)
    }
    ctx.stroke()

    // locked cells (row 0 = top of the board)
    if (board) {
      for (let y = 0; y < this.rows; y++) {
        const row = board[y]
        if (!row) continue
        for (let x = 0; x < this.cols; x++) {
          const id = row[x]
          if (id) this.cellAt(x, y, this.color(id))
        }
      }
    }

    // ghost: faint outline under the current piece
    if (ghost && piecePos) {
      const inset = Math.min(3, Math.floor(this.cell * 0.2))
      ctx.strokeStyle = this.palette.ghost
      ctx.lineWidth = 1
      for (const [x, y] of ghost) {
        if (y < this.rows) {
          ctx.strokeRect(x * c + inset + 0.5, y0 + y * c + inset + 0.5, c - inset * 2 - 1, c - inset * 2 - 1)
        }
      }
    }

    // current piece (with glow): cells are absolute for the frame's box
    // position; shift them by the tween delta so the piece glides.
    if (cells && piecePos) {
      const frame = this.frame
      const color = frame && frame.piece_id ? this.color(frame.piece_id) : this.palette.i
      const offX = piecePos[0] - frame.piece[0]
      const offY = piecePos[1] - frame.piece[1]

      ctx.save()
      ctx.shadowColor = color
      ctx.shadowBlur = Math.min(14, this.cell * 0.55)
      for (const [x, y] of cells) {
        this.cellAt(x + offX, y + offY, color)
      }
      ctx.restore()
    }

    if (status === "finished" || status === "interrupted") {
      // dim the final board slightly so the game-over text reads
      ctx.fillStyle = "rgba(5, 8, 18, 0.45)"
      ctx.fillRect(0, y0, this.cols * c, this.rows * c)
    }
  },

  cellAt(x, y, color) {
    const { ctx, cell: c } = this
    const pad = Math.min(1.5, c * 0.12)
    const px = x * c
    const py = this.bandH + y * c
    if (px < 0 || py < 0 || px + c > this.el.width || py + c > this.el.height) return
    ctx.fillStyle = color
    ctx.fillRect(px + pad, py + pad, c - pad * 2, c - pad * 2)
    // top highlight for the neon bevel
    ctx.fillStyle = "rgba(255, 255, 255, 0.25)"
    ctx.fillRect(px + pad, py + pad, c - pad * 2, Math.max(1, Math.min(3, c * 0.2)))
  },

  // hold (left) + next three (right), drawn in the band above the board
  drawBand(frame) {
    const { ctx, mini } = this
    const m = mini
    const pad = 6

    if (frame.hold) {
      this.miniPiece(pad, 8, frame.hold.cells, this.color(frame.hold.id), m)
    }

    const right = this.cols * this.cell - pad
    const queue = frame.queue || []
    queue.forEach((q, i) => {
      const x0 = right - (3 - i) * (m * 4 + 6)
      this.miniPiece(x0, 8, q.cells, this.color(q.id), m)
    })
  },

  miniPiece(x0, y0, cells, color, m) {
    const { ctx } = this
    ctx.save()
    ctx.shadowColor = color
    ctx.shadowBlur = 8
    for (const [x, y] of cells) {
      ctx.fillStyle = color
      ctx.fillRect(x0 + x * m, y0 + y * m, m - 1, m - 1)
    }
    ctx.restore()
  },

  drawGameOver(status) {
    const { ctx } = this
    ctx.save()
    ctx.font = "bold 34px monospace"
    ctx.textAlign = "center"
    ctx.textBaseline = "middle"
    ctx.shadowColor = status === "finished" ? this.palette.o : this.palette.z
    ctx.shadowBlur = 22
    ctx.fillStyle = status === "finished" ? this.palette.o : this.palette.z
    ctx.fillText(status === "finished" ? "FINISHED" : "INTERRUPTED", this.el.width / 2, this.bandH + (this.rows * this.cell) / 2)
    ctx.restore()
  },

  // --- static mode -------------------------------------------------------

  decodeBoard(str) {
    const rows = []
    for (let y = 0; y < 20; y++) {
      const row = []
      for (let x = 0; x < 10; x++) {
        const ch = str[y * 10 + x] || "."
        row.push(ch === "." ? null : ch)
      }
      rows.push(row)
    }
    return rows
  },

  // --- palette -----------------------------------------------------------

  readPalette() {
    const style = getComputedStyle(this.el)
    const css = (name, fallback) => {
      const v = style.getPropertyValue(name).trim()
      return v || fallback
    }
    const piece = (k, fallback) => css(`--tet-${k}`, fallback)
    return {
      i: piece("i", "#00e5ff"),
      j: piece("j", "#448aff"),
      l: piece("l", "#ff9e40"),
      o: piece("o", "#ffea00"),
      s: piece("s", "#00e676"),
      t: piece("t", "#e040fb"),
      z: piece("z", "#ff5252"),
      bg: css("--tet-bg", "#0b1020"),
      grid: css("--tet-grid", "rgba(120, 200, 255, 0.08)"),
      ghost: css("--tet-ghost", "rgba(0, 229, 255, 0.35)"),
    }
  },

  color(id) {
    return this.palette[String(id).toLowerCase()] || this.palette.i
  },
}
