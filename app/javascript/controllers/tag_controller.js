import { Controller } from "stimulus"
import Rails from "@rails/ujs"
import Swal from 'sweetalert2'

// URLSearchParams轉成網址上參數，可以再開一個fun先整理成object
// let data = new URLSearchParams({list_tag: JSON.stringify(optionData)})
function toFormData(params) {
  let ConverToString = function(rs, key){      
    rs[key] = JSON.stringify(params[key])
    return rs;    
  };
  let rs = Object.keys(params).reduce(ConverToString, {})
  return new URLSearchParams(rs)
}

export default class extends Controller {
  static targets = [ "articleId" ]

  editTag(e) {
    e.preventDefault();
    let id = this.articleIdTarget.value
    Swal.fire({
      title: "新增標籤",
      html: $(document).find('#tagSelect').html(),
      showCancelButton: true,
      showConfirmButton: true,
      onOpen: () => {
        Rails.ajax({
          url: `/api/v1/articles/${id}/tags`, 
          type: 'GET', 
          success: resp => {
            let tags = resp.tags;
            tags.forEach( (tagName) => {
              let option = document.createElement("option");
              option.setAttribute("selected", "selected");
              option.innerText = "";
              option.innerText = tagName;
              document.querySelector('[name="article[tag_list][]"]').appendChild(option)
            });           
          },
          error: err => {
            console.log(err);
          } 
        }) 
        $('[name="article[tag_list][]"]').select2({
            tags: true,
            createTag: function(params) {
              if (/[, ]/.test(params.term)) {
                  var str = params.term.trim().replace(/[, ]*$/, '');
                  return { id: str, text: str }
              } else {
                  return null;
              }
            }    
        });   
      },
    }).then((result) => {
      if(result.value) {   
        let optionData = $('[name="article[tag_list][]"] option:selected').toArray().map(item => item.text)
        let data = new FormData()
        if (optionData.length < 1){
          data.append('tag_list[]', '')          
        }else {
          optionData.forEach((v) => {
            data.append('tag_list[]', v)
          })
        }
        Rails.ajax({
        url: `/api/v1/articles/${id}/tags`, 
        type: 'POST', 
        data: data,
        success: resp => {
        }, 
        error: err => {
          console.log(err);
        } 
        })
      }
    })    
  }
}
