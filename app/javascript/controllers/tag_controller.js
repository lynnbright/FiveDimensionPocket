import { Controller } from "stimulus"

export default class extends Controller {
  // static targets = [ "tagSelect" ]
 
  connect(){    

  }
  editTag(e) {
    Swal.fire({
      title: "title",
      html: document.querySelector('#tagSelect').innerHTML,
      showCancelButton: true,
      showConfirmButton: true,
      onOpen: function (dObj) {
        $('[name="select2-multiple"]').select2({
            tags: true,
            tokenSeparators: [',', ' '],
            width: '100%',
            dropdownParent: $(".swal2-modal")
        });
      }
    });     
  }

}
