import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  // static targets = [ "articleId" ]
  
  connect(){
    Rails.ajax({
      url: `/charts/tagchart`, 
      type: 'GET', 
      success: resp => {
        let tagLabels =  resp.tags.map(item => item["name"]);
        let tagData = resp.tags.map(item => item["counter"]);  
        let ctxTag = document.getElementById('tagChart').getContext('2d');
        let tagChart = new Chart(ctxTag, {
          type: 'pie',
          data: {
            labels: tagLabels,
            datasets: [{
              label: '# of Votes',
              data: tagData,
              backgroundColor: [
                  'rgba(255, 99, 132, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(255, 206, 86, 0.2)',
                  'rgba(75, 192, 192, 0.2)',
                  'rgba(153, 102, 255, 0.2)',
                  'rgba(255, 159, 64, 0.2)'
              ],
              borderWidth: 1
            }]
          },
          options: {
            responsive: true
          }
        });          
      },
      error: err => {
        console.log(err);
      } 
    }) 
    // Rails.ajax({
    //   url: `/charts/tagchart`, 
    //   type: 'GET', 
    //   success: resp => {
    //     let timeLabels =  resp.tags.map(item => item["name"]);
    //     let readedData = resp.tags.map(item => item["counter"]);
    //     let ctxReaded = document.getElementById('readedChart').getContext('2d');        
    //     let readedChart = new Chart(ctxReaded, {
    //       type: 'line',
    //       data: {
    //         labels: timeLabels,
    //         datasets: [{
    //           label: '# of Votes',
    //           data: readedData,
    //           fill: false,
    //           backgroundColor: [
    //               'rgba(255, 99, 132, 0.2)',
    //               'rgba(54, 162, 235, 0.2)',
    //               'rgba(255, 206, 86, 0.2)',
    //               'rgba(75, 192, 192, 0.2)',
    //               'rgba(153, 102, 255, 0.2)',
    //               'rgba(255, 159, 64, 0.2)'
    //           ],
    //           borderColor: [
    //               'rgba(255, 99, 132, 1)',
    //               'rgba(54, 162, 235, 1)',
    //               'rgba(255, 206, 86, 1)',
    //               'rgba(75, 192, 192, 1)',
    //               'rgba(153, 102, 255, 1)',
    //               'rgba(255, 159, 64, 1)'
    //           ],
    //           borderWidth: 1
    //         }]
    //       },
    //       options: {
    //         responsive: true
    //       }
    //     });        
    //   },
    //   error: err => {
    //     console.log(err);
    //   } 
    // }) 

  }
}
