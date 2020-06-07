import { Controller } from "stimulus"
import Rails from "@rails/ujs"
import axios from "axios"


export default class extends Controller {
  static targets = [ "articleId", "btn", "icon"]

  heart(e){
    e.preventDefault();
    
    let articleId = this.articleIdTarget.value 
    axios.post(`/api/v1/articles/${articleId}/favorite`)
         .then((response) => {
          let result = response.data.status
            if (result === 'favorited'){   
              this.btnTarget.classList.add('shake');
              let self = this;
              setTimeout(function () {
                self.btnTarget.classList.remove('shake');
              }, 500);
              this.btnTarget.classList.add('hearted');
              this.btnTarget.classList.remove('bg-gray-500');
            } else{
              this.btnTarget.classList.add('bg-gray-500');
              this.btnTarget.classList.remove('hearted');
            }
          },
         )
         .catch ((error) => {
          console.log(error);
        } )
  }
  navHeart(e){
    e.preventDefault();
    
    let articleId = this.articleIdTarget.value 
    axios.post(`/api/v1/articles/${articleId}/favorite`)
         .then((response) => {
          let result = response.data.status
            if (result === 'favorited'){   
              this.iconTarget.classList.add('shake');
              let self = this;
              setTimeout(function () {
                self.iconTarget.classList.remove('shake');
              }, 500);
              this.iconTarget.classList.add('fas');
              this.iconTarget.classList.add('pink');
              this.iconTarget.classList.remove('far');
            } else{
              this.iconTarget.classList.add('far');
              this.iconTarget.classList.remove('fas');
              this.iconTarget.classList.remove('pink');
            }
          },
         )
         .catch ((error) => {
          console.log(error);
        } )
  }
}