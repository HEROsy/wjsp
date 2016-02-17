<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_photo.aspx.cs" Inherits="OA_photo" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../Script/jquery-1.11.1.min.js"></script>
    <script src="../Script/jquery.facedetection.js"></script>
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
            float:left;
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
            display:none;
        }
        .lunkuo {
            width: 300px;
            height: 225px;
            background-image:url(../img/lunkuo.png);
            background-repeat:no-repeat;
            position: absolute;
            z-index: 10;
            margin: -235px 0 0 155px;
        }
        .sm {
            margin-top: 90px;
            margin-left: 20px;
        }

            .sm span {
                display: block;
                line-height: 25px;
                color: #FD931B;
            }
        #face {
            position: absolute;
            border: 2px solid #FFF;
        }
        #del_api_user {
            display: none;
            float: left;
            height: 40px;
            width: 120px;
            line-height: 40px;
            letter-spacing: 1px;
            text-align: center;
            background-color: #F46161;
            color: #ffffff;
            margin: 20px 0 0 120px;
            border-radius: 21px;
        }
        #tishi {
            position: fixed;
            z-index: 999;
            font-size: 100px;
            width: 500px;
            height: 500px;
            text-align: center;
            margin: -368px 0 0 252px;
            color: #6B70CF;
            display: none;
        }
    </style>

    <script type="text/javascript">
        //APIkey:12f9102cc69e0fc3de871b5473b2949d
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
        var jc;
        window.onload = function () {
            document.getElementById("user").innerHTML = "当前拍照采集用户：" + decodeURI($_GET['name']) + "(" + decodeURI($_GET['u_name']) + ")";
            jc = setInterval("jiance()", 3000);
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
                $('#face').remove();
                clearInterval(jc);
                facedetection();
            });
        }, false);


        function facedetection() {
            $('#canvas').faceDetection({
                complete: function (faces) {
                    if (faces.length == 0) {
                        document.getElementById("tj").style.display = "none";
                        alert("没有检测到人脸，请在光线比较好的地方重新拍照！");
                        jc = setInterval("jiance()", 3000);
                        return;
                    }
                    if (faces.length > 1) {
                        document.getElementById("tj").style.display = "none";
                        alert("检测到1个以上的人脸，请按照规定一个人拍照！");
                        jc = setInterval("jiance()", 3000);
                        return;
                    }
                    if (faces.length == 1) {
                        if (faces[0].width < 60) {
                            document.getElementById("tj").style.display = "none";
                            alert("预设头像太小，请靠近一点，重新拍照！");
                            jc = setInterval("jiance()", 3000);
                            return;
                        } else if (faces[0].height < 60) {
                            document.getElementById("tj").style.display = "none";
                            alert("预设头像太小，请靠近一点，重新拍照！");
                            jc = setInterval("jiance()", 3000);
                            return;
                        } else {
                            document.getElementById("tj").style.display = "block";
                        }
                    }
                }
            });

            //x — 图片中人脸的X坐标
            //y — 图片中人脸的Y坐标
            //width — 人脸的宽度
            //height — 人脸的高度
            //positionX — 相对于文档的X坐标
            //positionY — 相对于文档的Y坐标
            //offsetX — 相对于父元素的X偏移
            //offsetY — 相对于父元素的Y偏移
            //scaleX — 实际显示和原始宽度比
            //scaleY — 实际显示和原始高度比
            //confidence — 准确度
        }

        function jiance() {
            $('#face').remove();
            $('#video').faceDetection(
                {
                //interval: 1,
                complete: function (faces) {
                    for (var i = 0; i < faces.length; i++) {
                        $('<div>', {
                            'id': 'face',
                            'css': {
                                'left': faces[i].x * faces[i].scaleX + 155 + 'px',
                                'top': faces[i].y * faces[i].scaleY + 90 + 'px',
                                'width': faces[i].width * faces[i].scaleX+10 + 'px',
                                'height': faces[i].height * faces[i].scaleY + 35 + 'px',
                            }
                        })
                        .insertAfter(this);
                    }
                },
                error: function (code, message) {
                    alert('Error: ' + message);
                }
            }
            );
        }

        function tj() {
            var imgbase64;
            imgbase64 = canvas.toDataURL("image/jpeg").replace("data:image/jpeg;base64,", "");
            var id = $_GET['id'];
            savedata(id, imgbase64);
            // senddata(decodeURI($_GET['u_name']),imgbase64)
            var param_json = {
                "params": [
                    {
                        "username": $_GET['u_name'],
                        "cmdid": "1000",
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
                "method": "Register",
                "id": "345"
            };
            var param = JSON.stringify(param_json);
            senddata(param);
        }

        function senddata(param)
        {
            $.ajax({
                type: "post",
                url: "../AsyCenter.aspx",
                data: {
                    type: "requestimgdata",
                    param:param
                },
                success: function (data) {
                    var messages = eval("(" + data + ")");
                    messages = messages.result._ret.errnum;
                    if (messages=="0") {
                        alert("远程人脸数据提交成功，请点击右上方红色关闭按钮关闭拍照。");
                    }
                    if (messages == "-2") {
                        alert("远程人脸数据提交失败，用户名已经注册，请点击上方“删除人脸数据”按钮后重试，错误码-2。");
                        document.getElementById("del_api_user").style.display = "block";
                        return false;
                    }
                    if (messages == "-4") {
                        alert("远程人脸数据提交失败，模型保存失败	建议重新执行；请点击上方“删除人脸数据”按钮后重试，错误码-4。");
                        document.getElementById("del_api_user").style.display = "block";
                        return false;
                    }
                    if (messages == "-6") {
                        alert("远程人脸数据提交失败，服务保存用户数据失败，请重试，一直失败请联系十网科技客服，错误码-6。");
                        return false;
                    }
                    if (messages == "-8") {
                        alert("远程人脸数据提交失败，没有检测到人脸，重试，错误码-8。");
                        return false;
                    }
                    if (messages == "-11") {
                        alert("远程人脸数据提交失败，解析图像参数失败，可能传输内容非图片、图片过大等，错误码-11。");
                        return false;
                    }
                    if (messages == "-12") {
                        alert("远程人脸数据提交失败，加载图片失败，图片解析失败，请确认图片文件格式正确，并且做了base64编码，错误码-12。");
                        return false;
                    }
                }
            })
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
                        alert("本地数据提交成功。");
                    } else {
                        alert("本地数据提交失败!，远程数据尚未提交");
                        return false;
                    }
                }
            })
        }

        function dau() {
            var param_json = {
                "params": [
                    {
                        "username": $_GET['u_name'],
                        "cmdid": "1000",
                        "logid": "12345",
                        "appid": "12f9102cc69e0fc3de871b5473b2949d",
                        "clientip": "127.0.0.1",
                        "type": "st_groupverify",
                        "groupid": "swkjtest",
                        "versionnum": "1.0.0.1",
                    }
                ],
                "jsonrpc": "2.0",
                "method": "Delete",
                "id": "345"
            };
            var param = JSON.stringify(param_json);
            daudata(param);
        }

        function daudata(param) {
            $.ajax({
                type: "post",
                url: "../AsyCenter.aspx",
                data: {
                    type: "dau",
                    param: param
                },
                success: function (data) {
                    var messages = eval("(" + data + ")");
                    messages = messages.result._ret.errnum;
                    if (messages == "0") {
                        alert("用户人脸数据删除成功，请点击下方“提交这张”按钮重新提交，无需重新拍照。");
                        document.getElementById("del_api_user").style.display = "none";
                    }
                    if (messages == "-1") {
                        alert("未知失败，可能是连接断开，内部超时，系统错误等，请重试。错误码-1。");
                        document.getElementById("del_api_user").style.display = "block";
                        return false;
                    }
                    if (messages == "-3") {
                        alert("要删除的用户不存在，错误码-3。");
                        document.getElementById("del_api_user").style.display = "block";
                        return false;
                    }
                    if (messages == "-7") {
                        alert("用户删除失败，请重试，一直失败请联系十网科技客服，错误码-7。");
                        return false;
                    }
                    if (messages == "-9") {
                        alert("用户删除失败，请重试，一直失败请联系十网科技客服，错误码-9。");
                        return false;
                    }
                    if (messages == "-13") {
                        alert("无法提取用户(username)+用户组(groupid)的信息，错误码-13。");
                        return false;
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
            <div style="height:80px;"><span id="user">当前用户：</span><span id="del_api_user"  onmouseover="this.style.cursor='pointer'" onclick="javascript:dau();">删除人脸数据</span></div>
            <div>
                <video id="video"  width="300" height="225" autoplay="autoplay"></video>
                <canvas id="canvas" width="300" height="225"></canvas>
            </div>
            <div>
                <span id="snap" onmouseover="this.style.cursor='pointer'">正式拍照</span>
                <span id="tj" onmouseover="this.style.cursor='pointer'" onclick="javascript:tj();">提交这张</span>
            </div>
            <div class="lunkuo"></div>
            <div class="sm">
                <span style="color:#F26666;font-size:16px;line-height:30px;">拍照小常识-提高采样成功几率</span>
                <span>1、脸部要正对摄像头,勿水平转动或抬高和压低头部。</span>
                <span>2、最好不要有眼镜、头发遮盖脸部，如带眼镜或头发遮盖的用户多次拍摄不成功，请取下眼镜或撩开头发遮盖的面部或额部重试。日后登录签到识别也需如此。</span>
                <span>3、光线不要太暗或者太亮，室内亮度调节为普通白天的室外光线亮度最佳。</span>
                <span>4、采集时候人要保持静止，切勿乱动，同时摄像头要调节清晰。</span>
            </div>
        </div>
<%--        <div id="me"><img src="../img/me.jpg" /><span id="sss"></span></div>--%>
    </div>

    <div id="tishi"></div>
</body>
</html>
