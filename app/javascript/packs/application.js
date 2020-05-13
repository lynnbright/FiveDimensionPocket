require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("styles")


import $ from 'jquery'
window.$ = $


import 'bootstrap/dist/js/bootstrap.js'
import 'bootstrap/dist/css/bootstrap.min.css'

import "@fortawesome/fontawesome-free/js/all"

import 'select2'
import 'select2/dist/css/select2.css'

import 'sweetalert2'
import Swal from 'sweetalert2'
window.Swal = Swal

$(document).on('turbolinks:load', function(){
  $("#show_modal_btn").click(function(){
    console.log("I will open modal");
    $("#myModal").modal("show");
  });
});

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "controllers"
