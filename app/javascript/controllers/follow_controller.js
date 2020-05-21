import { Controller } from "stimulus"
import axios from "axios"

export default class extends Controller {
  static targets = [ "followBtn", "userId" ]

  check(e){
    e.preventDefault();
  
    let articleId = this.articleIdTarget.value 
    axios.post(`/api/v1/user/${articleId}/follow`)
         .then((resp) => {
            // 按鈕變色，innertext字換成追蹤中
            if (resp === true) {
              this.followBtnTarget.classList.remove('fa-unlock-alt');
              this.followBtnTarget.classList.add('fa-unlock-alt');
              this.followBtnTarget.innerText = "追蹤中";
            } else{
              this.followBtnTarget.classList.remove('fa-unlock-alt');
              this.followBtnTarget.classList.add('fa-unlock-alt');
              this.followBtnTarget.innerText = "追蹤";
            }          
          },
         )
         .catch ((error) => {
          console.log(error);
         } )
  }
}