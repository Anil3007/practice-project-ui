<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <input type="month" id="dateTime">
    <p id="abc"></p>
    <script type="text/javascript">
        let monthYearEl=document.getElementById("dateTime")
        monthYearEl.addEventListener("change",function(event){
            let dateEl=document.getElementById("abc")
            console.log(event.target.value)
            let arr=[]
            let val=event.target.value
            arr=val.split("-")
            month=arr[1].toString().padStart(2, '0')
            
        })
    </script>
</body>
</html> 