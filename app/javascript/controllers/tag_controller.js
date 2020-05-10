import { Controller } from "stimulus"

export default class extends Controller {
  // static targets = [ "id" ]
  static html='<select name="select2-multiple" multiple="multiple" class="form-control"></select>'

  connect(){    
    
  }
  editTag(e) {
    Swal.fire({
      title: "title",
      html: html,
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
