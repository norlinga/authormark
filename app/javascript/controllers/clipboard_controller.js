import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source"]

  copy() {
    console.log("Copying text")
    const text = this.sourceTarget.textContent.trim()
    navigator.clipboard.writeText(text)
      .then(() => {
        this.element.classList.add("ring", "ring-green-400")
        setTimeout(() => {
          this.element.classList.remove("ring", "ring-green-400")
        }, 1000)
      })
      .catch(err => console.error("Copy failed", err))
  }
}
