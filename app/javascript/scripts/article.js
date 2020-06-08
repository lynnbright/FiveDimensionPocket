$(document).on('turbolinks:load', function(){

  //text-to-speech player 顯示
  $('#js-create-speech').click(function() {
    let $this = $(this);
    $this.removeClass('d-flex').addClass('d-none');
    $this.siblings('.loading').removeClass('d-none').addClass('d-inline-block')
  });

  //flash alert 顯示
  let $alert = $('#flash-alert')
  let text = $alert.find('.modal-body:eq(0)').text().trim()
  if (text.length > 0) {
    $alert.addClass('show')
  }

  //單篇文章上的返回鍵
  $('.inner-page-back-arrow').click(function(e){
    e.preventDefault();
  })
});