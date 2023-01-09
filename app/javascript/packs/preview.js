if (document.URL.match(/new|customers\/sign_up|customers\/\d{1,3}\/edit/g)){
  document.addEventListener('DOMContentLoaded', () => {
    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('new-image');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('class', 'new-img')
      blobImage.setAttribute('src', blob);
      imageElement.appendChild(blobImage);
    };

    if (document.getElementById('post_images') != null) {
      document.getElementById('post_images').addEventListener('change', (e) => {
     document.getElementById('new-image').innerHTML="";

      const files = e.target.files
      Array.from(files).map(file => {
        const blob = window.URL.createObjectURL(file);
        createImageHTML(blob);
      })
    });
    } else if (document.getElementById('customer_profile_image') != null) {
       document.getElementById('customer_profile_image').addEventListener('change', (e) => {
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
    } else {

    }
  });
}