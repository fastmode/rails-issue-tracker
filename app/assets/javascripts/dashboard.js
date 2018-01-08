$(document).on('turbolinks:load', function() {

  // Clears out form to remove any remnants
  $("#open-tickets").text("")

  // Uses JSON to render all open tickets with Handlebars
  $(function () {
    $.getJSON('/tickets', function(data) {
      data.forEach(function(el){
        // Create Ticket prototype
        Ticket.prototype.renderLI = function() {
          return Ticket.template(this);
        }
        // Finds template in html and compiles it to Handlebars object
        Ticket.templateSource = $("#ticket-template").html();
        Ticket.template = Handlebars.compile(Ticket.templateSource);
        // Creates new Ticket object
        var ticket = new Ticket(el)
        // Takes new Ticket object and renders with with Handlebars
        var ticketLi = ticket.renderLI();
        // Adds newly rendered LI to HTML
        $("#open-tickets").append(ticketLi);
      });
    });
  });

  // Creates Ticket model objects
  function Ticket(attributes) {
    this.id = attributes.id;
    this.title = attributes.title;
    this.status = attributes.status;
    this.issue_count = attributes.issues.length;
  }
  
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