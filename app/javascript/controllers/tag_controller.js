import { Controller } from "stimulus"
import axios from 'axios'


export default class extends Controller {
  static targets = [ "articleId" ]
 
  connect(){    

  }
  editTag(e) {
    let id = this.articleIdTarget.value
    Swal.fire({
      title: "新增標籤",
      html: document.querySelector('#tagSelect').innerHTML,
      showCancelButton: true,
      showConfirmButton: true,
      onOpen: function () {
        $('[name="select2-multiple"]').select2({
            tags: true,
            tokenSeparators: [',', ' '],
            width: '100%',
            dropdownParent: $(".swal2-modal")
        });        
      },
    }).then((result) => {
      if(result.value) {
        axios.post(`api/article/#{id}/tags`)
             .then((res) => { console.table(res.data) })
             .catch((error) => { console.error(error) })
      }
    })    
  }

}
