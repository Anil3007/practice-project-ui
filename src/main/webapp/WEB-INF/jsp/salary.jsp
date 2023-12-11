<%@page import="com.practice.controller.EmployeeController"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <style>
      .bg-container {
        display: flex;
        flex-direction: column;
        align-items: center;
      }
      .card-container {
        padding: 39px;
        background-color: white;
        box-shadow: gray 10px 10px 26px;
        border-radius: 4px;
        display: flex;
        flex-direction: column;
        width: 28vw;
      }
      .items-center{
        display: flex;
        flex-direction: column;
        align-items: center;
      }
      .heading {
        font-weight: bold;
      }
      .drop-down {
        align-self: flex-end;
      }
      .item-container {
        display: flex;
        justify-content: space-between;
      }
      .font-weight-normal {
        font-weight: normal;
      }
      .Btn{
        background-color: cyan;
      }
    </style>
  </head>
  <body>
    <div class="bg-container" id="bg-container">
      <h1>Welcome!</h1>
      <div id="cardContainer" class="card-container">
        <input type="month" id="drop-down" onload=getDate()>
        <p class="heading">
          Organization:<span
            id="organization"
            class="font-weight-normal"
          ></span>
        </p>
        <p class="heading">
          Name:<span id="name" class="font-weight-normal"></span>
        </p>
        <div class="item-container">
          <p class="heading">Basic:</p>
          <p id="Basic"></p>
        </div>
        <div class="item-container">
          <p class="heading">HRA:</p>
          <p id="hra"></p>
        </div>
        <div class="item-container">
          <p class="heading">LTA:</p>
          <p id="lta"></p>
        </div>
        <div class="item-container">
          <p class="heading">Gross Salary</p>
          <p id="gross"></p>
        </div>
        <p class="heading">Deductions</p>
        <div class="item-container">
          <p class="heading">PF Contribution:</p>
          <p id="pf"></p>
        </div>
        <div class="item-container" id="txtEl"></div>
        <div class="item-container">
          <p class="heading">Net Pay:</p>
          <p id="total_salary"></p>
        </div>
      </div>
    </div>
    <script type="text/javascript">
      const d = new Date();
      let month = d.getMonth();
      let year=d.getFullYear()
      // let curSelMonth=month
      // document.getElementById(month).setAttribute("selected","selected")
      salaryData=<%=EmployeeController.getSalaryDetails()%>;
      let flag=true
      function getDate(){
        var today = new Date();
        document.getElementById("drop-down").value = "January" +((today.year()))
      }

      function appendData(){
        for (let each of salaryData.data){
          if (((`${employee_id}`)==each.employee_id) && (month==each.month) && (year==each.year)){
            let basciAmnt=(0.7*each.salary).toFixed(2)
            let hraAmnt=(0.2*each.salary).toFixed(2)
            let ltaAmnt=(0.1*each.salary).toFixed(2)
            let pfAmnt=(0.04*each.salary).toFixed(2)
            let netAmnt=(each.salary-pfAmnt)
            let nameEl=document.getElementById("name");
            nameEl.textContent=each.employee_name;
            let employerEl=document.getElementById("organization")
            employerEl.textContent=each.employer_name

            let BasicSalEl=document.getElementById("Basic")
            BasicSalEl.textContent=basciAmnt+"/-"

            let hraEl=document.getElementById("hra")
            hraEl.textContent=hraAmnt+"/-"

            let ltaEl=document.getElementById("lta")
            ltaEl.textContent=ltaAmnt+"/-"

            let grossEl=document.getElementById("gross")
            grossEl.textContent=each.salary+"/-"

            let pfEl=document.getElementById("pf")
            pfEl.textContent="-"+pfAmnt+"/-"

            if(each.salary>40000){
              let cardContainerEl=document.getElementById("txtEl")
              cardContainerEl.innerHTML=""
              let gstHeading=document.createElement("p")
              gstHeading.textContent="Income Tax"
              gstHeading.classList="heading"

              let gstEl=document.createElement("p")
              gstEl.textContent="-"+(0.10*each.salary).toFixed(2)
              netAmnt=netAmnt-0.10*each.salary
              cardContainerEl.append(gstHeading,gstEl)
            }
            let netAmountEl=document.getElementById("total_salary")
            netAmountEl.textContent=netAmnt.toFixed(2)+"/-"
            flag=true
            break
            
          }
          else{
            console.log("this is else part")
            flag=false
          } 
        }
        if (flag!=true){
          let bgContainerEl=document.getElementById("cardContainer")
            bgContainerEl.innerHTML=""
            let msEl=document.createElement("h1");
            msEl.textContent="Not Available!"
            bgContainerEl.appendChild(msEl)
            let backBtn=document.createElement("button")
            backBtn.textContent="Back"
            bgContainerEl.classList.remove("card-container")
            bgContainerEl.classList.add("items-center")
            bgContainerEl.appendChild(backBtn)
            backBtn.addEventListener("click",function(){
              window.location.href="/salary/Details"
            })

        }
      }
      document.getElementById("drop-down").addEventListener("change",function(event){
        year_month=event.target.value
        arr=[]
        arr=year_month.split("-")
        year=arr[0]
        month=arr[1]
        month=month.toString().padStart(2, '0')
        appendData()
      })
      appendData()
      
    </script>
  </body>
</html>
