$('document').ready( () => {
  $('.Plus').click( () => {
      $('.PlusBlock').removeClass('displaynone')
  })
  $('.Search').click( () => {
    $('.SearchBlock').removeClass('displaynone')
  })
  $('.PlusClose').click( e => {
    e.stopPropagation();
    $('.PlusBlock').addClass('displaynone')
  })
  $('.SearchClose').click( e => {
    e.stopPropagation();
    $('.SearchBlock').addClass('displaynone')
  })
  $('.Burger').click( () => {
    $('.RootSideBar').removeClass('displaynone')
  })
  $('.User').click( () => {
    $('.UserList').toggleClass('displaynone')
  })
  $('.RootSideBarClose').click( () => {
    $('.RootSideBar').addClass('displaynone')
  })
  $('.UserListBlock').click( e => {
    e.stopPropagation();
  })
})

