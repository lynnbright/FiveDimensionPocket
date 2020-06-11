import './application.scss'

$(document).on('turbolinks:load', function() {
  $('#card-wrap .js-collapse-btn').on('click', function(e){
    e.preventDefault();
    $(this).siblings('.shared-bar:eq(0)').toggleClass('show')
    // $('.shared-bar').toggleClass('show')
  })

  // $('.shared-conect-btn').on('click', function(e){
  //   e.preventDefault();
  //   let url = $(this).parent().find('.copylink:eq(0)').val()

  // })

  $('.shared-conect-btn').on('click', function(e){
    e.preventDefault();
    let article_id = this.dataset.target;
    let $text = document.querySelector(article_id);

    $text.select();
    document.execCommand('copy');
  })
})


// function copyToClip(str) {
//   function listener(e) {
//     e.clipboardData.setData("text/html", str);
//     e.clipboardData.setData("text/plain", str);
//     e.preventDefault();
//   }
//   document.addEventListener("copy", listener);
//   document.execCommand("copy");
//   document.removeEventListener("copy", listener);
// };