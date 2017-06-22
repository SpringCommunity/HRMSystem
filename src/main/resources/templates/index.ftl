<#include "layout.ftl">
<body>
<div class="container border">
    <div class="jumbotron text-center">
       <h2>Demo building Rest service and SPA using Spring framework</h2>
       <p>Author: Dinh Duc</p>
       <p>Date created: Thu 22 June 2017</p>
       <p>Technologies used: Spring Boot, Spring Rest, jQuery, Ajax, JSON, Bootstrap, Javascript, Freemarker, HTML, CSS, MariaDB, Heroku</p>
    </div><!--jumbotron-->
    <div class="row text-center">
       <div class="col-sm-5">
          <div class="row">
	           <form class="form">
	              <select class="form-control" id="task" default="false">
	                 <span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span>
	                 <option value="a">Fetch all employees with json datatype</option>
	                 <option value="b">Insert new employee</option>
	                 <option value="c">Delete an employee</option>
	                 <option value="d">Find employee via email</option>
	                 <option value="e">Update employee's information</option>
	              </select>
	           </form>
          </div><!--row--> 
          <div class="row" id="searchEmployee" style="display: none">
             <div class="col-sm-12">
	              <div class="form-inline">
	                 <div class="input-group">
	                  <span class="input-group-addon">Email</span>
	                  <input type="text" class="form-control" name="emailSearch" placeholder="Enter employee's email">
	                 </div>
	                   <button class="btn btn-default" id="findBtn">Find</button>
	               </div>     
	                 <div id="singleEmployee" style="display: none; margin-top: 20px;"> 
	                 </div>
             </div>
          </div><!--searchEmployee-->
          
          <div id="deleteEmployee" style="display: none">
                <div class="form-inline">
                    <div class="input-group">
                        <span class="input-group-addon">Number</span>
                        <input type="text" class="form-control" name="numberDelete" placeholder="Enter employee's number">
                    </div>
                        <button class="btn btn-default" id="deleteBtn">Delete</button>
                </div>
          </div><!--deleteEmployee-->
          
          <div id="insertEmployee" style="display: none">
                   <div id="insertResult" style="display: none">
                   </div>
                   <div class="form-group text-center">
                       <h3 class="btn btn-primary">Insert new employee</h3>
                   </div>
                   <div class="form-group">
                       <label></label>
                        <input type="text" class="form-control" name="name" placeholder="Enter fullname">
                   </div>
                   <div class="form-group">
                       <label></label>
                        <input type="text" class="form-control" name="address" placeholder="Enter address">
                   </div>
                   <div class="form-group">
                       <label></label>
                        <input type="text" class="form-control" name="phone" placeholder="Enter phonenumber">
                   </div>
                   <div class="form-group">
                       <label></label>
                        <input type="text" class="form-control" name="email" placeholder="Enter email">
                   </div>
                   <div class="form-group">
                       <label></label>
                        <input type="text" id="datepicker" class="form-control" name="birthday" placeholder="Enter birthday">
                   </div>
                   <div class="form-group">
                       <label></label>
                        <input type="text" class="form-control" name="position" placeholder="Enter position">
                   </div>
                    <div class="form-group">
                       <label></label>
                       <button class="btn btn-default" id="insertBtn">Create</button>
                   </div>
          </div><!--insertEmployee-->
          <div id="updateEmployee" style="display: none">
              <form class="form-inline">
	             <div class="input-group">
	               <span class="input-group-addon">Keyword</span>
	               <input type="text" class="form-control" name="keyword" placeholder="Enter keyword">
	             </div>
	               <button class="btn btn-default">Search</button>
	          </form>     
          </div>
       </div><!--col-sm-5-->
       <div class="col-sm-1">
       </div>
       <div class="col-sm-5 text-center" id="data">
          <div class="row">
             <button class="btn btn-success">Data with json type</button>
          </div>
          <div class="row">
             <div id="result">
             </div>
          </div>
       </div><!--col-sm-5-->

       
    </div><!--row-->
