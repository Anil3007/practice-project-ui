<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <input type="text" id="employeeIdInput">
    <button id="showbtn">show</button>

   

    <script type="text/javascript">
        let showBtnEl=document.getElementById("showbtn");
        let employeeIdInput=document.getElementById("employeeIdInput")

        async function getEmployeeDetails(url=""){
            const res=await fetch(url);
            return res.json();
        }

        showBtnEl.addEventListener("click",function(){
            getEmployeeDetails("/getEmployee/Details/"+employeeIdInput.value).then((response)=>{
                if(response.status==="success"){
                    window.location.href="/showDetailsPage"
                }
            })
        })
    </script>
</body>
</html>