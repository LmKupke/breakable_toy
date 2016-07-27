// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
setInterval(function() {
  $.getJSON('/newsfeeds.json', function(newsfeed) {
    // code to remove old posts
    // code to insert new posts
    debugger;
  });
}, 5000);
