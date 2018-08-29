// runs when the DOM finishes loading
// overrides the natural function of the form
// instead makes it run the send_update function
$("form[name='update']").on('submit', function(e) {
  send_update();
  e.preventDefault();
});

// sends an update to the server
// server will update the .json file
function send_update() {
  vals = $("form[name='update']").serializeArray().reduce(function(obj, item) {
    obj[item.name] = item.value;
    return obj;
  }, {});

  $.post("/update", JSON.stringify(vals), function() {
    console.log("success");
  });
}
