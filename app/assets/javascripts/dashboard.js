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

// Building Prototype

function Ticket(attributes) {
  this.title = attributes.title;
  this.status = attributes.status;
}

Ticket.prototype.renderLI = function() {
  return Ticket.template(this);
}

// $(function() {
  // Ticket.templateSource = $("#ticket-template").html()      // Need to add template to html with id so I can reference it here
  // Ticket.template = Handlebars.compile(Ticket.templateSource)  // Need to install Handlebars to app
// }

Ticket.formSubmit = function(e){
  e.preventDefault();
  var $form = $(this);
  var action = $form.attr("action")
  var params = $form.serialize();

  $.ajax({
    url: action,
    data: params,
    dataType: "json",
    method: "POST"
  })
  .success(Ticket.success)
  .error(Ticket.error)
}

Ticket.success = function(json) {
  var ticket = new Ticket(json);
  var ticketLi = ticket.renderLI();
  $("#open-tickets").append(ticketLi);
}

Ticket.error = function(response) {
  console.log("Something broke man!", response)
}