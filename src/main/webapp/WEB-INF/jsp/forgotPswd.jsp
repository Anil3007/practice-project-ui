<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body{
            display: flex;
            align-items: center;
            min-height: 100vh;
            justify-content: center;
        }
        input{
            margin: 10px 0px;
            padding-left: 11px;
            border-radius: 6px;
            border: 1px solid rgb(115, 108, 108);
            outline: none;
            height: 35px;
        }
        button{
            color: white;
            padding: 9px 9px;
            background-color: orangered;
            border: none;
            border-radius: 2px;
        }
        .btn-container{
            text-align: center;
        }
    </style>
</head>
<body>
    <div>
        <p>Reset Your password</p>
        <div>
            <input type="text" id="username" placeholder="username">
        </div>
        <div>
            <input type="text" id="email" placeholder="email">
        </div>
        <div>
            <input type="text" id="newPswd" placeholder="Enter New Password">
        </div>
        <div>
            <input type="text" id="confirmPswd" placeholder="Confirm Your Password">
        </div>
        <div class="btn-container">
            <button id="changePswdBtn">Change Password</button>
        </div>
    </div>
    <script type="text/javascript">
        let changePswdBtnEl=document.getElementById("changePswdBtn");

        async function resetPassword(url="",data={}){
            const response=await fetch(url,
            {
                method:"POST",
                headers:{"Content-Type":"application/x-www-form-urlencoded"},
                body:new URLSearchParams(data).toString(),
            })
            return response.json()
        }

        changePswdBtnEl.addEventListener("click",function(){
            let userNameEL=document.getElementById("username")
            let emailIdEl=document.getElementById("email")
            let newPswdEl=document.getElementById("newPswd")
            let validatedPswdEl=document.getElementById("confirmPswd")
            if (newPswdEl.value==validatedPswdEl.value){
                resetPassword("/change/password",{employee_name:userNameEL.value,email:emailIdEl.value,password:newPswdEl.value}).then((response)=>{
                    if (response.status=="success"){
                        alert(response.message)
                    }
                })
                
            }

            
        })
    </script>
</body>
</html>