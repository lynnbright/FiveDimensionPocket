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
import Swal from 'sweetalert2'
window.Swal = Swal

import 'chart.js'
import 'chart.js/dist/Chart.css'
import Chart from 'chart.js'
window.Chart = Chart

import "controllers"
$(document).on('turbolinks:load', function(){

  //text-to-speech player 顯示
  $('#js-create-speech').click(function() {
    let $this = $(this);
    $this.removeClass('d-flex').addClass('d-none');
    $this.siblings('.loading').removeClass('d-none').addClass('d-inline-block')
  });


  //標題搜尋
  $('#test-input').on('change paste keyup', function(){
      let value = $(this).val();
      if(!value){
        // $('.title-search-style').html('');
        $('.title-search-style').html('');
      }
      else{
        searchCandidate(value); 
      }
      
      function searchCandidate(value){
        $('.title-search-style').html('.container .cards-area .card-title-search:not([data-title *="' + value + '"]) { display: none }');
      }
    })
});
