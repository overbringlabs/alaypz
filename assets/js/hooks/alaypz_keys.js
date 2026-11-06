// .AlaypzKeys — routes keyboard input to the focused game. Mounted on the
// #focused-keys div (present only while a game is focused), so keys are dead
// when nothing is focused. Ignored while typing in an input field.

const ACTIONS = new Set([
  "ArrowLeft",
  "ArrowRight",
  "ArrowDown",
  "ArrowUp",
  "z",
  "Z",
  "x",
  "X",
  "c",
  "C",
])

export default {
  mounted() {
    this.onKeyDown = (e) => {
      if (e.target.closest && e.target.closest("input, textarea, select")) return
      if (!ACTIONS.has(e.key)) return
      e.preventDefault()
      this.pushEvent("game-key", {key: e.key})
    }
    document.addEventListener("keydown", this.onKeyDown)
    this.setupSwipe()
  },

  // Swipe gestures on the /play board (the #play-keys wrapper): the board
  // is the mobile input surface.
  //   slide left/right — one step per 40px of horizontal travel
  //   slide down      — one soft drop per 48px of downward travel
  //   fast down-flick — one hard drop (fast = ≥1.5 px/ms over ≥60px)
  //   flick up (fast) — one clockwise rotate
  //   press-and-hold  — hold piece (550 ms without ≥20px of travel)
  setupSwipe() {
    if (this.el.id !== "play-keys") return
    // The board canvas arrives with the FocusedGame component diff, i.e.
    // after this hook mounts — retry for a short while.
    const tryAttach = (n) => {
      const board = this.el.querySelector("#focused-canvas")
      if (!board) {
        if (n > 0) requestAnimationFrame(() => tryAttach(n - 1))
        return
      }
      this._swipeBind(board)
    }
    requestAnimationFrame(() => tryAttach(30))
  },

  _swipeBind(board) {
    board.style.touchAction = "none"
    const key = (k) => this.pushEvent("game-key", {key: k})
    let active = false
    let pointerId = null
    let startX = 0
    let startY = 0
    let baseX = 0
    let baseY = 0
    let t0 = 0
    let flicked = false
    let dropped = false
    let held = false
    let pressTimer = null
    const cancelPress = () => {
      if (pressTimer) {
        clearTimeout(pressTimer)
        pressTimer = null
      }
    }
    const down = (e) => {
      if (active) return
      active = true
      flicked = false
      dropped = false
      held = false
      pointerId = e.pointerId
      startX = baseX = e.clientX
      startY = baseY = e.clientY
      t0 = performance.now()
      pressTimer = setTimeout(() => {
        if (active && !held && !dropped) {
          held = true
          key("c")
        }
      }, 550)
    }
    const move = (e) => {
      if (!active || e.pointerId !== pointerId || held || dropped) return
      // ≥20px of total travel means it is a swipe, not a press
      if (Math.abs(e.clientX - startX) >= 20 || Math.abs(e.clientY - startY) >= 20) {
        cancelPress()
      }
      const dx = e.clientX - baseX
      if (Math.abs(dx) >= 40) {
        key(dx > 0 ? "ArrowRight" : "ArrowLeft")
        baseX = e.clientX
        return
      }
      const dy = e.clientY - baseY
      if (dy >= 48) {
        const total = e.clientY - startY
        const velocity = total / Math.max(1, performance.now() - t0) // px/ms
        if (total >= 60 && velocity >= 1.5) {
          // fast down-flick: hard drop, gesture done
          dropped = true
          cancelPress()
          key("ArrowUp")
          return
        }
        key("ArrowDown")
        baseY = e.clientY
      } else if (dy <= -36) {
        const velocity = -dy / Math.max(1, performance.now() - t0) // px/ms
        if (velocity >= 1.0 && !flicked) {
          flicked = true
          cancelPress()
          key("x")
        }
      }
    }
    const up = (e) => {
      if (e.pointerId === pointerId) {
        active = false
        cancelPress()
      }
    }
    board.addEventListener("pointerdown", down)
    board.addEventListener("pointermove", move)
    board.addEventListener("pointerup", up)
    board.addEventListener("pointercancel", up)
    this._swipe = { board, down, move, up, cancelPress }
  },

  destroyed() {
    document.removeEventListener("keydown", this.onKeyDown)
    if (this._swipe) {
      const { board, down, move, up, cancelPress } = this._swipe
      board.removeEventListener("pointerdown", down)
      board.removeEventListener("pointermove", move)
      board.removeEventListener("pointerup", up)
      board.removeEventListener("pointercancel", up)
      cancelPress()
      this._swipe = null
    }
  },
}
