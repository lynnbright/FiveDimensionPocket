import { Controller } from "stimulus"
import Rails from "@rails/ujs"


export default class extends Controller {
  static targets = [ "icon", "articleId", "text" ]
  
  check(e){
    e.preventDefault();    
    let articleId = this.articleIdTarget.value 
    Rails.ajax({
      url: `/api/v1/articles/${articleId}/publish`, 
      type: 'POST', 
      success: resp => { 
        let status = resp.status;
        if (status === 'published'){
          this.iconTarget.classList.remove('fa-lock');
          this.iconTarget.classList.add('fa-unlock-alt');
          this.textTarget.innerText = "公開"
        } else{
          this.iconTarget.classList.remove('fa-unlock-alt');
          this.iconTarget.classList.add('fa-lock');
          this.textTarget.innerText = "私人"
        }
      },
      error: err => {
        console.log(err);
      } 
    }) 
  }
}