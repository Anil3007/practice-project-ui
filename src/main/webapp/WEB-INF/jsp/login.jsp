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
            }
            .bg-container{
                background-color: #ffffff;
                padding: 65px;
                display: flex;
                align-items: center;
                justify-content: center;
                
            }
            .login-page-container{
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            input{
                height: 43px;
                margin: 10px 0px;
                padding-left: 11px;
                border-radius: 6px;
                border: 1px solid rgb(115, 108, 108);
            }
            button{
                background-color: #b12be2;
                color: white;
                padding: 11px 31px;
                border: none;
                border-radius: 6px;
            }
            p{
                font-size: 12px;
            }
            a{
                font-size: 12px;
                color: #2b36e2;
                font-weight: bold;
                text-decoration: underline;
            }
            .errMsg{
                color: red;
            }
        </style>
    </head>
    <body>
        <div class="bg-container">
            <div class="login-page-container">
                <div>
                    <h1>Login</h1>
                </div>
                <div>
                    <input id="username" type="text" placeholder="username">
                </div>
                <p id="userErMsg" class="errMsg"></p>
                <div>
                    <input id="password" type="password" placeholder="password">
                </div>
                <p id="pswErrorMsg" class="errMsg"></p>
                <div>
                    <button id="loginBtn">login</button>
                </div>
                <div>
                    <p>Not Regestered?<a id="regesterBtn">Register Now</a></p>
                </div>
                <div>
                    <a id="forgotPw">forgot password</a>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            let loginBtnEl=document.getElementById("loginBtn");
            let registerBtnEl=document.getElementById("regesterBtn");
            let passErrMsg=document.getElementById("pswErrorMsg");
            let userErrMsgEl=document.getElementById("userErMsg");
            let usernameEl=document.getElementById("username");
            let forgotPwEl=document.getElementById("forgotPw");

            async function doLogin(url="",data={}){
                const response=await fetch(url,
                    {
                        method:"POST",
                        headers:{"Content-Type":"application/x-www-form-urlencoded"},
                        body:new URLSearchParams(data).toString(),
                    }
                )
                return response.json();
            }
            loginBtnEl.addEventListener("click",function(){
                let userInput=document.getElementById("username").value;
                let passwordInput=document.getElementById("password").value;
                doLogin("/dologin",{"username":userInput,"password":passwordInput}).then((response)=>{  
                    if(response.status=="success"){
                        let employee_id=response.data.employee_id
                        window.location.href="/home/"+employee_id;
                    }
                    else if(response.status=="failure"){
                        passErrMsg.textContent="";
                        userErrMsgEl.textContent=response.message;
                    }
                    else{
                        userErrMsgEl.textContent="";
                        passErrMsg.textContent=response.message;
                    }
                })
            })

            forgotPw.addEventListener("click",function(){
                window.location.href="/reset/password"
            })

            registerBtnEl.addEventListener("click",function(){
                window.location.href="/registerpage";
            })
        </script>
    </body>
</html>