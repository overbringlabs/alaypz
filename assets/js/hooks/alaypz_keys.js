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
  },

  destroyed() {
    document.removeEventListener("keydown", this.onKeyDown)
  },
}
