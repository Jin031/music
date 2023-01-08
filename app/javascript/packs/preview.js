if (document.URL.match(/new/)){
  document.addEventListener('DOMContentLoaded', () => {
    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('new-image');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('class', 'new-img')
      blobImage.setAttribute('src', blob);
      imageElement.appendChild(blobImage);
    };

    document.getElementById('post_images').addEventListener('change', (e) => {
     document.getElementById('new-image').innerHTML="";
      // original
      // アップロードした画像の一枚目
      //const file = e.target.files[0];
      //const blob = window.URL.createObjectURL(file);
      //createImageHTML(blob);

      //after
      const files = e.target.files
      Array.from(files).map(file => {
        const blob = window.URL.createObjectURL(file);
        createImageHTML(blob);
      })
    });
  });
}