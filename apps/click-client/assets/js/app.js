import "phoenix_html"
import $ from "jquery";

$('#click-count').click(function() {
  $.ajax({
    method: "post",
    dataType: "json",
    url: window.CLICKS_URL + "/clicks",
    success: (response) => {
      $('#click-count').text(response.count);
    }
  })

  return false;
});
