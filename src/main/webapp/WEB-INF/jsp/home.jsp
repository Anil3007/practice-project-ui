<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <style>
      body {
        margin: 0px;
        padding: 0px;
        box-sizing: content-box;
      }

      #container {
        padding: 25px;
      }
      .bg-container {
        background-image: linear-gradient(
          to bottom right,
          rgb(139, 92, 246),
          #141451
        );
        background-size: cover;
        min-height: 100vh;
        color: white;
        padding: 0px 0px;
        margin: 0px;
      }
      nav {
        display: flex;
        justify-content: end;
        align-items: center;
        border-bottom: solid 2px white;
        background-image: linear-gradient(
          to top left,
          #141451,
          rgb(139, 92, 246)
        );
        overflow: hidden;
        position: fixed;
        top: 0;
        width: 100%;
        padding: 6px 0px;
      }

      ul {
        display: flex;
        justify-content: space-between;
        align-items: center;
      }
      li {
        list-style-type: none;
        margin: 0px 15px;
      }
      .cont-container {
        margin: 50px 0px 0px 0px;
      }
      table {
        text-align: center;
        width: 100%;
      }
      tr {
        line-height: 29px;
      }
      .table-container {
        display: flex;
        justify-content: center;
      }
      select {
        width: 122px;
        height: 33px;
        margin: 10px 26px;
      }
      a {
        text-decoration: none;
        color: white;
      }
    </style>
  </head>
  <body>
    <div class="bg-container">
      <nav>
        <ul>
          <li><a href="default.asp">Home</a></li>
          <li><a href="news.asp">Attendance</a></li>
          <li><a id="salary">Salary</a></li>
          <li><a id="logout">Logout</a></li>
        </ul>
      </nav>
      <div class="cont-container">
        <div id="container">
          <p>Id:<span id="emID"></span></p>
          <p>
            Name:<span id="emName"></span>
            <span>
              <select id="joiningInCompany">
                <option value="" hidden>Join Company</option>
                <option value="3">Google</option>
                <option value="1">Giottus</option>
                <option value="4">Microsoft</option>
                <option value="2">Zoho</option>
                <option value="5">FaceBook</option>
              </select>
            </span>
          </p>
          <p>Email:<span id="emEmail"></span></p>
        </div>
        <div>
          <select id="companies">
            <option value="" selected>All Companies</option>
            <option value="Google">Google</option>
            <option value="Giottus">Giottus</option>
            <option value="Microsoft">Microsoft</option>
            <option value="Zoho">Zoho</option>
            <option value="Facebook">Facebook</option>
          </select>
        </div>
        <div class="table-container">
          <table id="table"></table>
        </div>
      </div>
    </div>
    <script type="text/javascript">
      var filterMsg = "";
      let containerEl = document.getElementById("container");
      let companySelectEl = document.getElementById("companies");

      async function getEmployeeDetails(url = "") {
        const res = await fetch(url);
        return res.json();
      }

      function populateEmployeeDetails(employeeData) {
        let employeeIdEl = document.getElementById("emID");
        employeeIdEl.textContent = employeeData.employee_id;

        let employeeNameEl = document.getElementById("emName");
        employeeNameEl.textContent = employeeData.employee_name;

        let employeeEmailEl = document.getElementById("emEmail");
        employeeEmailEl.textContent = employeeData.employee_email;
      }
      getEmployeeDetails("/getEmployee/Details").then((response) => {
        if (response.status === "success") {
          populateEmployeeDetails(response.data);
        } else {
          window.location.href = "/login";
        }
      });
      //getting all employee employer details and displaying

      async function getEmployeeEmployerDetails(url = "") {
        const res = await fetch(url);
        return res.json();
      }

      async function getEmployeesAssociated(url = "") {
        const res = await fetch(url);
        return res.json();
      }

      function createTableHeadings() {
        let tableEl = document.getElementById("table");
        tableEl.innerHTML = "";
        let headingRow = document.createElement("tr");

        let listOfHeadings = ["Id", "Name", "Company", "Joined Date"];

        for (let heading of listOfHeadings) {
          let hdTag = document.createElement("th");
          hdTag.textContent = heading;
          headingRow.appendChild(hdTag);
        }
        tableEl.appendChild(headingRow);
      }

      function appendEmployees(filterMsg, employeeData) {
        if (employeeData.employer_name.includes(filterMsg)) {
          let tableTagEl = document.getElementById("table");
          let rowEl = document.createElement("tr");
          let idEl = document.createElement("td");
          idEl.textContent = employeeData.employee_id;

          let nameEl = document.createElement("td");
          nameEl.textContent = employeeData.employee_name;

          let companyEl = document.createElement("td");
          companyEl.textContent = employeeData.employer_name;
          companyEl.setAttribute(
            "id",
            employeeData.employer_name + employeeData.employee_id
          );

          let joinedTimeEl = document.createElement("td");
          joinedTimeEl.textContent = employeeData.joined_time;

          rowEl.append(idEl, nameEl, companyEl, joinedTimeEl);
          tableTagEl.appendChild(rowEl);

          document
            .getElementById(
              employeeData.employer_name + employeeData.employee_id
            )
            .addEventListener("click", function (event) {
              console.log(event.target);
            });
        }
      }

      companySelectEl.addEventListener("change", function (event) {
        filterMsg = event.target.value;
        createTableHeadings();
        getEmployeeEmployerDetails("/getEmployee/Employer/details").then(
          (res) => {
            if (res.status == "success") {
              for (let employee of res.data) {
                appendEmployees(filterMsg, employee);
              }
            }
          }
        );
      });
      getEmployeeEmployerDetails("/getEmployee/Employer/details").then(
        (res) => {
          if (res.status == "success") {
            createTableHeadings();
            for (let employee of res.data) {
              appendEmployees(filterMsg, employee);
            }
          }
        }
      );

      async function joinCompany(url = "", data = {}) {
        const res = await fetch(url, {
          method: "POST",
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
          body: new URLSearchParams(data).toString(),
        });

        return res.json();
      }

      document
        .getElementById("joiningInCompany")
        .addEventListener("change", function () {
          let employee_id = document.getElementById("emID").textContent;
          let employer_id = event.target.value;
          console.log(employee_id);
          console.log(employer_id);
          joinCompany("/join/company", {
            employee_id: employee_id,
            employer_id: employer_id,
          }).then((res) => {
            if ((res.status = "success")) {
              alert(res.message);
            }
          });
        });

      document.getElementById("logout").addEventListener("click", function () {
        window.location.href = "/login";
      });

      async function getSalaryDetails(url = "", data = {}) {
        const res = await fetch(url);
        return res.json();
      }

      document.getElementById("salary").addEventListener("click", function () {
        getSalaryDetails("/gt/emp/slry").then((res) => {
          if (res.status == "success") {
            window.location.href = "/salary/Details";
          }
          
        });
      });
    </script>
  </body>
</html>
