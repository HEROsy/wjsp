<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_center.aspx.cs" Inherits="OA_center" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Script/swkj.js"></script>
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />
    <title>用户中心</title>
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
                 a:hover{
            color:#EE8D09;
        }
        .box{
            height:300px;
            float:left;
            margin-left:40px;
            border-style:solid; 
            border-width:2px; 
            border-color:#B5B5B5;
        }
        span {
            font-family:微软雅黑;
            font-size:14px;
        }
        .fgx{
            width: 300px; 
            height: 1px; 
            background-color: #B5B5B5;
        }
        .fgx_1{
            width: 500px; 
            height: 1px; 
            background-color: #B5B5B5;
        }
        .box_1{
            width:300px;
            height:30px; 
            line-height:30px;
        }
        .box_2{
            float:left;
            width:80px;
            border-style:solid;
            border-width:1px;
            border-color:#B5B5B5;
        }
        .box_3{
            width:500px;
            height:30px; 
            line-height:30px;
        }
        .box_2_1{
            float:left;
            width:30px;
            border-style:solid;
            border-width:1px;
            border-color:#B5B5B5;
        }
        .box_2_2{
            margin-left:20px;
        }
        .box_2_3{
            margin-left:10px;
        }
    </style>

    <script type="text/javascript">
        var xmlHttp = false;
        //获取服务器时间
        try {
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e2) {
                xmlHttp = false;
            }
        }

        if (!xmlHttp && typeof XMLHttpRequest != 'undefined') {
            xmlHttp = new XMLHttpRequest();
        }

        xmlHttp.open("GET", window.location.href.toString(), false);
        xmlHttp.setRequestHeader("Range", "bytes=-1");
        xmlHttp.send(null);

        severtime = new Date(xmlHttp.getResponseHeader("Date"));

        //获取服务器日期
        var year = severtime.getFullYear();
        var month = severtime.getMonth() + 1;
        var date = severtime.getDate();
        //获取服务器时间
        var hour = severtime.getHours();
        var minu = severtime.getMinutes();
        var seco = severtime.getSeconds();
        var week = ' 星期' + '日一二三四五六'.charAt(severtime.getDay())
        //格式化输出服务器时间
        window.onload = function () {
            flush();
        }

        function flush() {
            setInterval("getSeverTime()", 1000);
        }

        function getSeverTime() {
            seco++;
            if (seco == 60) {
                minu += 1;
                seco = 0;
            }
            if (minu == 60) {
                hour += 1;
                minu = 0;
            }
            if (hour == 24) {
                date += 1;
                hour = 0;
            }
            //日期处理
            if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
                if (date == 32) {
                    date = 1;
                    month += 1;
                }
            } else if (month == 4 || month == 6 || month == 9 || month == 11) {
                if (date == 31) {
                    date = 1;
                    month += 1;
                }
            } else if (month == 2) {
                if (year % 4 == 0 && year % 100 != 0) {//闰年处理
                    if (date == 29) {
                        date = 1;
                        month += 1;
                    }
                } else {
                    if (date == 28) {
                        date = 1;
                        month += 1;
                    }
                }
            }
            if (month == 13) {
                year += 1;
                month = 1;
            }
            var sseco = addZero(seco);
            var sminu = addZero(minu);
            var shour = addZero(hour);
            var sdate = addZero(date);
            var smonth = addZero(month);
            var syear = year;

            document.getElementById("shijian").innerHTML = syear + "-" + smonth + "-" + sdate + " " + shour + ":" + sminu + ":" + sseco + " " + week;

            function addZero(num) {
                num = Math.floor(num);
                return ((num <= 9) ? ("0" + num) : num);
            }
        }
</script>
</head>

