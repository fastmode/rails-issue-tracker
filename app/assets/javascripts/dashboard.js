$(document).on('turbolinks:load', function() {

  // Uses JSON to render all open tickets
  $("#open-tickets").text("")
  $(function () {
    $.getJSON('/tickets', function(data) {
      data.forEach(function(el){
        var ticketLi = document.createElement('li');
        ticketLi.setAttribute('class', 'list-group-item')
        ticketLi.innerHTML = `<span class="badge">${el["issues"].length}</span><a href="/tickets/${el["id"]}">${el["title"]}</a>`;
        $("#open-tickets").append(ticketLi);
      });
    });
  });

  // New Ticket Functionality - Removes Add Ticket button then loads New Ticket form.
  $(function () {
    $("#new-ticket-button").on("click", function(e) {
      $("a#new-ticket-button").remove();
      $.get(this.href).success(function(response){
        $(".new-form-div").html(response)
      });     
      e.preventDefault();
    });
  });
  
});