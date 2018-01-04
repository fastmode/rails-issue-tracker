$(document).on('turbolinks:load', function() {

  // Uses JSON to render all open tickets
  $("#open-tickets").text("")
  $(function () {
    $.getJSON('/tickets', function(data) {
      //console.log(data);
      data.forEach(function(el){
        console.log(el);

        Ticket.prototype.renderLI = function() {
          return Ticket.template(this);
        }
        
        $(function(){
          Ticket.templateSource = $("#ticket-template").html();
          Ticket.template = Handlebars.compile(Ticket.templateSource);
        });
        
        var ticket = new Ticket(el)
        var ticketLi = ticket.renderLI();
        // ticket.templateSource = $("#ticket-template").html();
        // ticket.template = Handlebars.compile(ticket.templateSource);
        $("#open-tickets").append(ticketLi);
        
        // debugger;
        // var ticketLi = document.createElement('li');
        // ticketLi.setAttribute('class', 'list-group-item')
        // ticketLi.innerHTML = `<span class="badge">${el["issues"].length}</span><a href="/tickets/${el["id"]}">${el["title"]}</a>`;
        // $("#open-tickets").append(ticketLi);
      });
    });
  });

  // Creates Ticket objects
  function Ticket(attributes) {
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





// // Building Prototype

// function Ticket(attributes) {
//   this.title = attributes.title;
//   this.status = attributes.status;
// }

// Ticket.prototype.renderLI = function() {
//   return Ticket.template(this);
// }

// $(function(){
//   Ticket.templateSource = $("#ticket-template").html();
//   Ticket.template = Handlebars.compile(Ticket.templateSource);
// });

// Ticket.formSubmit = function(e){
//   e.preventDefault();
//   var $form = $(this);
//   var action = $form.attr("action")
//   var params = $form.serialize();

//   $.ajax({
//     url: action,
//     data: params,
//     dataType: "json",
//     method: "POST"
//   })
//   .success(Ticket.success)
//   .error(Ticket.error)
// }

// Ticket.success = function(json) {
//   var ticket = new Ticket(json);
//   var ticketLi = ticket.renderLI();
//   $("#open-tickets").append(ticketLi);
// }

// Ticket.error = function(response) {
//   console.log("Something broke man!", response)
// }