// .LocalName — pre-fills the identity input from localStorage.alaypz_name
// and saves edits back, so the claimed name survives navigation and reloads
// (the server never trusts the client; the name is claimed/reclaimed through
// the form). Mounted on the identity form's name input.

export default {
  mounted() {
    const saved = localStorage.getItem("alaypz_name");
    if (saved) {
      this.el.value = saved;
      this.el.dispatchEvent(new Event("input", { bubbles: true }));
    }

    this.el.addEventListener("change", () => {
      if (this.el.value) {
        localStorage.setItem("alaypz_name", this.el.value);
      }
    });
  },
};
