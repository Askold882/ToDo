$(function() {

    $('#login-form-link').click(function(e) {
		$("#login-form").delay(100).fadeIn(100);
 		$("#register-form").fadeOut(100);
		$('#register-form-link').removeClass('active');
		$(this).addClass('active');
    e.preventDefault();
    $('#login-errors').text('')
	});
	$('#register-form-link').click(function(e) {
		$("#register-form").delay(100).fadeIn(100);
 		$("#login-form").fadeOut(100);
		$('#login-form-link').removeClass('active');
		$(this).addClass('active');
    e.preventDefault();
    $('#login-errors').text('')
	});

});
function logIn() {
	
    var src = $("#login-form").serializeArray()
    var data = {}
    src.forEach((item) => {
      data[item.name] = item.value
    })
		if (validateLogin(data)) {
		$('#login-errors').text('')
    $.ajax({ url: '/sessions',
             type: 'POST',
             data: data,
             success: function(result){
               if(result.error){
                $('#login-errors').text(result.error)
               }
             }
	  });
	} else {
		$('#login-errors').text('icorrect email or password')
	}
}
function Register() {
	
  var src = $("#register-form").serializeArray()
  var data = {}
  src.forEach((item) => {
    data[item.name] = item.value
	})
  if (validateRegister(data)) {
		$('#login-errors').text('')
    $.ajax({ url: '/users',
           type: 'POST',
           data: {user: data},
           success: function(result){
            if(result.message){
              $('#login-errors').text(result.message)
             }
             if(result.error){
              $('#login-errors').text(result.error)
             }
           }
		});
	} else {
		$('#login-errors').text('incorrect email or password(must be at least 6 chars) or first/last name (must be at least 4 chars)')
	}
}

function validateLogin(data) {
	var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
  return ((data.password.length > 5) && re.test(String(data.email).toLowerCase()))
}

function validateRegister(data) {
	var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
  return ((data.password.length > 5) && re.test(String(data.email).toLowerCase()) && (data.first_name.length > 3) && (data.last_name.length > 3))
}