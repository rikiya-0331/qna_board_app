import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]
  static values = { url: String, minLength: { type: Number, default: 2 } }

  connect() {
    console.log("Autocomplete controller connected - start");
    this.debouncedSearch = this.debounce(this.search, 300).bind(this);
    console.log("Autocomplete controller connected - debouncedSearch created");
    this.hideResults();
    console.log("Autocomplete controller connected - hideResults called");
  }

  async search() {
    const query = this.inputTarget.value.trim()

    if (query.length < this.minLengthValue) {
      this.hideResults()
      return
    }

    try {
      // キャッシュ無効化のためのパラメータ追加
      const timestamp = new Date().getTime();
      const response = await fetch(`${this.urlValue}?query=${encodeURIComponent(query)}&_=${timestamp}`, {
        method: 'GET',
        headers: {
          'Accept': 'application/json',
          'Cache-Control': 'no-cache',
          'Pragma': 'no-cache'
        }
      });
      
      console.log("Response status:", response.status);
      console.log("Response headers:", [...response.headers.entries()]);
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      // 204 No Content の場合はJSON解析をスキップ
      if (response.status === 204) {
        this.displayResults([]);
        return;
      }
      const data = await response.json();
      console.log("Received data:", data);
      this.displayResults(data);
    } catch (error) {
      console.error("Fetch error:", error);
    }
  }

  displayResults(data) {
    console.log("displayResults called with:", data);
    console.log("resultsTarget element:", this.resultsTarget);
    console.log("resultsTarget innerHTML before clear:", this.resultsTarget.innerHTML);
    
    this.resultsTarget.innerHTML = "";
    
    console.log("resultsTarget innerHTML after clear:", this.resultsTarget.innerHTML);

    if (data.length === 0) {
      this.hideResults();
      return;
    }

    data.forEach((question, index) => {
      const item = document.createElement("div");
      item.classList.add("p-2", "hover:bg-gray-100", "cursor-pointer", "autocomplete-item");
      item.textContent = question.title_jp;
      item.dataset.questionId = question.id;
      item.addEventListener("click", () => this.selectResult(question));
      
      console.log(`Creating item ${index}:`, item);
      this.resultsTarget.appendChild(item);
      console.log(`After appendChild ${index}, innerHTML:`, this.resultsTarget.innerHTML);
    });
    
    console.log("Final innerHTML:", this.resultsTarget.innerHTML);
    this.showResults();
  }

  selectResult(question) {
    this.inputTarget.value = question.title_jp // 選択した質問のタイトルを検索ボックスに表示
    // 選択した質問のページに遷移するなど、追加の処理をここで行う
    // 例: window.location.href = `/questions/${question.id}`
    this.hideResults()
  }

  hideResults() {
    this.resultsTarget.classList.add("hidden")
  }

  showResults() {
    const inputRect = this.inputTarget.getBoundingClientRect();
    this.resultsTarget.style.top = `${inputRect.bottom + window.scrollY}px`;
    this.resultsTarget.style.left = `${inputRect.left + window.scrollX}px`;
    this.resultsTarget.style.width = `${inputRect.width}px`;
    this.resultsTarget.style.maxHeight = "200px"; // 最大高さを設定
    this.resultsTarget.style.overflowY = "auto"; // スクロール可能にする
    this.resultsTarget.classList.remove("hidden");
  }

  // デバウンス関数
  debounce(func, delay) {
    let timeout
    return function(...args) {
      const context = this
      clearTimeout(timeout)
      timeout = setTimeout(() => func.apply(context, args), delay)
    }
  }

  disconnect() {
    this.hideResults()
  }
}