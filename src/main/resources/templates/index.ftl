<#include "layout.ftl">
<body>
<div class="container border">
    <div class="jumbotron text-center">
       <h2>Demo building Rest service and SPA using Spring framework</h2>
       <p>Author: Dinh Duc</p>
       <p>Date created: Thu 22 June 2017</p>
       <p>Technologies used: Spring Boot, Spring Rest, jQuery, Bootstrap, Javascript, Freemarker, HTML, CSS, MariaDB, Heroku</p>
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
	              <form class="form-inline">
	                 <div class="input-group">
	                  <span class="input-group-addon">Email</span>
	                  <input type="text" class="form-control" name="emailSearch" placeholder="Enter employee's email">
	                 </div>
	                   <button class="btn btn-default">Find</button>
	               </form>     
	                 <div id="singleEmployee" style="display: none"> 
	                 </div>
             </div>
          </div><!--searchEmployee-->
          
          <div id="deleteEmployee" style="display: none">
                <form class="form-inline">
                    <div class="input-group">
                        <span class="input-group-addon">Number</span>
                        <input type="text" class="form-control" name="number" placeholder="Enter employee's number">
                    </div>
                        <button class="btn btn-default">Delete</button>
                </form>
          </div><!--deleteEmployee-->
          
          <div id="insertEmployee" style="display: none">
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
                        <input type="text" class="form-control" name="birthday" placeholder="Enter birthday">
                   </div>
                   <div class="form-group">
                       <label></label>
                        <input type="text" class="form-control" name="position" placeholder="Enter position">
                   </div>
                    <div class="form-group">
                       <label></label>
                       <button class="btn btn-default" id="insertBtn">Create</button>
                   </div>
                   <div id="insertResult" style="display: none">
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
   var insertData = function(employeeObj){
      $.ajax({
         url: "http://localhost:8181/restapi/employee",
         method: "POST",
         contentType: "application/json;charset=utf8",
         dataType: "json",
         data: JSON.stringify(employeeObj),
         success: function(response){
            $("#insertResult").text("Successful insert employee").addClass("alert alert-success").show();
         },
         error: function(error){
            var errorObj = JSON.stringify(error);
            $("#insertResult").text("Cannot insert this employee cause "+ errorObj["message"]).addClass("alert alert-warning").show();
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
                  $("#insertBtn").click(function(){
                     var employee = {};
                     employee["name"]= $(":input[name='name']").val();
                     employee["address"] = $(":input[name='address']").val();
                     employee["phone"] = $(":input[name='phone']").val();
                     employee["birthday"] = $(":input[name='birthday']").val();
                     employee["email"] = $(":input[name='email']").val();
                     employee["position"] = $(":input[name='position']").val();
                     insertData(employee);
                  });
                  break;
            case "c":
                  $("#insertEmployee").hide();
                  $("#searchEmployee").hide();
                  $("#updateEmployee").hide();
                  $("#deleteEmployee").show();
                  break;
            case "d":
                  $("#insertEmployee").hide();
                  $("#deleteEmployee").hide();
                  var email = $(":input[name='email']").val();
                  $("#searchEmployee").show();
                  $(":input[name='email']").keydown(function(){
                      for(var i=0; i < employees.length; i++){
                          if(email === employees[i].email)
                              $("#singleEmployee").append(
                                 "Name: "+ employees[i].name + "<br>"+
                                 "Address: "+ employees[i].address + "<br>"+
                                 "Phone: "+ employees[i].phone + "<br>"+
                                 "Birthday: "+ employees[i].birthday + "<br>"+
                                 "Position: "+ employees[i].position + "<br>"
                               );
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