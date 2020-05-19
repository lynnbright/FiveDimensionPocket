$('document').ready( () => {
  $('.Plus').click( () => {
      $('.PlusBlock').removeClass('displaynone')
  })
  $('.Search').click( () => {
    $('.SearchBlock').removeClass('displaynone')
  })
  $('.PlusClose').click( (e) => {
    e.stopPropagation();
    $('.PlusBlock').addClass('displaynone')
  })
  $('.SearchClose').click( e => {
    e.stopPropagation();
    $('.SearchBlock').addClass('displaynone')
  })
  $('.burger').click( () => {
    $('.SideBar').removeClass('displaynone')
  })
})

