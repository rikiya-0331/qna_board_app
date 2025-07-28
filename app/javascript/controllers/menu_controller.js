import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "button"]

  connect() {
    this.toggleMenu(); // 初期状態を設定するため
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden");
    // モバイル表示時に縦並びにするためのクラスをトグル
    if (window.innerWidth < 1024) { // lgブレークポイント未満の場合のみ
      this.menuTarget.classList.toggle("flex");
      this.menuTarget.classList.toggle("flex-col");
    }
  }

  toggleMenu() {
    if (window.innerWidth >= 1024) { // Tailwindのlgブレークポイント
      this.menuTarget.classList.remove("hidden", "flex", "flex-col"); // hidden, flex, flex-col を削除
    } else {
      this.menuTarget.classList.add("hidden"); // モバイルでは初期状態をhiddenに
      this.menuTarget.classList.remove("flex", "flex-col"); // flex, flex-col を削除
    }
  }

  resize() {
    this.toggleMenu();
  }
}