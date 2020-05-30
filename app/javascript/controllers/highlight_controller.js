import { Controller } from "stimulus"
import Rails from "@rails/ujs"
import Swal from 'sweetalert2'

function placeTooltip(x_pos, y_pos, type) {
  // 增加一個後面可以用來判斷的，name或其他
  var d = document.getElementById('tooltip');
  if (type === "new") {
    d.setAttribute  = 'btn newHighlight'
    d.innerHTML = `<i class="fas fa-pen"></i>HighLight`;
  } else {
    d.className  = 'btn delHighlight'
    d.innerHTML = `<i class="far fa-trash-alt"></i>刪除`;
  }
  d.style.position = "absolute";
  d.style.left = x_pos + 'px';
  d.style.top = (y_pos - 40) + 'px';
}

export default class extends Controller {
  static targets = ["articleId"]
  connect(){
    let id = this.articleIdTarget.value
    var selObj = null;
    var selRange = null;
    var rect = null;
    var x = 0;
    var y = 0;
    var oContent = document.getElementById('content');
    var counter = 0
    // 載入頁面時先透過ajax要標記資料
    var article_child = document.getElementById('article').querySelectorAll('p');
    Rails.ajax({
      url: `/api/v1/articles/${id}/highlight`,
      type: 'GET',
      success: resp => {
        // 更新本頁標記數量
        console.log(resp.highlights)
        counter = resp.highlights.length
        resp.highlights.forEach(function(data, index) {
          let p_index = data.paragraph_index
          let words = data.content
          let id = data.element_id
          article_child[p_index].innerHTML = article_child[p_index].innerHTML.replace(new RegExp(words, "g"), `<span class="highlight" data-action="mouseover->highlight#showTooltip" id=${id}>${words}</span>`);
        });
      },
      error: err => {
        console.log(err);
      }
    })

    oContent.onmouseup = (e) => {
      selObj = window.getSelection();
      selRange = selObj.getRangeAt(0);
      rect = selRange.getBoundingClientRect();
      x = e.pageX;
      y = e.pageY + 5;
      if (rect.width > 4) {
        placeTooltip(x, y, "new");
        document.getElementById("tooltip").classList.remove('notDisplayed');
      }
      else {
        document.getElementById("tooltip").classList.add('notDisplayed');
        document.getElementById("tooltip").style = '';
      }
    };
    document.getElementById("tooltip").addEventListener("click", function (event) {
      // 選三筆之後就不能標記
      if (counter > 3) {
        Swal.fire('一般會員只能標記三筆喔')
      } else {
        highlightRange(selRange, counter++);
      }
      document.getSelection().removeAllRanges()
      document.getElementById("tooltip").classList.add('notDisplayed');
      document.getElementById("tooltip").style = '';
    }, false);

    function highlightRange(range, counter) {
      // 如何把特定的ele的位置抓出來
      let newNode = document.createElement("span");
      newNode.classList.add('highlight');
      newNode.id = (`highlight${counter}`);
      range.surroundContents(newNode);
      let el = document.getElementById(`highlight${counter}`).parentElement;
      let index = [].indexOf.call(el.parentElement.children, el);
      let myData = {
        content: document.getElementById(`highlight${counter}`).innerText,
        element_id: `highlight${counter}`,
        paragraph_index: index
      }
      console.log(el.parentElement.children)
      console.log(myData)
      Rails.ajax({
        url: `/api/v1/articles/${id}/highlight`,
        type: 'POST',
        data: new URLSearchParams(myData).toString(),
        success: resp => {
          // console.log(resp)
        },
        error: err => {
          console.log(err);
        }
      })
    }
    // 參考資料:https://stackoverflow.com/questions/25695212/jquery-how-to-tag-selected-text-using-textbox-as-tooltip
  }
  showTooltip(e) {
    var x = e.pageX;
    var y = e.pageY + 5;
    placeTooltip(x, y, "delete");
  }
  hideTooltip() {
    document.getElementById("tooltip").classList.remove('notDisplayed');
    document.getElementById("tooltip").style = '';
  }
}