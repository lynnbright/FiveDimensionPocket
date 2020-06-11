import './application.scss'

$(document).on('turbolinks:load', function() {
  $('#card-wrap .js-collapse-btn').on('click', function(e){
    e.preventDefault();
    $(this).siblings('.shared-bar:eq(0)').toggleClass('show')
  })


  $('.shared-conect-btn').on('click', function(e){
    e.preventDefault();
    let article_id = this.dataset.target;
    let $text = document.querySelector(article_id);

    $text.select();
    document.execCommand('copy');
  })
})
