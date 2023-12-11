
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
    <div>
      <label>Employee_id</label>
      <input type="text" id="employee_id"/>
    </div>
    <div>
      <label>Employee_id</label>
      <input type="text" id="employer_name" />
    </div>
    <div>
      <select id="employer-drop-down"></select>
    </div>
    <script type="text/javascript">
      console.log(employerData)
      function appendEmployer(){
        let employerDropDown=document.getElementById("employer-drop-down")

        for (let each of employerData){
            let optionEl=document.createElement("option")
            optionEl.textContent=each.data.employer_name
            optionEl.setAttribute("value",each.data.employer_id)
            employerDropDown.append(optionEl)
        }
      }
      appendEmployer()

      async function getEmployerData(url) {
        const res = await fetch(url);
        return res.json();
      }
      getEmployerData("/employers").then((res) => {
        if(res.status=="success"){
           
        }
      });
    </script>
  </body>
</html>
