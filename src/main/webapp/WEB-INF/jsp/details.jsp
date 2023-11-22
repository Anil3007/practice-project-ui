<%@page import="com.practice.controller.EmployeeController"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div id="main-div">
    </div>
    <Script type="text/javascript">

        function populateEmployeeDetails(res){
            employeeData=res.data;
            let mainDivEl=document.getElementById("main-div");

            let employeeIdEl=document.createElement("p")
            employeeIdEl.textContent=employeeData.employee_id;
            mainDivEl.appendChild(employeeIdEl)

            let employeeNameEl=document.createElement("p")
            employeeNameEl.textContent=employeeData.employee_name;
            mainDivEl.appendChild(employeeNameEl)

            let employeeEmailEl=document.createElement("p")
            employeeEmailEl.textContent=employeeData.employee_email;
            mainDivEl.appendChild(employeeEmailEl)
            
        }

        populateEmployeeDetails(<%=EmployeeController.getEmployeeDetails()%>)
    </Script>
</body>
</html>