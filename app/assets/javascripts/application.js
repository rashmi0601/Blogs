//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require quill/dist/quill

document.addEventListener("turbolinks:load", () => {
    const editorElement = document.querySelector('#editor');
    if (editorElement) {
      const quill = new Quill(editorElement, {
        theme: 'snow',
        placeholder: 'Your blog contents here...',
        modules: {
          toolbar: [
            [{ header: [1, 2, 3, false] }],
            ['bold', 'italic', 'underline', 'strike'],
            [{ list: 'ordered' }, { list: 'bullet' }],
            ['link', 'image'],
            ['clean'], 
          ],
        },
      });
  
      const hiddenContent = document.querySelector('#hidden-content');
      if (hiddenContent.value) {
        quill.root.innerHTML = hiddenContent.value;
      }
  
      const form = document.querySelector('form');
      form.addEventListener('submit', () => {
        hiddenContent.value = quill.root.innerHTML; 
      });
    }
  });
  