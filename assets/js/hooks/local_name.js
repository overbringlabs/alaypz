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
      // The saved name is already claimed: resolve it server-side right
      // away (a running game re-attaches and the play surface appears)
      // instead of making the user re-claim it by hand.
      this.el.form.requestSubmit();
    }

    this.el.addEventListener("change", () => {
      if (this.el.value) {
        localStorage.setItem("alaypz_name", this.el.value);
      }
    });
  },
};
