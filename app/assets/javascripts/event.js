// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  $('#dpt').datepicker({
    gotoCurrent: true,
    dateFormat: "yy/mm/dd",
    minDate: 0
  });
  $('#timepicker').wickedpicker();
});
