<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_login.aspx.cs" Inherits="OA_login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Script/swkj.js"></script>
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />
    <title>用户登录</title>
        <style type="text/css">
        p {
            font-family:"微软雅黑" !important; /*强制使用这种字体*/
            letter-spacing:1px;                /*最小间距1px，可根据需要调整，不得低于1px*/
            font-size:14px;                    /*最小文字大小14px，可根据需要调整，不得低于14px*/
        }
        span {
            font-family:"微软雅黑" !important; /*强制使用这种字体*/
            letter-spacing:1px;                /*最小间距1px，可根据需要调整，不得低于1px*/
            font-size:14px;                    /*最小文字大小14px，可根据需要调整，不得低于14px*/
        }
        a {
            font-family:"微软雅黑" !important; /*强制使用这种字体*/
            letter-spacing:1px;                /*最小间距1px，可根据需要调整，不得低于1px*/
            font-size:14px;                    /*最小文字大小14px，可根据需要调整，不得低于14px*/
        }
            a:hover {
                text-decoration:none;  /*强制使用*/
            }
        input {
            font-family: 微软雅黑 !important;  /*强制使用*/
            letter-spacing: 1px !important;    /*强制使用*/
            font-weight:bold !important;       /*强制使用*/
            font-size:15px !important;         /*强制使用*/
        }
        input::-webkit-input-placeholder {
            color: #a1a1a1 !important;  /*强制使用*/
        }

        　　input:-moz-placeholder {
            color: #a1a1a1 !important;  /*强制使用*/
        }

        　　input::-moz-placeholder {
            color: #a1a1a1 !important;  /*强制使用*/
        }

        　　input:-ms-input-placeholder {
            color: #a1a1a1 !important;  /*强制使用*/
        }

    </style>

    <script type="text/javascript">
        window.onload = function () {

        }
    </script>
</head>

<body>
    <div style="width: 1000px;height:680px; margin: auto"> <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">   <%--此行不能修改--%>
            用户登录

        </div>
    </div>
</body>
</html>
