import { Controller } from "stimulus"
import $ from 'jquery'

export default class extends Controller {
  static targets = [ "tagList" ]

  connect(){
    Swal.fire(
      'The Internet?',
      'That thing is still around?',
      'question'
    )
  }
  editTag(e) {

  }

  openModal(e) {
  }
}
