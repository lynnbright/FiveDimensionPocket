require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("styles")
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
$(document).on('turbolinks:load', function(){

  //text-to-speech player 顯示
  $('#js-create-speech').click(function() {
    let $this = $(this);
    $this.removeClass('d-flex').addClass('d-none');
    $this.siblings('.loading').removeClass('d-none').addClass('d-inline-block')
  });
  let $alert = $('#flash-alert')
  let text = $alert.find('.modal-body:eq(0)').text().trim()
  if (text.length > 0) {
    $alert.addClass('d-block')
    // $alert.css({
    //   background: 'rgba(255, 255, 255, 0.7)',
    //   display: 'block',
    //   width: '100%',
    //   transform: 'scaleY(3)',
    //   transition: 'transform 1s',
    //   'z-index': '99999999',
    //   'text-align': 'center'
    // })
  }
});

import "script/navbar.js"