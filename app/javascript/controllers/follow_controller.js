import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = [ "followBtn", "userId" ]
  
  check(e){
    e.preventDefault();    
    let userId = this.userIdTarget.value 
    Rails.ajax({
      url: `/api/v1/users/${userId}/follow`, 
      type: 'POST', 
      success: resp => { 
        console.log(resp)
        if (resp.follow === true) {
          this.followBtnTarget.classList.remove('btn-pink');
          this.followBtnTarget.classList.add('btn-black');
          this.followBtnTarget.innerText = "追蹤中";
        } else{
          this.followBtnTarget.classList.remove('btn-black');
          this.followBtnTarget.classList.add('btn-pink');
          this.followBtnTarget.innerText = "追蹤";
        }          
      },
      error: err => {
        console.log(err);
      } 
    }) 
  }
}