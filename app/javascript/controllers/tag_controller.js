import { Controller } from "stimulus"
import Rails from "@rails/ujs"


export default class extends Controller {
  static targets = [ "articleId" ]
 
  connect(){    

  }
  editTag(e) {
    let id = this.articleIdTarget.value
    let optionData = {}
    Swal.fire({
      title: "新增標籤",
      html: $(document).find('#tagSelect').html(),
      showCancelButton: true,
      showConfirmButton: true,
      onOpen: () => {
        console.log()
        $('[name="article[tag_list][]"]').select2({
            tags: true,
            tokenSeparators: [',', ' ']
        });   
        // 打api抓tag回來
        // Rails.ajax({
        //   url: `/api/v1/articles/${id}/gettags`, 
        //   type: 'POST', 
        //   data: data,
        //   success: resp => {
        //     resp.each
        //   }, 
        //   error: err => {
        //     console.log(err);
        //   } 
        //   })     
      },
    }).then((result) => {
      if(result.value) {   
        let optionData = $('[name="article[tag_list][]"] option:selected').toArray().map(item => item.text)
        let data = new URLSearchParams({list_tag: JSON.stringify(optionData)})
        Rails.ajax({
        url: `/api/v1/articles/${id}/tags`, 
        type: 'POST', 
        data: data,
        success: resp => {
          console.log(resp);
        }, 
        error: err => {
          console.log(err);
        } 
        })
      }
    })    
  }

}
