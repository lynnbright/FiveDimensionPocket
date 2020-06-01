import { Controller } from "stimulus"
import Rails from "@rails/ujs"
import axios from "axios"



export default class extends Controller {
  static targets = [ "articleId", "btn" ]

  check(e){
    e.preventDefault();
    
    let articleId = this.articleIdTarget.value 
    axios.post(`/api/v1/articles/${articleId}/read`)
         .then((response) => {
          let result = response.data.status
            if (result === 'read'){
              this.btnTarget.classList.add('btn-success');
              this.btnTarget.classList.remove('bg-gray-500');
            } else{
              this.btnTarget.classList.add('bg-gray-500');
              this.btnTarget.classList.remove('btn-success');
            }
          },
         )
         .catch ((error) => {
          console.log(error);
        } )
  }
}