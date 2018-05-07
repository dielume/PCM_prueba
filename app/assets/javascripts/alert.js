$(document).on('turbolinks:load', function(){
  $(".alert-dismissible").fadeTo(2000, 500).slideUp(500, function(){
      console.log('entro alerta');
      $(".alert-dismissible").alert('close');
  });
});
