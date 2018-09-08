function doneTask(id){
    $.ajax({ url: '/tasks/' + id ,
           type: 'PUT',
           data: {done: 'true' },
           success: function(result){
             console.log(result)
             if(result.errors){
              $('#errors').text(result.errors)
             }
           }
		});
  }

  function activeTask(id){
    $.ajax({ url: '/tasks/' + id ,
           type: 'PUT',
           data: {done: 'false' },
           success: function(result){
             console.log(result)
             if(result.errors){
              $('#errors').text(result.errors)
             }
           }
		});
  }

  function deleteTask(id){
    $.ajax({ url: '/tasks/' + id ,
           type: 'DELETE',
           success: function(result){
             console.log(result)
             if(result.errors){
              $('#errors').text(result.errors)
             }
           }
		});
  }

  function markAll(){
    $(":checkbox").each((item, value) =>{
      $(value).prop('checked', true)
    })
  }

  function unmarkAll(){
    $(":checkbox").each((item, value) =>{
      $(value).prop('checked', false)
    })
  }

  function deleteMarked(){
    var ids=[]
    $(":checked").each((item, value) =>{
      ids.push(value.id)
    })
    $.ajax({ url: '/tasks/0' ,
             type: 'DELETE',
             data: {batch: ids} , 
             success: function(result){
               console.log(result)
               if(result.errors){
                $('#errors').text(result.errors)
               }
             }
		});
  }