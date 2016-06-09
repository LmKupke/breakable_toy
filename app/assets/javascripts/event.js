// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  $('#dpt').datepicker({
    gotoCurrent: true,
    dateFormat: "yy/mm/dd",
    minDate: 0
  });
  var options = {
    twentyFour: false,
    upArrow: 'wickedpicker__controls__control-up',
    downArrow: 'wickedpicker__controls__control-down',
    close: 'wickedpicker__close',
    hoverState: 'hover-state'
  }

  $('#timepicker').wickedpicker(options);
});
