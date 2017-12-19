$(document).on('turbolinks:load', function() {
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
})