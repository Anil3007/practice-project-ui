<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        body {
                display: flex;
                justify-content: center;
                min-height: 100vh;
                align-items: center;
            }
            .bg-container{
                /* background-color: #f0e8e8; */
                /* background-image: linear-gradient(to right,rgb(132, 215, 84),rgb(165, 219, 133),rgb(165, 219, 133),white); */
                /* background-color: rgb(165, 219, 133); */
                background-color: white;
                width: 30vw;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: gray 2px 4px 5px;
            }
            .register-container{    
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            input{
                height: 35px;
                margin: 10px 0px;
                padding-left: 11px;
                border-radius: 6px;
                border: 1px solid rgb(115, 108, 108);
                outline: none;
            }
            .passwordContainer{
                display: flex;
                flex-direction: column;
            }
            .checkbox{
                height: 12px;
            }
            label{
                font-size: 14px;
            }
            button{
                background-color: #16ad11;
                color: white;
                padding: 4px 12px;
                border: none;
                border-radius: 2px;
            }
            p{
                font-size: 12px;
            }
            a{
                color: #16ad11;
                font-weight: bold;
                text-decoration: underline;
            }
            
    </style>
</head>
<body>
    <div class="bg-container">
        <div class="register-container">
            <div>
                <h1>Register</h1>
            </div>
            <div>
                <input type="text" placeholder="name" id="name">
            </div>
            <div>
                <input type="text" placeholder="email" id="email">
            </div>
            <div>
                <input type="number" placeholder="Phone number" id="phoneNumber">
            </div>
            <div class="passwordContainer">
                <input type="password" placeholder="create password" id="password">
                <div>
                    <input type="checkbox" onclick=showPassword() class="checkbox" id="showPassword">
                    <label for="showPassword">show password</label>
                </div>
            </div>
            
            <div>
                <input type="password" placeholder="validate password" id="validatepassword">

            </div>
            <div>
                <button id="registerBtn">Register</button>
            </div>
            <div>
                <p>Already Regestered?<a id="loginBtn">Login</a></p>
            </div>
            <div>

            </div>
        </div>
    </div>

    <script type="text/javascript">
        let loginEl=document.getElementById("loginBtn")
        let registerBtn=document.getElementById("registerBtn")

        async function registerEmployee(url="",data={}){
            const response=await fetch(url,
            {
                method:"POST",
                headers:{"Content-Type":"application/x-www-form-urlencoded"},
                body:new URLSearchParams(data).toString(),
            })
            return response.json()
        }

        function showPassword(){
            let  showPasEl= document.getElementById("password");
            if (showPasEl.type === "password") {
                showPasEl.type = "text";
            } else {
                showPasEl.type = "password";
            }
        }

        loginEl.addEventListener("click",function(){
            window.location.href="/login"
        })
        
        registerBtn.addEventListener("click",function(){
            let nameEl=document.getElementById("name");
            let emailEl=document.getElementById("email");
            let phoneNumberEl=document.getElementById("phoneNumber");
            let passwordEl=document.getElementById("password");
            let validatepasswordEl=document.getElementById("validatepassword");

            if (passwordEl.value==validatepasswordEl.value){
                registerEmployee("/register/employee",{employee_name:nameEl.value,email:emailEl.value,password:passwordEl.value}).then(response=>{
                    if(response.status==="status"){
                        alert("successfully registered");
                    }
                    else{
                        alert(response.message);
                    }
                })
            }
            else{
                alert("password does not match")
            }
        })

    </script>
</body>
</html>