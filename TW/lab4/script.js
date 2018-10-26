let x = 0;

function myFc() {
  const id = document.getElementById('cub');

  function enlarge() {
    id.style.width = '1080px';
    id.style.borderColor = 'red';
    id.style.borderWidth = '10px';
    id.style.borderRadius = '100px';
    x = 1;
    document.getElementById('cub').removeEventListener('click', enlarge);
    myFc();
  }

  function micsorare() {
    id.style = 'initial';
    x = 0;
    document.getElementById('cub').removeEventListener('click', micsorare);
    myFc();
  }
  if (x === 0) {
    document.getElementById('cub').addEventListener('click', enlarge);
  } else {
    document.getElementById('cub').addEventListener('click', micsorare);
  }
}
window.onload = myFc;
