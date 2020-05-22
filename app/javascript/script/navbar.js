$(document).on('turbolinks:load', function () {
  $('.plus').click( () => {
      $('.plus-block').removeClass('displaynone')
  })
  $('.search').click( () => {
    $('.search-block').removeClass('displaynone')
  })
  $('.plus-close').click( e => {
    e.stopPropagation();
    $('.plus-block').addClass('displaynone')
  })
  $('.search-close').click( e => {
    e.stopPropagation();
    $('.search-block').addClass('displaynone')
  })
  $('.burger').click( () => {
    $('.root-side-bar').removeClass('displaynone')
  })
  $('.user').click( () => {
    $('.user-list').toggleClass('displaynone')
  })
  $('.user-list-block').click( e => {
    e.stopPropagation();
  })
  $('.root-side-bar-close').click((e) => {
    e.preventDefault()
    $(e.currentTarget).parents('.root-side-bar').addClass('displaynone')
  })
})


