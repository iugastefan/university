var x = 0;
function menu() {
    if (x == 0) {
        document.getElementsByTagName('aside')[0].style.visibility = 'visible';
        x++;
    }
    else {
        document.getElementsByTagName('aside')[0].style.visibility = 'hidden';
        x--;
    }
}
function image() {
    var images = ['Chris_Rorland.jpg', 'Hannes_Van_Dahl.jpg', 'Joakim_Broden.jpg',
        'Par_Sundstrom.jpg', 'Tommy_Johansson.jpg', 'Download_Festival_Australia.jpg',
        'Sabaton_Open_Air_Festival.jpg', 'Wargaming_Office_in_Chicago.jpg', 'World_Memorial_Hall.jpg']
    for (i = 0; i < images.length; i++) {
        let f = document.createElement('figure')
        let im = document.createElement('img')
        im.src = 'img/' + images[i]
        let fc = document.createElement('figcaption')
        fc.innerText = images[i].slice(0, -4).split('_').join(' ')
        f.appendChild(im)
        f.appendChild(fc)
        document.getElementsByTagName('main')[0].appendChild(f)
    }
}
function windowInit() {
    document.getElementById('burger').onclick = menu
    if (document.getElementsByTagName('title')[0].innerText == 'Project - Photos')
        image()
}
window.onload = windowInit;
