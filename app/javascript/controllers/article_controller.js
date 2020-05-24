import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = [ "articleLink" ]

  saveArticle(e){
    // 把文章路徑塞到form裡面執行
    Rails.ajax({
      url: `/articles/`, 
      type: 'POST', 
      success: resp => {
        console.log(resp)
        Swal.fire({
          icon: 'success',
          title: '儲存成功',
          showConfirmButton: false,
          timer: 1500
        })       
      },
      error: err => {
        Swal.fire({
          icon: 'error',
          title: 'Oops...',
          text: 'Something went wrong!'
        })
      } 
    }) 

  }
}