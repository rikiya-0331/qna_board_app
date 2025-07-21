import { Controller } from "@hotwired/stimulus"

// [解説] qa-card-controller
// 個々のQ&Aカードの振る舞いを定義します。
export default class extends Controller {
  // [解説] ターゲットの定義
  // `data-qa-card-target="answer"` という属性を持つHTML要素を、
  // このコントローラ内で `this.answerTarget` として参照できるようにします。
  static targets = ["answer"]

  // [解説] toggleアクション
  // 「回答を見る/隠す」ボタンがクリックされたときに実行されるメソッドです。
  toggle(event) {
    // [解説] event.currentTarget
    // イベント（今回はクリック）が発生した要素、つまりボタン自身を指します。
    const button = event.currentTarget;

    // [解説] this.answerTarget
    // `static targets`で定義したanswer要素（回答文が書かれたdiv）を指します。
    // `classList.toggle('hidden')` で、hiddenクラスが存在すれば削除し、なければ追加します。
    // これにより、表示・非表示が切り替わります。
    this.answerTarget.classList.toggle("hidden");

    // [解説] ボタンのテキストを切り替え
    // 回答が非表示（hiddenクラスを持つ）かどうかを判定し、ボタンの文言を動的に変更します。
    if (this.answerTarget.classList.contains('hidden')) {
      button.textContent = "回答を見る";
    } else {
      button.textContent = "回答を隠す";
    }
  }
}
