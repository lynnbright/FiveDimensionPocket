import './application.scss'
import '@fortawesome/fontawesome-free/css/all.css'



$(document).on('turbolinks:load', function(){

  //標題搜尋
  $('#search-input').on('change paste keyup', function(){
      // let value = $(this).val().toLowerCase();
      let value = $(this).val();

      if(!value){
        $('.title-search-style').html('');
      }
      else{
        searchCandidate(value); 
      }
      
      function searchCandidate(value){   
        // let title = $('.card-title-search').data('title').toLowerCase();
        // $('.card-title-search').attr({ 'data-title': `${title}` });     
        $('.title-search-style').html('.container .cards-area .card-title-search:not([data-title *="' + value + '"]) { display: none }');
      }
    })
});