// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$('.phonenumber.small.button').on("click",function() {
  event.preventDefault();
  $('.phonenumber.small.button').hide();
  $('.phonenumber-form').show();
});
