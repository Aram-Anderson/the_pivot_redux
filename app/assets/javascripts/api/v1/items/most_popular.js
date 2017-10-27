var itemsList = () => {
  fetch("../api/v1/items/most_popular?api_key=<%= ENV['API_KEY'] %>", {
    method: 'get'
  }).then(response => response.json())
  .then(parsed => {
    var items = []
    parsed.forEach(function(value, key) {
      $(".items").append(`<tr id='${key}'> <td>${value.title}</td> <td class="description">${value.description}</td><td>${value.price}</td></tr>`);
    });

  })
};
