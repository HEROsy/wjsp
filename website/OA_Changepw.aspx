<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_Changepw.aspx.cs" Inherits="OA_Changepw" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="Script/jquery-1.8.2.min.js"></script>
    <style type="text/css">
        .item{margin:20px;}
        .txt{display:inline-block;width:170px;}
        .box{}
    </style>

    <script type="text/javascript">

        function btn()
        {
            var old = document.getElementById("old").value;
            var new1 = document.getElementById("new1").value;
            var new2 = document.getElementById("new2").value;
            var _ts = document.getElementById("ts");

            //必填项
            if (old.replace(/\s+/g, "") == "") { _ts.innerHTML = "信息不完整"; return false; }
            if (new1.replace(/\s+/g, "") == "") { _ts.innerHTML = "信息不完整"; return false; }
            if (new2.replace(/\s+/g, "") == "") { _ts.innerHTML = "信息不完整"; return false; }

            if (new1 != new2) { _ts.innerHTML = "两次密码不一致"; return false; }

            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type:"cpw",
                    old: old,
                    newpw:new2
                },
                success: function (data) {
                    if (data == "1") {
                        alert("修改成功");
                        document.getElementById("old").value = "";
                        document.getElementById("new1").value = "";
                        document.getElementById("new2").value = "";
                        _ts.innerHTML = "";

                    } else {
                        _ts.innerHTML = "旧密码不正确";
                    }
                }

            })
        }
    </script>
</head>
<body>
   <div>
       <div class="item"><span class="txt">旧密码：</span><input id="old" class="box" type="password" /> </div>
       <div class="item"><span class="txt">新密码：</span><input id="new1" class="box" type="password" /> </div>
       <div class="item"><span class="txt">再一次输入新密码：</span><input id="new2" class="box" type="password" /> </div>
       <div class="item"><input type="button" id="btn" value="确认修改" onclick="btn()"/><span id="ts" style="margin-left:100px;color:red"></span></div>
   </div>
</body>
</html>
