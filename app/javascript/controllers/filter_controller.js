import { Controller } from "@hotwired/stimulus"

// [解説] filter-controller
// カテゴリの絞り込み機能全体を管理します。
export default class extends Controller {
  // [解説] ターゲットの定義
  // `data-filter-target="category"` を持つすべてのカテゴリdiv要素を
  // `this.categoryTargets` という配列として参照できるようにします。
  static targets = ["category"]

  // [解説] selectアクション
  // カテゴリボタンがクリックされたときに実行されます。
  select(event) {
    // [解説] クリックされたボタンからカテゴリ名を取得
    // `event.currentTarget` はクリックされたボタン要素を指します。
    // `.dataset.categoryName` で `data-category-name` 属性の値を取得します。
    const selectedCategory = event.currentTarget.dataset.categoryName;

    // [解説] すべてのカテゴリdivをループ処理
    this.categoryTargets.forEach(categoryElement => {
      // [解説] 各カテゴリdivが持つ `data-category-name` の値を取得
      const categoryName = categoryElement.dataset.categoryName;

      // [解説] 表示・非表示のロジック
      // もしクリックされたカテゴリが「すべて」であるか、
      // または、divのカテゴリ名とクリックされたカテゴリ名が一致する場合
      if (selectedCategory === 'all' || categoryName === selectedCategory) {
        // 表示する (hiddenクラスを削除)
        categoryElement.classList.remove('hidden');
      } else {
        // 非表示にする (hiddenクラスを追加)
        categoryElement.classList.add('hidden');
      }
    });

    // [解説] ボタンのアクティブ状態を更新 (UI/UX向上のため)
    this.updateActiveButton(event.currentTarget);
  }

  // [解説] ボタンの見た目を更新する補助的なメソッド
  updateActiveButton(activeButton) {
    // [解説] すべてのボタンを取得
    // `this.element` は `data-controller="filter"` が指定された要素（ページ全体のコンテナ）を指します。
    const buttons = this.element.querySelectorAll('[data-action="click->filter#select"]');

    // [解説] すべてのボタンのスタイルを一旦リセット
    buttons.forEach(button => {
      button.classList.remove('bg-blue-500', 'text-white');
      button.classList.add('bg-gray-200', 'text-gray-800');
    });

    // [解説] クリックされたボタンにだけアクティブなスタイルを適用
    activeButton.classList.remove('bg-gray-200', 'text-gray-800');
    activeButton.classList.add('bg-blue-500', 'text-white');
  }
}