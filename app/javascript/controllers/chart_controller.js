import { Controller } from "stimulus"
import Rails from "@rails/ujs"
import Chart from 'chart.js'

function getColors(length){
  let pallet = ["#f694c1", "#fec3a6","#FFFFAD","#d3f8e2","#a9def9","#e4c1f9"];
  let colors = [];

  for(let i = 0; i < length; i++) {
    colors.push(pallet[i % pallet.length]);
  }

  return colors;
}

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
              backgroundColor: getColors(tagData.length),
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
              backgroundColor: getColors(readData.length),
              borderColor: "#fec3a6",
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
