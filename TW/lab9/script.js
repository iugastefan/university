window.onload = function() {
    // var x = document.getElementById('in')
    var flake = 'flake.svg.png'
    var flakes = []
    var out = document.getElementById('out')
    out.onclick = function(e) {
        // function getRandomColor() {
        //     var letters = '0123456789ABCDEF';
        //     var color = '#';
        //     for (var i = 0; i < 6; i++) {
        //         color += letters[Math.floor(Math.random() * 16)];
        //     }
        //     return color;
        // }
        // out.style.background = getRandomColor()

        var px = e.pageX;
        var py = e.pageY;
        var y = document.createElement('img');
        y.src = flake
        y.style.left = px + 'px'
        y.style.top = py + 'px'
        y.style.width = '90px'
        y.onclick = function(e) {
            y.parentNode.removeChild(y)
            flakes.splice(flakes.indexOf(y), 1)
            e.stopPropagation()
        }
        out.appendChild(y)
        flakes.push(y)

    }
    setInterval(function() {
        for (var i = 0; i < flakes.length; i++) {
            var f = flakes[i]
            if (parseInt(f.style.width.slice(0, -2)) >= 10) {
                if (parseInt(f.style.top.slice(0, -2)) > parseInt(window.getComputedStyle(out, null).getPropertyValue('height').slice(0, -2))-80) {
                    // f.className = "jos"
                    flakes.splice(i, 1)
                }
                f.style.width = (parseInt(f.style.width.slice(0, -2))) - 7 + 'px'
                f.style.top = (parseInt(f.style.top.slice(0, -2))) + 40 + 'px'
            } else {
                f.parentNode.removeChild(f)
                flakes.splice(i, 1)
            }
        }
        var y = document.createElement('img');
        y.src = flake
        var w = Math.floor((Math.random() * window.getComputedStyle(out, null).getPropertyValue('width').slice(0, -2)) + 1)

        var h = Math.floor((Math.random() * window.getComputedStyle(out, null).getPropertyValue('height').slice(0, -2) - 20) + 1)
        y.style.left = parseInt(w) + 'px'
        y.style.top = parseInt(h) + 'px'
        y.style.width = '90px'
        y.onclick = function(e) {
            y.parentNode.removeChild(y)
            flakes.splice(flakes.indexOf(y), 1)
            e.stopPropagation()
        }
        out.appendChild(y)
        flakes.push(y)

    }, 1000)

}
