function menu(x) {
    if (x === 0) {
        document.getElementsByTagName('aside')[0].style.animationName = 'aside';
        document.getElementsByTagName('aside')[0].style.visibility = 'visible';
    } else {
        if (document.getElementsByTagName('aside')[0].style.animationName === 'aside')
            document.getElementsByTagName('aside')[0].style.animationName = 'aside2';
    }
}

function submenu() {
    if (
        document.getElementById('submenu').style.display === ''
    ) {
        document.getElementById('submenu').style.display = 'block';
        document.getElementById('toggle-menu').innerText = '-';
    } else {
        document.getElementById('submenu').style.display = '';
        document.getElementById('toggle-menu').innerText = '+';
    }
}

function image() {
    const images = ['Chris_Rorland.jpg', 'Hannes_Van_Dahl.jpg', 'Joakim_Broden.jpg',
        'Par_Sundstrom.jpg', 'Tommy_Johansson.jpg', 'Download_Festival_Australia.jpg',
        'Sabaton_Open_Air_Festival.jpg', 'Wargaming_Office_in_Chicago.jpg', 'World_Memorial_Hall.jpg'
    ];
    for (let i = 0; i < images.length; i++) {
        let f = document.createElement('figure');
        let im = document.createElement('img');
        im.src = 'img/' + images[i];
        let fc = document.createElement('figcaption');
        fc.innerText = images[i].slice(0, -4).split('_').join(' ');
        f.appendChild(im);
        f.appendChild(fc);
        document.getElementsByTagName('main')[0].appendChild(f);
    }
}

function key(event) {
    if (event.defaultPrevented) {
        return;
    }
    if (event.key === 'ArrowUp' || event.key === 'ArrowLeft' || event.key === 'ArrowRight')
        event.preventDefault();
    const key = event.key || event.keyCode;
    const pages = ['home.html', 'history.html', 'photos.html', 'awards.html'];
    if (key === 'ArrowUp') {
        window.location.href = pages[0]
    } else if (key === 'ArrowLeft') {
        const loc = window.location.href.split('/').slice(-1)[0];
        if (pages.indexOf(loc) !== 0)
            window.location.href = pages[pages.indexOf(loc) - 1];
    } else if (key === 'ArrowRight') {
        const loc = window.location.href.split('/').slice(-1)[0];
        if (pages.indexOf(loc) !== pages.length - 1)
            window.location.href = pages[pages.indexOf(loc) + 1];
    }
}

function screensaver() {
    const img = document.createElement('img');
    img.src = 'img/screensaver.gif';
    img.alt = 'screensaver';
    img.style.width = screen.width + 'px';
    img.style.zIndex = '9';
    img.style.position = 'fixed';
    img.style.top = '0px';
    let id = setInterval(function () {
        let body = document.getElementsByTagName('body')[0];
        body.appendChild(img);
    }, 20000);
    img.addEventListener('mousemove', function () {
        this.parentNode.removeChild(this);
        clearInterval(id);
        screensaver();
    });
}

function clock(clockDiv) {
    let date = new Date();
    let number = function (x) {
        return ('0' + x).slice(-2)
    };
    clockDiv.innerText = number(date.getHours()) + ":" + number(date.getMinutes()) + ":" + number(date.getSeconds());
    setInterval(function (clock) {
        let date = new Date();
        clock.innerText = number(date.getHours()) + ":" + number(date.getMinutes()) + ":" + number(date.getSeconds());
    }, 1000, clockDiv);
    clockDiv.addEventListener('click', clockDiv.random)

}

function rememberScroll() {
    let scroll = localStorage.getItem('scroll');
    if (scroll !== null) {
        window.scrollTo(0, parseInt(scroll));
    }
}

function sideAnimation() {
    let side = document.getElementsByTagName('aside')[0];
    let style = window.getComputedStyle(side);
    side.style.left = -(parseInt(style.width.slice(0, -2)) + parseInt(style.borderRightWidth.slice(0, -2))) + 'px'
}

function dragDrop() {
    let input = document.getElementsByTagName('input')[0];
    if (input !== null) {
        input.addEventListener('drop', function (ev) {
            ev.preventDefault();
            input.value = ev.dataTransfer.getData('html');
        })
    }
    let menu = document.getElementById('menu');
    Array.prototype.forEach.call(menu.childNodes, function (child) {
        child.draggable = 'true';
        child.addEventListener('dragstart', function (ev) {
            ev.dataTransfer.setData('html', ev.currentTarget.outerHTML)
        })
    })

}

function windowInit() {
    document.getElementById('burger').addEventListener('mouseover', function () {
        menu(0);
    });
    document.getElementsByTagName('main')[0].addEventListener('mouseover', function () {
        menu(1);
    });
    document.getElementById('toggle-menu').addEventListener('click', function () {
        submenu();
    });
    if (document.getElementsByTagName('title')[0].innerText === 'Project - Photos')
        image();
    document.getElementsByTagName('html')[0].addEventListener('keydown', function (event) {
        key(event);
    });

    if (screen.width > 1224)
        screensaver();


    let clockDiv = document.getElementById('clock');
    clockDiv.random = function () {
        let val = Math.floor(Math.random() * 999999 + 100000).toString();
        this.innerText = val.substr(0, 2) + ':' + val.substr(2, 2) + ':' + val.substr(4, 2);
    };
    clock(clockDiv);

    window.addEventListener('scroll', function () {
        localStorage.setItem('scroll', window.pageYOffset.toString())
    });
    rememberScroll();
    sideAnimation();
    window.addEventListener('resize', sideAnimation);

    dragDrop();

}

window.onload = windowInit;
