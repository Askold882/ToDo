function Create(){
    var src = $("#task-form").serializeArray()
    var data = {}
    src.forEach((item) => {
      data[item.name] = item.value
    })
    data.done = $("#done").is(':checked')
    if( Valid()){
        $("#errors").text('')
        console.log("ok")
        $.ajax({ url: '/tasks',
           type: 'POST',
           data: data,
           success: function(result){
             console.log(result)
             if(result.errors){
              $('#errors').text(result.errors)
             }
           }
		});
    }
    else 
      $("#errors").text("invalid data")
  }
  
  function Valid(){
      return( $("#title").val().length > 0 &&  $("#duedate").val().length > 0)

      
  }