const btnPrint = document.getElementById("print-btn");
const wrapBox = document.getElementById("type-js");
const typingText = document.querySelector(".text-js");
let newString = "";
const typingSpeed = 200;

document.addEventListener("DOMContentLoaded", function () {
  btnPrint.addEventListener("click", doPrint);
  autoType();
});

function doPrint() {
  window.print();
}

function autoType() {
  let text = wrapBox.textContent.trim().split('');

  wrapBox.insertAdjacentHTML('afterbegin', '<div class="cursor" style="right: initial; left:0;"></div>');
  typingText.style.opacity = 1;
  typingText.previousElementSibling.removeAttribute("style");
  typingText.textContent = "";

  let amntOfChars = text.length;

  for (let i = 0; i < amntOfChars; i++) {
    let char = text[i];
    getChar(i + 1, text[i]);
  }
}

function getChar(i, char) {
  setTimeout(function () {
    newString += char;
    typingText.textContent = newString;
  }, i * typingSpeed);
}