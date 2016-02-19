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
            letter-spacing: 1px !important; /*最小间距1px，可根据需要调整，不得低于1px*/
            font-size: 14px !important; /*最小文字大小14px，可根据需要调整，不得低于14px*/
        }

        span {
            font-family: "微软雅黑" !important; /*强制使用这种字体*/
            letter-spacing: 1px !important; /*最小间距1px，可根据需要调整，不得低于1px*/
            font-size: 14px !important; /*最小文字大小14px，可根据需要调整，不得低于14px*/
        }

        a {
            font-family: "微软雅黑" !important; /*强制使用这种字体*/
            letter-spacing: 1px !important; /*最小间距1px，可根据需要调整，不得低于1px*/
            font-size: 14px !important; /*最小文字大小14px，可根据需要调整，不得低于14px*/
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
            height:400px;
            float:left;
            margin-left:66px;
            margin-top:25px;
            border-style:solid; 
            border-width:1px; 
            border-color:#2774A6;
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
            border-bottom:1px solid #2774A6;
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
        .yc{
            overflow:hidden;
            text-overflow:ellipsis;
            white-space:nowrap;
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

            bindYCKQ();

            bindSPL();
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

        function qd()
        {
            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type:"qd"
                },
                success: function (data)
                {
                    if (data == "err") {
                        window.parent.location.href = "oa_login.aspx";
                    } else {
                        alert(data);
                    }
                }

            })
        }

        function qt()
        {
            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type: "qt"
                },
                success: function (data) {
                    if (data == "err") {
                        window.parent.location.href = "oa_login.aspx";
                    } else {
                        alert(data);
                    }
                }

            })
        }

        function loginout()
        {
            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type: "loginout"
                },
                success: function (data) {
                    alert(data);
                    window.parent.location.href = "oa_login.aspx";
                }
            })

        }

        function decode(str) {
                str = decodeURIComponent(str.replace(/\+/g, '%20'));
                return str;
            }

        function bindYCKQ()
        {
            var html = "";
            var data = "";
            var kqbox = document.getElementById("kqbox");
            try {
                data = eval("("+document.getElementById("yckq").value+")");
            } catch (e) {
                html = " <div style='width:300px;border-bottom:1px solid #2774A6;height:30px;'>" +
                            "<span style='display:block;line-height:30px;width:300px;text-align: center;'>无异常数据!</span>" +
                        "</div>";
                kqbox.innerHTML = html;
                return false;
            }

            var kqdate = "";
            var zt = "";
            var qj = "";
            var id = "";
            var ar_qj = "";
            var hl = "";
            for (var i = 0; i < data.length; i++) {
                var d = decode(data[i].day);
                d = d.substring(5, d.length);
                kqdate = d+" 上午";//.replace("-", "月").replace("-", "日");
                id = data[i].id;
                zt = data[i].a_state;
                qj = data[i].qj_a;
                ar_qj = data[i].ar_qj_a;
                hl = data[i].hl_a;
                if (zt != '0' && qj == "") {
                    if (ar_qj == "False") {
                        if (hl=="False") {
                            zt = getZT_(zt);
                            html = html + createbt(kqdate, zt, id, "sw");
                        }
                   
                    }
                }

                kqdate = kqdate.replace("上午", "下午");
                zt = data[i].p_state;
                qj = data[i].qj_p;
                ar_qj = data[i].ar_qj_p;
                hl = data[i].hl_p;
                if (zt != "0" && qj == "") { 
                    if (ar_qj == "False") {
                        if (hl=="False") {
                            zt = getZT_(zt);
                            html = html + createbt(kqdate, zt, id, "xw");
                        }
                    }
                  
                }
            }
            if (html=="") {
                html = " <div style='width:300px;border-bottom:1px solid #2774A6;height:30px;'>" +
                            "<span style='display:block;line-height:30px;width:300px;text-align: center;'>无异常数据</span>" +
                        "</div>";
            }
            kqbox.innerHTML = html;

        }

        function createbt(dates,zt,id,aop)
        {
            var html = "<div id='kq" + id + "" + aop + "' style='width:300px;border-bottom:1px solid #2774A6;height:30px;'>" +
                               "<span style='display:block;line-height:30px;width:115px;float:left;font-size: 10px;'>" + dates + "</span>" +
                               "<span style='display:block;line-height:30px;width:75px;float:left;'>" + zt + "</span>" +
                               "<a href='OA_kaoqingCL.aspx?id=" + id + "&aop="+aop+"' name='center' style='display:block;line-height:30px;width:55px;float:left;text-align:center;color:#fff'>处理</a>" +
                               "<a href='javascript:void(0)' onclick=hl('"+id+"','"+aop+"') style='display:block;line-height:30px;width:55px;float:left;text-align:center;color:#fff'>忽略</a>" +
                           "</div>";
           return html;
        }
        //('lwgs_' + CONVERT([varchar](4), (1000) + [id], 0))
        function hl(id, aop)
        {
            if (confirm("确定要忽略此条数据吗？")) {


                $.ajax({
                    type: "post",
                    url: "AsyCenter.aspx",
                    data: {
                        type: "hl",
                        kqid: id,
                        aop: aop
                    },
                    success: function (data) {
                        if (data == "1") {
                            document.getElementById("kq" + id + aop).style.display = "none";
                        } else {
                            alert("无法忽略此条记录");
                        }
                    }
                })

            }
        }

        function bindSPL()
        {
            var splbox = document.getElementById("splbox");
            var html = "";
            var data = document.getElementById("spl").value;
            var usreid = document.getElementById("user_id").value;
            var cl = "";
            try {
                data = eval("("+data+")");
            } catch (e) {
                html = " <div class='box_3'>当前没有要处理的审批流</div>";
                splbox.innerHTML = html;
                return false;
            }

            for (var i = 0; i < data.length; i++) {
                if (data[i].next_id.indexOf(usreid) != -1) {
                    cl = "处理";
                } else {     
                cl = "查看";
                } 
                html += " <div class='box_3'><span style='float:left; width:125px;' class='yc'>文件编号：" + CreateNo(data[i].id) + "</span><span style='margin-left:20px;float:left; width:300px;' class='yc' title=" + decode(data[i].titles) + ">" + decode(data[i].titles) + "</span><span style='float:left;width:50px; text-align:right;' class='yc'><a style='color:#fff' href=oa_splxq.aspx?lcid=" + data[i].id + "&type=ing>" + cl + "</a></span></div>";
            }
            splbox.innerHTML = html;
        }

        function CreateNo(baseno)
        {
            var r = "";
            var s=5;
            var bs = baseno.length;
            var offset = s - bs;
            for (var i = 0; i < offset; i++) {
                r = r + "0";
            }
            r = r + baseno+"";
            return r;
        }

        function getZT(tag_a,tag_p)
        {
            var zt = tag_a+tag_p+"";
            if (zt.indexOf("1") != -1) {
                zt=zt.replace("1", "迟到,");
            }
            if (zt.indexOf("2") != -1) {
                zt = zt.replace(new RegExp(/(2)/g), "早退,");
            }
            if (zt.indexOf("3") != -1) {
                zt = zt.replace(new RegExp(/(3)/g), "迟到,早退,");
            }
            if (zt.indexOf("4") != -1) {
                zt = zt.replace(new RegExp(/(4)/g), "旷工,");
            }

            if (zt.indexOf("早退") != zt.lastIndexOf("早退")) {
                zt = zt.replace("早退,", "");
            }
            if (zt.indexOf("迟到") != zt.lastIndexOf("迟到")) {
                zt = zt.replace("迟到,", "");
            }
            if (zt.indexOf("旷工") != zt.lastIndexOf("旷工")) {
                zt = zt.replace("旷工,", "");
            }
            zt = zt.substring(0, zt.lastIndexOf(","));
            return zt;
        }

        function getZT_(tag)
        {
            var r = "";
            if (tag=="1") {
                r = "迟到";
            } else if (tag=="2") {
                r = "早退";
            } else if (tag=="3") {
                r="迟到，早退"
            } else if (tag=="4") {
                r = "旷工";
            }
            return r;
        }

    </script>
