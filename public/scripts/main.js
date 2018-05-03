let buttonDay = document.querySelector("#day");
let buttonNight = document.querySelector("#night");

function changeDisplayNight() {
  document.querySelector("body").style.backgroundColor = "#221818";
  nav = document.querySelectorAll(".sign-in-sign-out");
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
      nav[elements].style.backgroundColor = "lightgrey";
      nav[elements].style.paddingLeft = "0.5vw";
      nav[elements].style.paddingTop = "0.5vw";
      nav[elements].style.border = "0";
  }
}

// function hovColor(x) {
//   x.style.color = "black";
// }

// function hovColorBack(x) {
//   x.style.color = "#67768F";
// }

buttonDay.addEventListener("click", changeDisplayDay)
buttonNight.addEventListener("click", changeDisplayNight)

// document.getElementsByClassName(".sign-in-sign-out").addEventListener("mouseover", function() {
//   if (document.querySelector("body").style.backgroundColor === "white") {
//     alert("I'm a mouseover");
//     document.querySelector(".sign-in-sign-out").style.color = "black";
//   }
// })