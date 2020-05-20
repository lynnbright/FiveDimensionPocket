import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {  
  connect(){
    Rails.ajax({
      url: `api/v1/charts/tag`, 
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
              data: tagData,
              backgroundColor: [
                'rgba(255, 99, 132, 0.8)',
                'rgba(54, 162, 235, 0.8)',
                'rgba(255, 206, 86, 0.8)',
                'rgba(75, 192, 192, 0.8)',
                'rgba(153, 102, 255, 0.8)',
                'rgba(255, 159, 64, 0.8)'
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
    Rails.ajax({
      url: `api/v1/charts/read`, 
      type: 'GET', 
      success: resp => {
        let readLabels = Object.keys(resp.read);  
        let readData = Object.values(resp.read); 
        let ctxRead = document.getElementById('readChart').getContext('2d');        
        let readChart = new Chart(ctxRead, {
          type: 'line',
          data: {
            labels: readLabels,
            datasets: [{
              label: '篇數',
              data: readData,
              fill: false,
              backgroundColor: [
                  'rgba(255, 99, 132, 0.9)',
                  'rgba(54, 162, 235, 0.9)',
                  'rgba(255, 206, 86, 0.9)',
                  'rgba(75, 192, 192, 0.9)',
                  'rgba(153, 102, 255, 0.9)',
                  'rgba(255, 159, 64, 0.9)'
              ],
              borderColor: [
                  'rgba(255, 99, 132, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(255, 206, 86, 1)',
                  'rgba(75, 192, 192, 1)',
                  'rgba(153, 102, 255, 1)',
                  'rgba(255, 159, 64, 1)'
              ],
              borderWidth: 3,
              borderStyle:'dash'
            }]
          },
          options: {
            responsive: true,            
            scales: {
              yAxes: [{
                ticks: {
                  beginAtZero:true,
                  stepSize: 1,
                  max: Math.max(...readData) + 2
                }
              }]
            }
          }
        });        
      },
      error: err => {
        console.log(err);
      } 
    }) 

  }
}
