window.onload = function() {
    let v = []
    for (let i = 0; i < 10; i++) {
        let node = document.createElement('button')
        v[i] = node
        node.innerHTML = "wtf" + i
        node.style.position = 'absolute'
        document.getElementsByTagName('body')[0].appendChild(node)
        node.onclick = function() {
            let id = setInterval(miscare, 1)
            var top = 0

            function miscare() {
                if (top == 500) {
                    clearInterval(id)
                    node.onclick()
                } else {
                    top++
                    node.style.top = top + 'px'
                    node.style.left = node.style.top
                    node.style.backgroundColor = '#' + top.toString(8)
                    node.style.color = '#' + top.toString(8)

                }
            }
            // node.onclick()
        }
    }
    for (let i = 0; i < 10; i++) {
        window.setTimeout(v[i].onclick(), 300)
    }
}
