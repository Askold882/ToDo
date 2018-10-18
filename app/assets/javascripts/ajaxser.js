$(addAjaxer);

function addAjaxer(){
  $('body').append(`
    <div class='ajaxer'><center>
      <div class='section-1'>
        <input type='text' name='request-url' id='request-url' placeholder='request-url' />
        <label for='request-type'>Request type </label>
        <select name='request-type' id='request-type'>
          <option value="GET">GET</option>
          <option value="POST">POST</option>
          <option value="DELETE">DELETE</option>
          <option value="PUT">PUT</option>
          <option value="PATCH">PATCH</option>
        </select>
        <button type='button' name='go' onclick='go()'>GO!</button>
      </div>
      <textarea id='request-data' name='request-data' placeholder='request-data' cols=90 rows=5/>
      <div class='section-2'>
        <textarea id='response' placeholder='response' cols=90 rows=5/>
      </div>
    </center></div>
  `)
  $(document).on("keypress", function(e) { 
    if ( e.shiftKey && (e.charCode == 81 || e.charCode == 113)){
      $('.ajaxer').css('display') == 'none' ? $('.ajaxer').css('display', 'block') : $('.ajaxer').css('display', 'none')
    }
  });
};

function go() {
  var data = {}
  try {
    data = jQuery.parseJSON($('#request-data').val());
  } catch (err) {}

  $.ajax({ 
    url: $('#request-url').val(),
    type: $('#request-type').val(),
    data: data,
    success: function(result, textStatus, xhr){
      $('#response').val('body: ' + JSON.stringify(result) + '\n status: ' + xhr.status)
    },
    error: function(result){
      $('#response').val('body: ' + JSON.stringify(result.responseJSON) + '\n status: ' + result.status)
    }
	});
}