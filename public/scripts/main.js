let buttonDay = document.querySelector("#day");
let buttonNight = document.querySelector("#night");
var background = document.querySelector("body").style;
var bgColor = document.querySelector("#dom-state").innerHTML;

(function backCheck() {
  if (bgColor === "day") {
    changeDisplayDay();
  } else {
    changeDisplayNight();
  }
})();

function changeDisplayNight() {
  document.querySelector("body").style.backgroundColor = "#221818";
  nav = document.querySelectorAll(".sign-in-sign-out");
  bgColor = document.querySelector("body");
    for (elements in nav) {
      nav[elements].style.backgroundColor = "";
      nav[elements].style.paddingLeft = "0";
      nav[elements].style.paddingTop = "0";
      nav[elements].style.borderBottom = "1px #67768F solid";
      nav[elements].style.borderRight = "1px #67768F solid";
  }
}

function changeDisplayDay() {
  document.querySelector("body").style.backgroundColor = "white";
  nav = document.querySelectorAll(".sign-in-sign-out");
    for (elements in nav) {
      nav[elements].style.backgroundColor = "white";
      nav[elements].style.borderBottom = "1px #67768F solid";
      nav[elements].style.borderRight = "1px #67768F solid";
  }
}

buttonDay.addEventListener("click", changeDisplayDay)
buttonNight.addEventListener("click", changeDisplayNight)

let closeButton = document.querySelector(".close-button")
let flashPanel = document.querySelector(".flash")

closeButton.addEventListener("click", event => {
  event.preventDefault()

  flashPanel.classList.add("hide")
})