import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "choicesContainer",
    "choice",
    "submitButton",
    "feedbackContainer",
    "feedbackText",
    "showAnswerButton",
    "nextButton",
    "answerExplanation"
  ]

  static values = {
    questionId: String, // Number から String に変更
    selectedChoiceId: String, // Number から String に変更
    answered: Boolean,
    correctAnswerId: String // Number から String に変更
  }

  connect() {
    // ページが読み込まれた際に、もし既に解答済み状態であればボタンの表示状態を調整
    if (this.answeredValue) {
      this.disableChoices();
      this.submitButtonTarget.disabled = true;
      this.submitButtonTarget.classList.add("hidden");
      this.showAnswerButtonTarget.classList.remove("hidden");
      this.nextButtonTarget.classList.remove("hidden");
      this.feedbackContainerTarget.classList.remove("hidden");
      // 正解・不正解のスタイルを適用
      this.applyFeedbackStyles();
    } else {
      // 初期状態では解答ボタンを無効化（選択肢が選ばれていないため）
      this.submitButtonTarget.disabled = true;
    }
  }

  // 選択肢がクリックされたときに呼び出される
  selectChoice(event) {
    if (this.answeredValue) {
      return; // 解答済みの問題は再選択できない
    }

    // 全ての選択肢から選択済みクラスを削除
    this.choiceTargets.forEach(choice => {
      choice.classList.remove("bg-blue-100", "border-blue-500");
      // ラジオボタンのチェックを外す
      choice.querySelector('input[type="radio"]').checked = false;
    });

    // クリックされた選択肢に選択済みクラスを適用
    const selectedChoice = event.currentTarget;
    selectedChoice.classList.add("bg-blue-100", "border-blue-500");
    // ラジオボタンをチェックする
    selectedChoice.querySelector('input[type="radio"]').checked = true;

    // 選択された選択肢のIDをStimulusの値に設定
    this.selectedChoiceIdValue = selectedChoice.dataset.choiceId; // parseInt() を削除

    // 解答ボタンを有効化
    this.submitButtonTarget.disabled = false;
  }

  // 「解答する」ボタンがクリックされたときに呼び出される
  async submitAnswer() {
    if (this.answeredValue || !this.hasSelectedChoiceIdValue) {
      return; // 未選択または解答済みの場合、何もしない
    }

    this.submitButtonTarget.disabled = true; // 解答ボタンを無効化

    const questionId = this.questionIdValue;
    const selectedChoiceId = this.selectedChoiceIdValue;

    try {
      const response = await fetch(`/quiz/${questionId}/answer`, {
        method: 'POST',
        headers: {
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
          'Accept': 'application/json',
          'Content-Type': 'application/json' // JSON形式で送信
        },
        body: JSON.stringify({ selected_answer_choice_id: selectedChoiceId })
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const result = await response.json();

      this.answeredValue = true; // 解答済み状態に設定
      this.correctAnswerIdValue = result.correct_answer_id; // 正解IDを保存

      // 選択肢を無効化
      this.disableChoices();

      // フィードバックのスタイルを適用
      this.applyFeedbackStyles();

      // フィードバックを表示
      this.feedbackTextTarget.textContent = result.correct ? '正解！' : '不正解...';
      this.feedbackContainerTarget.classList.remove("hidden");
      this.submitButtonTarget.classList.add("hidden"); // 解答ボタンを非表示

      // 「解答を見る」ボタンと「次へ」ボタンを表示
      this.showAnswerButtonTarget.classList.remove("hidden");
      this.nextButtonTarget.classList.remove("hidden");

      // 次のページへのリダイレクトを設定
      if (result.next_question_url) {
        this.nextButtonTarget.dataset.nextUrl = result.next_question_url;
        this.nextButtonTarget.textContent = "次の問題へ";
      } else if (result.results_url) {
        this.nextButtonTarget.dataset.nextUrl = result.results_url;
        this.nextButtonTarget.textContent = "結果を見る";
      }

    } catch (error) {
      console.error("解答送信エラー:", error);
      alert("解答の送信中にエラーが発生しました。再度お試しください。");
      this.submitButtonTarget.disabled = false; // エラー時はボタンを再度有効化
    }
  }

  // 「解答を見る」ボタンがクリックされたときに呼び出される
  toggleAnswerExplanation() {
    this.answerExplanationTarget.classList.toggle("hidden");
  }

  // 「次へ」ボタンがクリックされたときに呼び出される
  nextQuestion() {
    const nextUrl = this.nextButtonTarget.dataset.nextUrl;
    if (nextUrl) {
      Turbo.visit(nextUrl);
    }
  }

  // 選択肢を無効化するヘルパーメソッド
  disableChoices() {
    this.choiceTargets.forEach(choice => {
      choice.classList.add("pointer-events-none"); // クリックイベントを無効化
      choice.querySelector('input[type="radio"]').disabled = true; // ラジオボタンを無効化
    });
  }

  // 正解・不正解のスタイルを適用するヘルパーメソッド
  applyFeedbackStyles() {
    this.choiceTargets.forEach(choice => {
      const choiceId = choice.dataset.choiceId; // parseInt() を削除
      const isSelected = choiceId === this.selectedChoiceIdValue;
      const isCorrectAnswer = choiceId === this.correctAnswerIdValue;

      // 選択済みクラスを削除
      choice.classList.remove("bg-blue-100", "border-blue-500");

      if (isCorrectAnswer) {
        // 正解の選択肢は緑色
        choice.classList.add("bg-green-100", "border-green-500");
      } else if (isSelected) {
        // ユーザーが選択した不正解の選択肢は赤色
        choice.classList.add("bg-red-100", "border-red-500");
      } else {
        // その他の選択肢はデフォルトに戻す
        choice.classList.add("border-gray-200");
      }
    });

    // フィードバックコンテナの背景色を設定
    if (this.selectedChoiceIdValue === this.correctAnswerIdValue) {
      this.feedbackContainerTarget.classList.add("bg-green-100", "text-green-700");
      this.feedbackContainerTarget.classList.remove("bg-red-100", "text-red-700");
    } else {
      this.feedbackContainerTarget.classList.add("bg-red-100", "text-red-700");
      this.feedbackContainerTarget.classList.remove("bg-green-100", "text-green-700");
    }
  }
}