import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["dialog"]

  // モーダルを開く
  open() {
    this.dialogTarget.showModal()
  }

  // モーダルを閉じる
  close() {
    this.dialogTarget.close()
  }

  // モーダルの外側をクリックしたときに閉じる
  closeOnBackdropClick(event) {
    if (event.target === this.dialogTarget) {
      this.close()
    }
  }
}
