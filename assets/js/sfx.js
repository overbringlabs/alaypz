// Sfx — game sound effects built on tone.js (vendored at assets/vendor/tone.js).
// Deliberately subtle: a soft tick on rotation, a low thock when a piece
// locks, and a boom + rising sparkle arpeggio when lines clear.
//
// Browsers start the AudioContext suspended (autoplay policy), so the first
// pointerdown/keydown on the page unlocks it — the first interaction is
// silent, everything after is audible.
//
// The vendored UMD assigns to module.exports inside the esbuild bundle, so
// import it as a module rather than reading a global.
import * as T from "../vendor/tone"

let unlocked = false
const unlock = () => {
  if (unlocked) return
  unlocked = true
  T.start().catch(() => {})
}
window.addEventListener("pointerdown", unlock, { once: true, passive: true })
window.addEventListener("keydown", unlock, { once: true, passive: true })

let voices = null
const ensure = () => {
  if (voices) return true
  voices = {
    // subtle rotation tick: short high triangle blip
    rotate: new T.Synth({
      oscillator: { type: "triangle" },
      envelope: { attack: 0.004, decay: 0.05, sustain: 0.04, release: 0.05 },
      volume: -22,
    }).toDestination(),
    // piece lock: a low membrane thock
    lock: new T.MembraneSynth({
      octaves: 5,
      envelope: { attack: 0.002, decay: 0.14, release: 0.2 },
      volume: -8,
    }).toDestination(),
    // line clear: deep boom...
    boom: new T.MembraneSynth({
      octaves: 7,
      envelope: { attack: 0.001, decay: 0.28, release: 0.35 },
      volume: -4,
    }).toDestination(),
    // ...with a rising C-major sparkle on top
    sparkle: new T.Synth({
      oscillator: { type: "sine" },
      envelope: { attack: 0.01, decay: 0.16, sustain: 0.08, release: 0.22 },
      volume: -14,
    }).toDestination(),
  }
  return true
}

const counts = { rotate: 0, lock: 0, clear: 0 }

// probe surface (smoke tests + debugging): window.__extromino_sfx
window.__extromino_sfx = {
  counts: () => ({ ...counts }),
  unlocked: () => unlocked,
}

export const play = (kind) => {
  if (!ensure()) return
  counts[kind] = (counts[kind] || 0) + 1
  const now = T.now()
  if (kind === "rotate") {
    voices.rotate.triggerAttackRelease("B4", 0.06, now)
  } else if (kind === "lock") {
    voices.lock.triggerAttackRelease("F1", 0.16, now)
  } else if (kind === "clear") {
    voices.boom.triggerAttackRelease("C1", 0.45, now)
    ;["C5", "E5", "G5"].forEach((note, i) =>
      voices.sparkle.triggerAttackRelease(note, 0.13, now + i * 0.07),
    )
  }
}