</head>

<body>
    
    <input type="hidden" id="user_id" value="<%=userid %>" />
    <input type="hidden" id="spl" value='<%=json_spl %>' />
    <input type="hidden" id="yckq" value='<%=json_yckq %>' />
    <div style="width: 1000px;height:660px; margin: auto">
        <%--此行不能修改--%>
               <div class="row-fluid">
                <div style="width:1000px;height:72px; background-color:#004B7C;">

                    <span style="margin:0 25px 0 40px; line-height:72px;"><a href="javascript:void(0)" onclick="loginout()" style="color:#ffffff; font-weight:bold;">退出登录</a></span>

                    <img src="img/bell-3.png"  style="width:15px; height:15px;"/>

                    <span style="margin:0 0 0 120px; color:#808080;line-height:72px"><%=NameTitle %></span>

                    <span style="margin:0 0 0 180px;line-height:72px"><a href="javascript:void(0);" onclick="qd()" style="color:#ffffff; font-weight:bold;">签到</a></span>

                    <span style="margin:0 0 0 20px;line-height:72px"><a href="javascript:void(0);" onclick="qt()" style="color:#ffffff; font-weight:bold;">签退</a></span>

                    <span style="margin:0 0 0 20px; color:#808080;line-height:72px">当前时间：</span><span id="shijian" style="color:#808080;line-height:72px;">正在获取服务器时间请稍后...</span>

                </div>

        </div>

<%--        <div style="width:1000px; height:40px; background-color:#C23810;"></div>--%>
        <div class="row-fluid" style="height:550px; background-color:#0563A0">
            <div class="box" style="width: 315px; height:402px; overflow:hidden; overflow-y:auto;">

                <span style="width: 300px; height:50px; line-height:50px; display:block;text-align:center;border-bottom:1px solid #2774A6;color:#ffffff; font-weight:bold; letter-spacing:3px !important;">异常上班时间</span>
                <div id="kqbox" style="width:300px;height:269px;overflow-y:auto;color:#ffffff">
                    
                </div>

            </div>

            <div class="box" style="width:515px; height:402px; overflow:hidden; overflow-y:auto;">

                <span style="display:block;text-align:center;border-bottom:1px solid #2774A6;color:#ffffff; height:50px; line-height:50px; font-weight:bold; letter-spacing:3px !important;">当前审批流</span>
                <div id="splbox" style="color:#ffffff">

                </div>

            </div>   

            <div style="width:1000px; height:100px; margin-top:450px;">

            </div>

    </div>
    </div>
</body>
</html>

