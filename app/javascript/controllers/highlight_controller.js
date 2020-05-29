import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {  
  static targets = [ "articleId" ]
connect(){
  let id = this.articleIdTarget.value

  var selObj = null;
  var selRange = null;
  var rect = null;
  var x = 0;
  var y = 0;
  var oContent = document.getElementById('content');
  // counter要計算葉面中highlight的個數，沒有就預設0
  // 寫一個fun去計算當下頁面有幾個標記

  var counter = 0;
  var article_child = document.getElementById('article').querySelectorAll('p');
  // 找到對應段落index，把儲存的文字取代成有hightligh的id的

  var content = "We need to give this "
  var element_id = "highlight3"
  var paragraph_index = 1

  article_child[paragraph_index].innerHTML = article_child[paragraph_index].innerHTML.replace(new RegExp(content, "g"), `<span class="highlight" id=${element_id}>${content}</span>`);

  oContent.onmouseup = (e) => {
    selObj = window.getSelection();
    selRange = selObj.getRangeAt(0);
    rect = selRange.getBoundingClientRect();
    x = e.pageX;
    y = e.pageY + 5;
    if (rect.width > 1) {
      placeTooltip(x, y);
      document.getElementById("tooltip").classList.remove('notDisplayed');
    }
    else {
      document.getElementById("tooltip").classList.add('notDisplayed');
      document.getElementById("tooltip").style = '';
    }
  };
  document.getElementById("tooltip").addEventListener("click", function (event) {
    // 選三筆之後就不能標記
    if (counter > 2) {
      //~~~~~ 換sweetalert ~~~~~~~
      alert("一般會員只能標記三筆喔");
    } else {
      highlightRange(selRange, counter++);
    }
    document.getSelection().removeAllRanges()
    document.getElementById("tooltip").classList.remove('notDisplayed');
    document.getElementById("tooltip").style = '';
  }, false);

  function placeTooltip(x_pos, y_pos) {
    var d = document.getElementById('tooltip');
    d.style.position = "absolute";
    d.style.left = x_pos + 'px';
    d.style.top = (y_pos - 40) + 'px';
  }
  function highlightRange(range) {
    var newNode = document.createElement("span");
    newNode.classList.add('highlight');
    newNode.id = (`highlight${counter}`);
    range.surroundContents(newNode);
    var el = document.getElementById(`highlight${counter}`).parentElement;
    var index = [].indexOf.call(el.parentElement.children, el);
    var myData = {
      content: document.getElementById(`highlight${counter}`).innerText,
      element_id: `highlight${counter}`,
      paragraph_index: index
      }
      
    console.log(myData)
    Rails.ajax({
      url: `/api/v1/articles/${id}/highlight`,
      type: 'POST',
      data: new URLSearchParams(myData).toString(),
      success: resp => {
        console.log(resp)
      },
      error: err => {
        console.log(err);
      }
    })
  }
  // 參考資料:https://stackoverflow.com/questions/25695212/jquery-how-to-tag-selected-text-using-textbox-as-tooltip

  }
}