<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_photo.aspx.cs" Inherits="OA_photo" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../Script/jquery-1.8.2.min.js"></script>
    <script src="../Script/swkj.js"></script>
    <link href="../Style/swkj.css" rel="stylesheet" />
    <link href="../Style/swkjbt.css" rel="stylesheet" />
    <title>拍照界面</title>
    <style type="text/css">
        span {
            font-family: "微软雅黑" !important; /*强制使用这种字体*/
            letter-spacing: 2px; /*最小间距1px，可根据需要调整，不得低于1px*/
            font-size: 14px; /*最小文字大小14px，可根据需要调整，不得低于14px*/
        }

        #video {
            width: 300px;
            height: 225px;
            display: block;
            float: left;
            margin: 15px 0 0 150px;
            border: 5px solid #FD931B;
        }

        #snap {
            display: block;
            float: left;
            margin: 26px 0 0 255px;
            width: 100px;
            height: 40px;
            line-height: 40px;
            background-color: #FD931B;
            text-align: center;
            color: #ffffff;
        }

        #canvas {
            width: 300px;
            height: 225px;
            margin: 15px 0 0 80px;
            border: 5px solid #f26666;
        }

        #user {
            font-weight: bold;
            font-size: 16px;
            line-height: 80px;
            display: block;
            margin-left: 150px;
            color: #575757;
            letter-spacing: 3px;
        }

        #tj {
            display: block;
            float: left;
            width: 100px;
            height: 40px;
            line-height: 40px;
            background-color: #F26666;
            margin: 26px 0 0 290px;
            color: #ffffff;
            text-align: center;
        }
    </style>

    <script type="text/javascript">
        var $_GET = (function () {
            var url = parent.document.getElementById("ppshow").contentWindow.location.href.toString();
            var u = url.split("?");
            if (typeof (u[1]) == "string") {
                u = u[1].split("&");
                var get = {};
                for (var i in u) {
                    var j = u[i].split("=");
                    get[j[0]] = j[1];
                }
                return get;
            } else {
                return {};
            }
        })();
        var canvas;
        var context;
        var video;
        var videoObj;
        var errBack;
        window.onload = function () {
            document.getElementById("user").innerHTML = "当前用户：" + $_GET['u_name111'];
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
                context.drawImage(video, 0, 0, 300, 225);
            });
        }, false);
            
        function tj() {
            var imgbase64;
            imgbase64 = canvas.toDataURL("image/jpeg").replace("data:image/jpeg;base64,", "");
            //document.getElementById("base").innerHTML = imgbase64;
            // imgbase64已经测试正常，字符串大小大概有50k-150k的长度。将其按用户名提交imgbase64数据到相应用户u_name数据库下

            var id = $_GET['id'];
            savedata(id, imgbase64);
        }

        function savedata(id,imgbase64)
        {
            $.ajax({
                type: "post",
                url: "../AsyCenter.aspx",
                data: {
                    type: "saveimgb64",
                    id: id,
                    b64:imgbase64
                },
                success: function (data)
                {
                    if (data == "1") {
                        alert("数据提交成功，请点击右上方红色关闭按钮关闭拍照。");
                    } else {
                        alert("数据提交失败!");
                    }
                }

            })
        }
    </script>
</head>

<body>
    <div style="width: 980px; height: 580px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">
            <%--此行不能修改--%>
            <div><span id="user">当前用户：</span></div>
            <div>
                <video id="video"  width="300" height="225" autoplay="autoplay"></video>
                <canvas id="canvas" width="300" height="225"></canvas>
            </div>
            <div>
                <span id="snap" onmouseover="this.style.cursor='pointer'">正式拍照</span>
                <span id="tj" onmouseover="this.style.cursor='pointer'" onclick="javascript:tj();">提交这张</span>
            </div>
<%--            <div><p id="base"></p></div>--%>
        </div>
    </div>
</body>
</html>
