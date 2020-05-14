import { Controller } from "stimulus"
import axios from "axios"

export default class extends Controller {
  static targets = [ "icon", "content" ]

  play(e) {
    e.preventDefault();
    console.log('hi')
    let content = this.contentTarget.value
    axios(
      {
        method: 'post',
        url: 'https://texttospeech.googleapis.com/v1/text:synthesize',
        headers:{
          "x-goog-api-key": "AIzaSyBZhcuNoTSKq2Pmp8G-Mt50f92ga1nPuXo",
          "content-type": "config/secrets/GCS-API-key.json",
        },
        data:{
          "input":{
            "text":`${content}`
          },
          "voice":{
            "languageCode":"cmn-TW",
            "name":"cmn-TW-Wavenet-A-Alpha",
            "ssmlGender":"FEMALE"
          },
          "audioConfig":{
            "audioEncoding":"MP3"
          }
        }
      }
    )
    
  }
  connect() {
    console.log('Hello, Stimulus!')
  }
}