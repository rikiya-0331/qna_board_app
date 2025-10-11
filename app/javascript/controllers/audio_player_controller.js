import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="audio-player"
export default class extends Controller {
  static values = { url: String }
  static targets = ["playIcon", "stopIcon"]

  connect() {
    this.audio = null
    this.isPlaying = false
    this.updateIcon()
  }

  toggle(event) {
    // デフォルトのイベント（リンク遷移など）をキャンセル
    event.preventDefault()

    if (this.isPlaying) {
      this.stop()
    } else {
      this.play()
    }
  }

  play() {
    // 既に再生中のものがあれば停止させる
    document.querySelectorAll('audio').forEach(audio => audio.pause());

    if (!this.audio) {
      this.audio = new Audio(this.urlValue)
      // 再生が終了したらアイコンを元に戻す
      this.audio.addEventListener('ended', () => {
        this.stop()
      })
    }

    this.audio.play()
    this.isPlaying = true
    this.updateIcon()
  }

  stop() {
    if (this.audio) {
      this.audio.pause()
      this.audio.currentTime = 0 // 再生位置をリセット
    }
    this.isPlaying = false
    this.updateIcon()
  }

  updateIcon() {
    this.playIconTarget.classList.toggle("hidden", this.isPlaying)
    this.stopIconTarget.classList.toggle("hidden", !this.isPlaying)
  }

  disconnect() {
    // ページ遷移時などに再生を停止してリソースを解放
    if (this.audio) {
      this.audio.pause()
      this.audio = null
    }
  }
}
