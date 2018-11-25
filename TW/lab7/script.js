window.onload = function() {
    var u = document.querySelector('ul');
    var l = u.firstElementChild;
    l.onclick = function() {
        // alert(u.childNodes.length + ' ' + u.children.length);
        // alert(l.innerHTML);
        // u.innerHTML += '<li>li nou </li>';
        // u.appendChild(l);
        if (!l.classList.contains('a'))
            l.classList.add('a');
        else {
            if (!l.classList.contains('b'))
                l.classList.add('b');
            else {
                if (!l.classList.contains('c'))
                    l.classList.add('c');
                else{
                    l.classList.remove('a','b','c');
                }
            }
        }
    };
};
