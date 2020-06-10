import { Controller } from "stimulus"
import Rails from "@rails/ujs"
import axios from "axios"



export default class extends Controller {
  static targets = ["articleId", "btn", "icon", "text"]

  check(e) {
    e.preventDefault();

    let articleId = this.articleIdTarget.value
    axios.post(`/api/v1/articles/${articleId}/read`)
      .then((response) => {
        let result = response.data.status
        if (result === 'read') {
          this.btnTarget.classList.add('shake');
          let self = this;
          setTimeout(function () {
            self.btnTarget.classList.remove('shake');
          }, 500);
          this.btnTarget.classList.add('btn-success');
          this.btnTarget.classList.remove('bg-gray-500');
        } else {
          this.btnTarget.classList.add('bg-gray-500');
          this.btnTarget.classList.remove('btn-success');
        }
      },
      )
      .catch((error) => {
        console.log(error);
      })
  }
  navCheck(e) {
    e.preventDefault();
    
    let articleId = this.articleIdTarget.value
    axios.post(`/api/v1/articles/${articleId}/read`)
      .then((response) => {
        let result = response.data.status
        if (result === 'read') {
          this.iconTarget.classList.add('shake');
          let self = this;
          setTimeout(function () {
            self.iconTarget.classList.remove('shake');
          }, 500);
          this.iconTarget.classList.add('color-success');
          this.iconTarget.classList.add('fa-check');
          this.iconTarget.classList.remove('fa-times');
          this.textTarget.innerText = "已讀"       
        } else {
          this.iconTarget.classList.add('fa-times');
          this.iconTarget.classList.remove('fa-check');
          this.iconTarget.classList.remove('color-success');
          this.textTarget.innerText = "未讀"  
        }
      },
      )
      .catch((error) => {
        console.log(error);
      })
  }
}