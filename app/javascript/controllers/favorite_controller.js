import { Controller } from "stimulus"
import Rails from "@rails/ujs"
import axios from "axios"


export default class extends Controller {
  static targets = [ "icon", "articleId" ]

  heart(e){
    e.preventDefault();
    
    let articleId = this.articleIdTarget.value 
    axios.post(`/api/v1/articles/${articleId}/favorite`)
         .then((response) => {
          let result = response.data.status
            if (result === 'favorited'){
              this.iconTarget.classList.remove('far');
              this.iconTarget.classList.add('fas');
            } else{
              this.iconTarget.classList.remove('fas');
              this.iconTarget.classList.add('far');
            }
          },
         )
         .catch ((error) => {
          console.log(error);
        } )
  }
}