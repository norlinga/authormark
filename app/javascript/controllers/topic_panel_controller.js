import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  async add(event) {
    const topicId = event.currentTarget.closest("li").dataset.topicId
    await this.fetchAndReplace("POST", topicId)
  }

  async remove(event) {
    const topicId = event.currentTarget.closest("li").dataset.topicId
    await this.fetchAndReplace("DELETE", topicId)
  }

  async promote(event) {
    const topicId = event.currentTarget.closest("li").dataset.topicId
    await this.fetchAndReplace("PATCH", topicId, { promote: true })
  }

  async fetchAndReplace(method, topicId, options = {}) {
    const token = document.querySelector('meta[name="csrf-token"]').content
    const essayId = this.element.dataset.essayId

    let url = options.promote
      ? `/authoring/essays/${essayId}/primary_topic/${topicId}`
      : `/authoring/essays/${essayId}/topics/${topicId}`

    const response = await fetch(url, {
      method: method,
      headers: {
        "X-CSRF-Token": token,
        "Accept": "text/vnd.turbo-stream.html"
      }
    })

    if (response.ok) {
      const html = await response.text()
      document.getElementById("topic-panel").outerHTML = html
    } else {
      console.error("Request failed", response)
    }
  }
}