<body>
    <div style="width: 1000px;height:680px; margin: auto">
        <%--此行不能修改--%>
               <div class="row-fluid">
                <div style="width:1000px;height:42px; background-color:#92DCE0;">

                    <span style="line-height:35px; margin:0 25px 0 40px;" >退出登录</span>

                    <img src="img/bell-2.png"  style="width:30px; height:30px;"/>

                    <span style="margin:0 0 0 210px;">姜凯源，早上好</span>

                    <span style="margin:0 0 0 180px"><a href="QD.aspx">签到</a></span>

                    <span style="margin:0 0 0 20px"><a href="Qt.aspx">签退</a></span>

                    <span style="margin:0 0 0 20px">当前时间：</span><span id="shijian">正在获取服务器时间请稍后...</span>

                </div>

        </div>

        <div style="width:1000px; height:40px; background-color:#0092D7;"></div>

        <div class="row-fluid" style="height:345px; background-color:#0092D7">

            <div class="box" style="width: 300px;">

                <span style="width: 300px; height:30px; line-height:30px; margin-left:102px;">异常上班时间</span>

                <div class="box_1">

                <div class="fgx"></div>

                <span style="margin-left:23px;">09:00-12:00</span>

                <span style="margin-left:50px;"><a href="#">处理</a></span>

                <span style="margin-left:50px"><a href="#">忽略</a></span>

                </div>

                <div class="box_1">

                <div class="fgx"></div>

                <span style="margin-left:23px;">09:00-12:00</span>

                <span style="margin-left:50px;"><a href="#">处理</a></span>

                <span style="margin-left:50px"><a href="#">忽略</a></span>

                </div>

                <div class="box_1">

                <div class="fgx"></div>

                <span style="margin-left:23px;">09:00-12:00</span>

                <span style="margin-left:50px;"><a href="#">处理</a></span>

                <span style="margin-left:50px"><a href="#">忽略</a></span>

                </div>

                <div class="box_1">

                <div class="fgx"></div>

                <span style="margin-left:23px;">14:00-18:00</span>

                <span style="margin-left:50px;"><a href="#">处理</a></span>

                <span style="margin-left:50px"><a href="#">忽略</a></span>

                </div>

                <div class="box_1">

                <div class="fgx"></div>

                <span style="margin-left:23px;">14:00-18:00</span>

                <span style="margin-left:50px;"><a href="#">处理</a></span>

                <span style="margin-left:50px"><a href="#">忽略</a></span>

                </div>

                <div class="box_1">

                <div class="fgx"></div>

                <span style="margin-left:23px;">09:00-12:00</span>

                <span style="margin-left:50px;"><a href="#">处理</a></span>

                <span style="margin-left:50px"><a href="#">忽略</a></span>

                </div>

                <div class="fgx"></div>

                <div style="margin: 100px 0 0 20px;">
                    <a href="#"><div class="box_2"><span class="box_2_2">上一页</span></div></a>
                    <a href="#"><div class="box_2_1"><span class="box_2_3">1</span></div></a>
                    <a href="#"><div class="box_2_1"><span class="box_2_3">2</span></div></a>
                    <a href="#"><div class="box_2_1"><span class="box_2_3">3</span></div></a>
                    <a href="#"><div class="box_2"><span class="box_2_2">下一页</span></div></a>
                </div>

            </div>

            <div class="box" style="width:500px;">

                <span style="margin-left:265px;">当前审批流</span>

                <div class="box_3">

                <div class="fgx_1"></div>

                <span style="margin-left:74px;">文件编号：000001</span>

                <span style="margin-left:74px;">标题</span>

                <span style="margin-left:74px;">处理</span>

                </div>

                <div class="box_3">

                <div class="fgx_1"></div>

                <span style="margin-left:74px;">文件编号：000001</span>

                <span style="margin-left:74px;">标题</span>

                <span style="margin-left:74px;">处理</span>

                </div>


                <div class="box_3">

                <div class="fgx_1"></div>

                <span style="margin-left:74px;">文件编号：000001</span>

                <span style="margin-left:74px;">标题</span>

                <span style="margin-left:74px;">处理</span>

                </div>


                <div class="box_3">

                <div class="fgx_1"></div>

                <span style="margin-left:74px;">文件编号：000001</span>

                <span style="margin-left:74px;">标题</span>

                <span style="margin-left:74px;">处理</span>

                </div>


                <div class="box_3">

                <div class="fgx_1"></div>

                <span style="margin-left:74px;">文件编号：000001</span>

                <span style="margin-left:74px;">标题</span>

                <span style="margin-left:74px;">处理</span>

                </div>

                <div class="fgx_1"></div>

                <div style="margin: 141px 0 0 80px;">
                    <a href="#"><div class="box_2"><span class="box_2_2">上一页</span></div></a>
                    <a href="#"><div class="box_2_1"><span class="box_2_3">1</span></div></a>
                    <a href="#"><div class="box_2_1"><span class="box_2_3">2</span></div></a>
                    <a href="#"><div class="box_2_1"><span class="box_2_3">3</span></div></a>
                    <a href="#"><div class="box_2_1"><span class="box_2_3">4</span></div></a>
                    <a href="#"><div class="box_2_1"><span class="box_2_3">5</span></div></a>
                    <a href="#"><div class="box_2"><span class="box_2_2">下一页</span></div></a>
                </div>

        </div>   

    </div>
    </div>
</body>
</html>

