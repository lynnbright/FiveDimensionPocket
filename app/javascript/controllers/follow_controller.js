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
          this.followBtnTarget.classList.remove('btn-outline-info');
          this.followBtnTarget.classList.add('btn-info');
          this.followBtnTarget.innerText = "追蹤中";
        } else{
          this.followBtnTarget.classList.remove('btn-info');
          this.followBtnTarget.classList.add('btn-outline-info');
          this.followBtnTarget.innerText = "追蹤";
        }          
      },
      error: err => {
        console.log(err);
      } 
    }) 
  }
}