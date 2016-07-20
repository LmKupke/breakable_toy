$(function(){ $(document).foundation();
  $('.upvote').on("click",function() {
    event.preventDefault();
    var id = this.id.replace('up-vselect-', '');
    var path = '/api/venueselections/' + id + '/votes/upvote.json';
    var request = $.ajax({
      url: path,
      method: "POST",
      dataType: "json"
    });
    request.done(function(data) {
      var voteCount = document.getElementById('venue-sum-' + id);
      if(data < 0){
        $("span#venue-sum-"+ id).addClass("red").removeClass("black");
      } else {
        $("span#venue-sum-"+ id).addClass("black").removeClass("red");
      };
      voteCount.innerHTML = data;
    })
  });

  $('.downvote').on("click", function(){
    event.preventDefault();
    var id = this.id.replace('down-vselect-', '');
    var path = '/api/venueselections/' + id + '/votes/downvote.json';
    var request = $.ajax({
      url: path,
      method: "POST",
      dataType: "json"
    });
    request.done(function(data) {
      var voteCount = document.getElementById('venue-sum-' + id);
      if(data < 0){
        $("span#venue-sum-"+ id).addClass("red").removeClass("black");
      } else {
        $("span#venue-sum-"+ id).addClass("black").removeClass("red");
      };
      voteCount.innerHTML = data;
    })
  });
});
