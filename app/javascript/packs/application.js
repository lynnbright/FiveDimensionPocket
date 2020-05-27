require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("styles")
require("scripts")
require("articles_sharebtn")

import $ from 'jquery'
window.$ = window.jquery = $

import 'bootstrap/dist/js/bootstrap.js'
import 'bootstrap/dist/css/bootstrap.min.css'


import "@fortawesome/fontawesome-free/js/all"

import 'select2'
import 'select2/dist/css/select2.css'

import 'sweetalert2'

import 'chart.js'
import 'chart.js/dist/Chart.css'


import "controllers"


// $(document).on('turbolinks:load', function(){
//   $("#sidebarToggle, #sidebarToggleTop").on('click', function(e) {
//     console.log('hihi');
//     $("body").toggleClass("sidebar-toggled");
//     $(".sidebar").toggleClass("toggled");
//     if ($(".sidebar").hasClass("toggled")) {
//       $('.sidebar .collapse').collapse('hide');
//     };
//   });
// })