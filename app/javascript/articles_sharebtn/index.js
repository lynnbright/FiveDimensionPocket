import './application.scss'

$(document).on('turbolinks:load', function() {
  $('#card-wrap .js-collapse-btn').on('click', function(e){
    e.preventDefault();
    // $(this).siblings('.shared-bar:eq(0)').toggleClass('show')
    $('.shared-bar').toggleClass('show')
  })
})