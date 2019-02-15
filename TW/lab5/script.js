function myFc() {
    const b = document.getElementById('buton');
    const a = document.getElementById('intrare');
    let x = 2;
    // b.onclick = function () {
    //     let buton = document.createElement('button');
    //     let s = document.getElementById('sec');
    //     buton.textContent = "clicka ".repeat(x);
    //     x *= 2
    //     buton.onclick = function () {
    //         s.removeChild(buton)
    //     };
    //     s.appendChild(buton);
    // };
    // b.onclick = function () {
    //     let p = document.createElement("p");
    //     let t1 = document.createTextNode("continut ".repeat(Math.abs(x)));
    //     x *= x;
    //     p.appendChild(t1);
    //     let s = document.getElementById('sec');
    //     s.appendChild(p)
    // };
    let p = document.createElement("p");
    document.body.appendChild(p);
    b.onclick = function () {
        let c1 = document.getElementsByTagName('input');
        let c2 = document.querySelectorAll('input');
        let j = document.createElement("input");
        let s = document.getElementById('sec');
        s.appendChild(j);
        p.innerHTML = 'c1: ' + c1.length + ' c2: ' + c2.length;
        // alert('c1: ' + c1.length + ' c2: ' + c2.length);

        for(let w=0;w<c1.length;w++){
            if(w%2==0)
                c1[w].style.background="black"
            else
                c1[w].style.background="yellow"
        }
    }
}

window.onload = myFc;
