$(document).on('turbolinks:load', function() {
  $(".list-group").text("")
  $(function () {
    $.getJSON('/tickets', function(data) {
      data.forEach(function(el){
        var li = document.createElement('li');
        li.setAttribute('class', 'list-group-item')
        li.innerHTML = `<span class="badge">${el["issues"].length}</span><a href="/tickets/${el["id"]}">${el["title"]}</a>`;
        $(".list-group").append(li);
      });
    });
  });
});