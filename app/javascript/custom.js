import $ from 'jquery'
import Dropzone from 'dropzone'

$(function() {
  $('.tagsinput').tagsInput();
  $('.select2').select2({
    theme: 'bootstrap4'
  });
})

Dropzone.options.imageUpload = {
  paramName: "[gallery]image", // The name that will be used to transfer the file
  maxFilesize: 2, // MB
  acceptedFiles: '.jpeg,.jpg,.png,.gif',
  success: function(file, done) {
   console.log(done)
   $('.gallery').append('<div class="col-md-3" id="item_'+ done.id +'"></div>')
   $("#item_" + done.id).load('/backoffice/galleries/' + done.id);
  }
};

