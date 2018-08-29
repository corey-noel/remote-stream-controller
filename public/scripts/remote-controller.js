// when the DOM finishes loading
// overrides the
$(document).ready(function() {
  $("form[name='update']").on('submit', function(e) {
    console.log("sending form");
    send_update();
    e.preventDefault();
  });
});

function send_update() {
  vals = $("form[name='update']").serializeArray().reduce(function(obj, item) {
    obj[item.name] = item.value;
    return obj;
  }, {});

  $.post("/update", JSON.stringify(vals), function() {
    console.log("success");
  });
}
