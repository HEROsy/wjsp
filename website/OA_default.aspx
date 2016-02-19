<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_default.aspx.cs" Inherits="OA_default" %>

<%@ Register Src="~/common/OA_head.ascx" TagPrefix="uc1" TagName="OA_head" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Script/swkj.js"></script>
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />

    <script src="Scripts/jquery.signalR-2.2.0.min.js"></script>
    <script src="signalr/hubs"></script>
    <title>雅安劳务公司文件审批流系统主界面</title>
    <style type="text/css">
        p {
            font-family: "微软雅黑" !important; /*强制使用这种字体*/
            letter-spacing: 1px; /*最小间距1px，可根据需要调整，不得低于1px*/
            font-size: 14px; /*最小文字大小14px，可根据需要调整，不得低于14px*/
        }

        span {
            font-family: "微软雅黑" !important; /*强制使用这种字体*/
            letter-spacing: 1px; /*最小间距1px，可根据需要调整，不得低于1px*/
            font-size: 14px; /*最小文字大小14px，可根据需要调整，不得低于14px*/
        }

        a {
            font-family: "微软雅黑" !important; /*强制使用这种字体*/
            letter-spacing: 1px; /*最小间距1px，可根据需要调整，不得低于1px*/
            font-size: 14px; /*最小文字大小14px，可根据需要调整，不得低于14px*/
        }

            a:hover {
                text-decoration: none; /*强制使用*/
            }

        input {
            font-family: 微软雅黑 !important; /*强制使用*/
            letter-spacing: 1px !important; /*强制使用*/
            font-weight: bold !important; /*强制使用*/
            font-size: 15px !important; /*强制使用*/
        }

            input::-webkit-input-placeholder {
                color: #a1a1a1 !important; /*强制使用*/
            }

          input:-moz-placeholder {
            color: #a1a1a1 !important; /*强制使用*/
        }

          input::-moz-placeholder {
            color: #a1a1a1 !important; /*强制使用*/
        }

          input:-ms-input-placeholder {
            color: #a1a1a1 !important; /*强制使用*/
        }
    </style>

    <script type="text/javascript">
        var chat = $.connection.myHub;

        chat.client.tz = function (msg) {
            if (msg == "0") {
                document.getElementById("amsg").style.backgroundColor = "";
            } else if (msg == "1")
            {
                document.getElementById("amsg").style.backgroundColor = "#FC99BA";
            }
        }

        chat.client.repeatlogin = function ()
        {
            alert("当前账号已登录，无法重复登录");
            window.location.href = "oa_login.aspx";
        }

        function tzz()
        {
            chat.server.tz("aldskfjlka");
        }

        $.connection.hub.start().done(
            function ()
            {
                chat.server.userconnection(document.getElementById("un").value);
            }
            );
        window.onload = function () {

        }
    </script>
</head>

<body>
    <input id="un" type="hidden" value="<%=un %>" />
    <uc1:OA_head runat="server" ID="OA_head" />
    <div style="width: 1000px;height:685px; margin: auto">
        <div class="row-fluid" style="margin-top: 10px">
            <iframe id="center" name="center" src="OA_center.aspx" style="width: 100%;height:685px; border: none;"></iframe>
        </div>
    </div>
</body>
</html>


