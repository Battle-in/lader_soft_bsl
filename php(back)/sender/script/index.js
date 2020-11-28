let menu = document.querySelector('.menu img');
let slideMenu = document.querySelector('.slideMenu');

menu.addEventListener('click' , onMenu);

function onMenu(e) {
    menu.classList.toggle('menu__rot');
    slideMenu.classList.toggle('hide');
}



