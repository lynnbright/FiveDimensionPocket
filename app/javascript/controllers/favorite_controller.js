import { Controller } from "stimulus"
import Rails from "@rails/ujs"
import axios from "axios"


export default class extends Controller {
  static targets = [ "icon", "article_id" ]

  heart(e){
    e.preventDefault();
    
    let article_id = this.article_idTarget.value 
    axios.post(`/api/v1/articles/${article_id}/favorite`)
         .then((response) => {
          let result = response.data.status
          console.log(result)
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