<#include "layout.ftl">
<body>
<div class="container border">
    <div class="jumbotron text-center">
       <h2>Demostration building Restful service and SPA using Spring framework</h2>
       <p>Author: Dinh Duc</p>
       <p>Date created: Thu 22 June 2017</p>
       <p>Technologies used: Spring Boot, Spring Rest, Javascript, jQuery, Ajax, JSON, Bootstrap, Freemarker, HTML, CSS, MariaDB, Heroku, Github</p>
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
              <div class="form-inline">
	             <div class="input-group">
	               <span class="input-group-addon">Keyword</span>
	               <input type="text" class="form-control" name="keyword" placeholder="Enter phone or email">
	             </div>
	               <button class="btn btn-default" id="updateBtn">Search</button>
	          </div>
	      </div>    
	          <div id="updateError" style="display:none; margin-top: 20px;"></div>
	          <div id="updateResult" style="display:none; margin-top: 20px;">
	               <div class="form-group text-center">
                       <h3 class="btn btn-primary">Update employee's information</h3>
                   </div>
                   <div class="form-group">
                       <label></label>
                        <input type="text" class="form-control" name="oldName">
                   </div>
                   <div class="form-group">
                       <label></label>
                        <input type="text" class="form-control" name="oldAddress">
                   </div>
                   <div class="form-group">
                       <label></label>
                        <input type="text" class="form-control" name="oldPhone">
                   </div>
                   <div class="form-group">
                       <label></label>
                        <input type="text" class="form-control" name="oldEmail">
                   </div>
                   <div class="form-group">
                       <label></label>
                        <input type="text" id="datepicker" class="form-control" name="oldBirthday">
                   </div>
                   <div class="form-group">
                       <label></label>
                        <input type="text" class="form-control" name="oldPosition">
                   </div>
                    <div class="form-group">
                       <label></label>
                       <input type="hidden" name="number">
                       <button class="btn btn-default" id="saveBtn">Save</button>
                   </div>
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
   var updateEmployee = function(number, employee){
      $.ajax({
         method: "PUT",
         url: location.href+"/restapi/employee/"+number,
         contentType: "application/json;charset=utf8",
         data: JSON.stringify(employee),
         dat: "json",
         success: function(response){
             alert("Successfully edit employee's information, thank you!");
             $("#result").load(location.href+"/restapi/employee");
         },
         error: function(error){
            var errorObj = JSON.parse(error.responseText);
            alert("Cannot insert this employee cause [ "+ errorObj.message+" ("+errorObj.status+") ]");
         }
      })
   }
   var deleteEmployee = function(number){
       $.ajax({
          method: "DELETE",
          url: location.href+"/restapi/employee/"+number,
          contentType: "application/json;charset=utf8",
          success: function(response){
              alert("The employee with id number "+number+" was deleted");
              $("#result").load(location.href+"/restapi/employee");
          },
          error: function(error){
              var errorObj = JSON.parse(error.responseText);
              alert("Oopps! "+ errorObj.message);
          }
       })
   }
   var insertData = function(employee){
      $.ajax({
         method: "POST",
         url: location.href+"/restapi/employee",
         contentType: "application/json;charset=utf8",
         data: JSON.stringify(employee),
         success: function(response){
            $("#insertResult").text("Successfully insert employee, thank you!").addClass("alert alert-success").show();
            $("#result").load(location.href+"/restapi/employee");
         },
         error: function(error){
            var errorObj = JSON.parse(error.responseText);
            $("#insertResult").text("Cannot insert this employee cause [ "+ errorObj.message+" ("+errorObj.status+") ]").addClass("alert alert-warning").show();
         }
      });
   }
   
   var fetchData = function(selected){
      $.ajax({
         url: location.href+"/restapi/employee",
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
                  $("input").val("");
                  $("#datepicker").datepicker({
                     dateFormat: "dd-mm-yy",
                     buttonText: "Choose"
                  });
                  var employee = {};
                  $("#insertBtn").click(function(){
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
                  $(":input[name='numberDelete']").val(" ");
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
                  $(":input[name='emailSearch']").val(" ");
                  $("#singleEmployee").hide();
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
                  $("#updateError").hide();
                  $("#updateResult").hide();
                  $("#updateBtn").click(function(){
                      $("#updateResult").hide();
                      $("#updateError").hide();
                      var lkm=0;
                      var keyword = $(":input[name='keyword']").val();
                      for(var i=0; i < data.length; i++){
                         if(keyword == data[i].email | keyword == data[i].phone){
                            $(":input[name='oldName']").attr("placeholder",data[i].name);
                            $(":input[name='oldAddress']").attr("placeholder",data[i].address);
                            $(":input[name='oldBirthday']").attr("placeholder",data[i].birthday);
                            $(":input[name='oldPosition']").attr("placeholder",data[i].position);
                            $(":input[name='oldEmail']").attr("placeholder",data[i].email);
                            $(":input[name='oldPhone']").attr("placeholder",data[i].phone);
                            $(":input[name='number']").val(data[i].number);
                            $(":input[name='oldName']").val(data[i].name);
                            $(":input[name='oldAddress']").val(data[i].address);
                            $(":input[name='oldBirthday']").val(data[i].birthday);
                            $(":input[name='oldPosition']").val(data[i].position);
                            $(":input[name='oldEmail']").val(data[i].email);
                            $(":input[name='oldPhone']").val(data[i].phone);
                            $("#updateResult").dialog();
                         }else {
                            lkm++;
                            if(lkm == data.length)
                               $("#updateError").text("No employee found with keyword: "+ keyword).addClass("alert alert-warning").show();
                         }
                      }
                  })
                  $("#saveBtn").click(function(){
                      var employee = {};
                      var number = $(":input[name='number']").val();
                         employee["name"]= $(":input[name='oldName']").val();
	                     employee["address"] = $(":input[name='oldAddress']").val();
	                     employee["email"] = $(":input[name='oldEmail']").val();
	                     employee["phone"] = $(":input[name='oldPhone']").val();
	                     employee["position"] = $(":input[name='oldPosition']").val();
	                     employee["birthday"] = $(":input[name='oldBirthday']").val();
	                     updateEmployee(number, employee);
	                     $("#updateResult").dialog('close');
                  })
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