</div><!--container-->
</body>
<script>
   var deleteEmployee = function(number){
       $.ajax({
          method: "DELETE",
          url: "http://localhost:8181/restapi/employee/"+number,
          contentType: "application/json;charset=utf8",
          success: function(response){
              alert("The employee with id number "+number+" was deleted");
          },
          error: function(error){
              var errorObj = JSON.parse(error.responseText);
              alert("Oopps! "+ errorObj.message);
          }
       })
   }
   var insertData = function(employeeObj){
      $.ajax({
         method: "POST",
         url: "http://localhost:8181/restapi/employee",
         contentType: "application/json;charset=utf8",
         dataType: "json",
         data: JSON.stringify(employeeObj),
         success: function(response){
            $("#insertResult").text("Successfully insert employee, thank you!").addClass("alert alert-success").show();
         },
         error: function(error){
            var errorObj = JSON.parse(error.responseText);
            $("#insertResult").text("Cannot insert this employee cause "+ errorObj.error+" ("+errorObj.status+")").addClass("alert alert-warning").show();
         }
      });
   }
   
   var fetchData = function(selected){
      $.ajax({
         url: "http://localhost:8181/restapi/employee",
         method: "GET",
         dataType: "json",
         timeout: 10000,
         error: function(data){
           $("#result").html("Cannot fetch data from rest");
         }
      }).done(function(data){
          var employees = JSON.stringify(data);
          switch (selected){
            case "a":
                  $("#insertEmployee").hide();
                  $("#searchEmployee").hide();
                  $("#deleteEmployee").hide();
                  $("#updateEmployee").hide();
                  $("#result").text(employees);
                  $("#data").toggle();
                  break;
            case "b":
                  $("#updateEmployee").hide();
                  $("#searchEmployee").hide();
                  $("#deleteEmployee").hide();
                  $("#insertEmployee").show();
                  $("#datepicker").datepicker({
                     dateFormat: "dd-mm-yy",
                     buttonText: "Choose"
                  });
                  $("#insertBtn").click(function(){
                     var employee = {};
                     employee["name"]= $(":input[name='name']").val();
                     employee["address"] = $(":input[name='address']").val();
                     employee["email"] = $(":input[name='email']").val();
                     employee["phone"] = $(":input[name='phone']").val();
                     employee["position"] = $(":input[name='position']").val();
                     employee["birthday"] = $(":input[name='birthday']").val();
                     insertData(employee);
                  });
                  break;
            case "c":
                  $("#insertEmployee").hide();
                  $("#searchEmployee").hide();
                  $("#updateEmployee").hide();
                  $("#deleteEmployee").show();
                  $("#deleteBtn").click(function(){
                     var numberDelete = $(":input[name='numberDelete']").val();
                     deleteEmployee(numberDelete);
                  })
                  break;
            case "d":
                  $("#insertEmployee").hide();
                  $("#deleteEmployee").hide();
                  $("#updateEmployee").hide();
                  $("#searchEmployee").show();
                  $("#findBtn").click(function(){
                         var lkm = 0;
                         var emailSearch = $(":input[name='emailSearch']").val();
                         for(var i=0; i < data.length; i++){
                          if(emailSearch == data[i].email){
                              lkm++;
                              $("#singleEmployee").text(
                                 "Number:"+ data[i].number + "\n"+
                                 "Name: "+ data[i].name + "\n"+
                                 "Address: "+ data[i].address + "\n"+
                                 "Phone: "+ data[i].phone + "\n"+
                                 "Birthday: "+ data[i].birthday + "\n"+
                                 "Position: "+ data[i].position + "\n"
                               ).addClass("alert alert-success").show();
                               break;
                          } else {
                                  if(lkm == 0)
                                    $("#singleEmployee").text("No employee found with given email: "+ emailSearch).addClass("alert alert-warning").show();
                               }
                          }
                  })
                  break;
            case "e":
                  $("#insertEmployee").hide();
                  $("#searchEmployee").hide();
                  $("#deleteEmployee").hide();
                  $("#updateEmployee").show();
                  break;
            default:
                  fetchData();
                  break;           
         }
      });
   }
   $( document ).ready(function(){
       $("#task").change(function(){
         var selected = $("#task option:selected").val();
         fetchData(selected);
       });
   })
</script>