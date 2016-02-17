<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_login.aspx.cs" Inherits="OA_login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Script/swkj.js"></script>
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />
    <title>雅安劳务公司OA平台-员工登录界面</title>
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

        .loginback {
            width: 1000px;
            height: 768px;
            margin: auto;
        }

        .show1 {
            color: #ffffff;
            font-size: 36px;
            font-weight: bold;
            letter-spacing: 3px;
            text-align: center;
            display: block;
            line-height: 200px;
        }

        .show2 {
            width: 600px;
            height: 430px;
            margin: auto;
            background-image: url(img/loginback.png);
            background-repeat: no-repeat;
        }

        .show3 {
            color: #ffffff;
            display: block;
            text-align: center;
            letter-spacing: 3px;
            line-height: 150px;
        }

        .no1 {
            height: 760px;
        }

        #username {
            display: block;
            position: absolute;
            margin: 251px 0 0 347px;
            height: 29px;
            width: 194px;
            border: none;
        }

            #username:focus {
                outline: none !important;
            }

        #password {
            display: block;
            position: absolute;
            margin: 310px 0 0 347px;
            height: 25px;
            width: 183px;
            border: none;
            box-shadow:none !important;
        }

            #password:focus {
                outline: none !important;
                box-shadow: none !important;
            }

        .submits {
            display: block;
            position: absolute;
            height: 37px;
            width: 239px;
            margin: 367px 0 0 306px;
        }

        #snap {
            display: block;
            position: absolute;
            height: 43px;
            width: 219px;
            margin: 299px 0 0 0px;
        }
        .show4 {
            position: absolute;
            margin: -390px 0 0 434px;
            width: 330px;
            background-color: #f26666;
            border: 1px solid #ffffff;
            color: #ffffff;
            text-shadow: none;
            text-align:center;
            height:30px;
            line-height:30px;
        }

        .caiji {
            position: absolute;
            margin-top: 230px;
        }

        #video {
            margin: 80px 0 0 228px !important;
            display: block;
            float: left;
        }

        #canvas {
            margin: 17px 0 0 155px !important;
            display: block;
            float: left;
        }
    </style>

    <script type="text/javascript">
        document.onkeydown = function (event_e) {
            if (window.event) {
                event_e = window.event;
            }

            var int_keycode = event_e.charCode || event_e.keyCode;
            if (int_keycode == '13') {
                btn();
            }
        }

        window.onload = function () {

        }

        window.addEventListener("DOMContentLoaded", function () {
            canvas = document.getElementById("canvas");
            context = canvas.getContext("2d");
            video = document.getElementById("video");
            videoObj = { "video": true };
            errBack = function (error) {
                alert("读取视频错误:可能是其他程序正在使用摄像头,请关闭所有浏览器或视频聊天软件重试! ", error.code);
            };
            if (navigator.getUserMedia) { // 如果允许打开摄像头
                //stream为读取的视频流
                navigator.getUserMedia(videoObj, function (stream) {
                    video.src = stream;
                    video.play();
                }, errBack);
            } else if (navigator.webkitGetUserMedia) { //  根据不同的浏览器写法不同
                navigator.webkitGetUserMedia(videoObj, function (stream) {
                    video.src = window.webkitURL.createObjectURL(stream);
                    video.play();
                }, errBack);
            }
            else if (navigator.mozGetUserMedia) { // 适应FF浏览器
                navigator.mozGetUserMedia(videoObj, function (stream) {
                    video.src = window.URL.createObjectURL(stream);
                    video.play();
                }, errBack);
            }
            document.getElementById("snap").addEventListener("click", function () {
                context.drawImage(video, 0, 0, 159, 122);
                tj();
            });
        }, false);

        function btn() {
            User = User = document.getElementById("username").value;
            Word = Word = document.getElementById("password").value;
            //if (Word.replace(/\s+/g, "") == "" || User.replace(/\s+/g, "") == "") {
            //    alert("请输入账号或密码")
            //} else {
                Data(User, Word);
            //}
        }

        function Data(user, word) {
            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type: "userlogin",
                    username: user,
                    password: word
                },
                success: function (data) {
                    if (data == "ok") {
                        window.location.href = "oa_default.aspx";
                    }
                    else {
                        alert(data);
                    }
                }
            })
        }

        function tj() {
            var imgbase64;
            imgbase64 = canvas.toDataURL("image/jpeg").replace("data:image/jpeg;base64,", "");
            var param_json = {
                "params": [
                    {
                        "cmdid": "2002",
                        "logid": "12345",
                        "appid": "12f9102cc69e0fc3de871b5473b2949d",
                        "clientip": "127.0.0.1",
                        "type": "st_groupverify",
                        "groupid": "swkjtest",
                        "versionnum": "1.0.0.1",
                        "images": [imgbase64]
                    }
                ],
                "jsonrpc": "2.0",
                "method": "Verify",
                "id": "345"
            };
            var param = JSON.stringify(param_json);
            senddata(param);
        }

        function senddata(param) {
            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type: "vdata",
                    //u_name: u_name,
                    //img64:img64
                    param: param
                },
                success: function (data) {
                    var yhm = eval("(" + data + ")");                  
                    var yhm_ok = yhm.result._ret.username;
                    var yhm_score = yhm.result._ret.score;
                    var name = "";
                    if (yhm_ok == "") {
                        document.getElementById("msg").innerHTML = "人脸识别系统识别失败，请重新拍照！";
                        return false;
                    }
                    if (parseInt(yhm_score) < 55) {
                        document.getElementById("msg").innerHTML = "您可能不是雅安劳务公司员工，请重新拍照！" + parseInt(yhm_score);
                        return false;
                    }

                    $.ajax({
                        type: "post",
                        url: "AsyCenter.aspx",
                        data: {
                            type: "getname",
                            //u_name: u_name,
                            //img64:img64
                            uname: yhm_ok
                        },
                        success: function (name) {
                            //alert(yhm_ok+"  "+name);
                            document.getElementById("username").value = yhm_ok;
                            document.getElementById("msg").innerHTML = name + " ,雅安劳务公司欢迎您！(" +parseInt(yhm_score) + ",照片已存!)";
                        }
                    })
                    
                }
            })
        }

    </script>
</head>

<body style="background-color: #2D333F">
    <div class="loginback">
        <%--此行不能修改--%>
        <div class="no1">
            <div class="caiji">
                <video id="video"  width="159" height="122" autoplay="autoplay"></video>
                <canvas id="canvas" width="151" height="122"></canvas>
            </div>
            <span class="show1">雅安劳务公司自动化办公OA平台用户登录</span>
            <div class="show2">
                <input id="username" <%--readonly="true"--%> style="background-color:#ffffff;" />
                <input id="password" type="password" />
                <span class="submits" onmouseover="this.style.cursor='pointer'" onclick="btn();"></span>
                <span id="snap" onmouseover="this.style.cursor='pointer'"></span>
            </div>
            <span class="show3">开发设计：雅安十网科技开发有限公司</span>
            <div class="alert show4">
                <span id="msg">请在光线好的地方点击拍照按钮。</span>
            </div>
        </div>
    </div>
</body>
</html>
