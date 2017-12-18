$(document).on('turbolinks:load', function() {
  $(function () {
    $("#js-next").on("click", function() {
      var nextId = parseInt($("#js-next").attr("data-id")) + 1;
      $.getJSON(`/tickets/${nextId}`, function(data){

        // Updates Ticket information after "Next Ticket" is clicked
        $(".ticketTitle").text(data["title"]);
        $(".ticketId").text(data["id"]);
        var date = new Date(data["due_date"])
        $(".ticketDueDate").text(`${date.getMonth()+1}/${date.getDate()}/${date.getFullYear()}`);
        $(".ticketLocation").text(data["user_tickets"][0]["location"]);
        $(".ticketStatus").text(data["status"]);
        $("#js-next").attr("data-id", data["id"]);
        window.history.replaceState( {}, null, `${data["id"]}`);  // Updates browser URL to visible Ticket

        // Edit and Delete Tickets button attributes are updated when Next Ticket is pressed.
        $("#edit-ticket-button").attr("href", `/tickets/${data["id"]}/edit`);
        $("#delete-ticket-button").attr({
          "data-confirm": "Are you sure?",
          "class": "btn btn-danger btn-xs", 
          "rel": "nofollow",
          "data-method": "delete",
          "href": `/tickets/${data["id"]}`
        });
      
        // Updates Issues information after "Next Ticket" is clicked.
        $(".list-group").text("")  // Clears out visible issues.
        data["issues"].forEach(function(el) {
          var li = document.createElement('li');
          li.setAttribute('class', 'list-group-item')
          li.innerHTML = `<span class="badge">${el["status"]}</span><a href="/tickets/${el["ticket_id"]}/issues/${el["id"]}">${el["title"]}</a>`;
          $(".list-group").append(li);
        });

        // Add Issue button href is updated when Next Ticket is pressed"
        $("#add-issue-button").attr("href", `/tickets/${data["id"]}/issues/new`);
      });
    });
  });
});