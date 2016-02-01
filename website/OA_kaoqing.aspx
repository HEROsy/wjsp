<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_kaoqing.aspx.cs" Inherits="OA_kaoqing" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Script/swkj.js"></script>

    <title>我的考勤界面</title>
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

        .top {
            height: 100px;
            width: auto;
        }

        .top1 {
            height: 100px;
            width: 250px;
        }

        .top2 {
            height: 100px;
            width: 600px;
            margin-left: 398px;
            border: 1px solid #CFCFCF;
            position:absolute;
            z-index:-1;
            top:110px;
        }

        .img {
            height: 40px;
            margin: 40px 0 0 0px;
            display: inline-block;
            width: 40px;
            background-image: url(img/c1.png);
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
        }

        .mid {
            height: 100px;
            width: auto;
            background-image: url(img/G2.png);
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
        }

        .inner {
            height: 30px;
            width: auto;
            background-color: #0092D7;
        }

        .inner1 {
            height: 60px;
            width: 40px;
            float: left;
        }

        .img2 {
            height: 30px;
            float: left;
            width: 30px;
            margin-top: 26px;
            background-image: url(img/v2.png);
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
        }

        .bm {
            height: 490px;
            border: 1px solid #F0EFEF;
        }

        .bm1 {
            height: 50px;
            width: auto;
            border-bottom: 1px solid #F4F5F5;
        }
            .bm1:hover {
                background-color:#F5F5F5;
            }

        .img3 {
            background-image: url(img/y2.png) !important;
        }

        .img4 {
            background-image: url(img/y3.png) !important;
        }
        .imgno {
            height: 25px;
            width: 25px;
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
            background-image: url(img/y1.png);
            display: block;
            margin: 12px 0 0 39px;
            float: left;
        }

        .s1 {
            display: block;
            width: 213px;
            height: 50px;
            line-height: 50px;
            margin-left: 57px;
            font-size: 14px;
            float: left;
        }

        .s2 {
            height: 50px;
            width: 141px;
            line-height: 50px;
            font-size: 14px;
            display: block;
            float: left;
        }

        .s3 {
            font-size: 14px;
            display: block;
            float: left;
            height: 50px;
            width: 100px;
            line-height: 50px;
        }

        .top3 {
            height: 50px;
            width: auto;
        }

        .img5 {
            height: 30px;
            width: 30px;
            margin: 10px 0 0 184px;
            float: left;
            -moz-transition: all 0.2s ease-in-out;
            -webkit-transition: all 0.2s ease-in-out;
            -o-transition: all 0.2s ease-in-out;
            -ms-transition: all 0.2s ease-in-out;
            transition: all 0.2s ease-in-out;
            background-image: url(img/h1.png);
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
        }

            .img5:hover {
                -moz-transform: rotate(360deg);
                -webkit-transform: rotate(360deg);
                -o-transform: rotate(360deg);
                -ms-transform: rotate(360deg);
                transform: rotate(360deg);
            }

        .chuqin {
            margin-left: 20px;
            margin-top: 14px;
            display: inline-block;
            font-family: "微软雅黑" !important;
            letter-spacing: 1px;
            font-size: 14px;
        }

        .top4 {
            height: 25px;
            width: 160px;
            float: left;
            margin-left: 30px;
        }

        .img6 {
            height: 25px;
            width: 25px;
            float: left;
            background-image: url(img/h3.png);
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
        }

        .img11 {
            height: 25px;
            width: 25px;
            float: left;
            background-image: url(img/d2.png);
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
        }

        .chidao1 {
            display: inline-block;
            margin-top: 2px;
            margin-left: 10px;
        }

        .chidao2 {
            color: #f26666;
        }

        .pagination {
            margin: 30px 0 0 710px;
        }

        select {
            width:135px !important;
            margin-top: 26px;
        }
        #xzsj {
            color: #ffffff;
            font-weight: bold;
            line-height: 29px;
            letter-spacing:2px;
        }

        .tongji {
            color: #ffffff;
            display: inline-block;
            width: 129px;
            line-height: 25px;
        }
        .sb {
            display: inline-block;
            width: 11px;
            height: 11px;
            margin-right: 12px;
            -moz-border-radius: 15px; /* Gecko browsers */
            -webkit-border-radius: 15px; /* Webkit browsers */
            border-radius: 15px; /* W3C syntax */
        }
        .bs1 {
            background-color:#f2c618;
        }
        .bs2 {
            background-color:#f2c618;
        }
        .bs3 {
            background-color:#db46ff;
        }
        .bs4 {
            background-color:#07e2d5;
        }
        .bs5 {
            background-color:#f26666;
        }
        .bs6 {
            background-color:#11f808;
        }


        .bq1 {
            color:#f2c618;
        }
        .bq2 {
            color:#f2c618;
        }
        .bq3 {
            color:#db46ff;
        }
        .bq4 {
            color:#07e2d5;
        }
        .bq5 {
            color:#f26666;
        }
        .bq6 {
            color:#11f808;
        }
        .readbzt {
            height: 45px;
            width: 250px;
            background-color: #F47575;
            display: block;
            color: #ffffff;
            text-align: center;
            line-height: 46px;
            margin: 20px 0 0 375px;
            letter-spacing: 4px;
            font-size: 16px;
        }
            .readbzt:hover {
                background-color:#fb8484;
            }
        #zhezhao {
            width: 100%;
            height: 658px;
            position: absolute;
            background-color: #ffffff;
            visibility:hidden;
        }
        .zzclose {
            margin: 25px 0 0 950px;
            width: 25px;
            height: 25px;
            position: absolute;
        }
    </style>

    <script type="text/javascript">
        //获取服务器时间
        var xmlHttp = false;
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
        var n;
        var y;
        window.onload = function () {
            nian();
            yue();
            yesno();

            BindYears();
            BindMonth();
            
        }
        function tongji() {
            n = document.getElementById("test_3").value;
            y = document.getElementById("test_4").value;
            document.getElementById("xzsj").innerHTML = "当前统计时间段为："+n+"年"+y+"月";
        }
        function nian() {
            var nian_html="";
            for (var i = 0; i < 5; i++) {
                nian_html = nian_html + "<option value='" + (year - i) + "'>" + (year - i) + "年</option>";
            }
            test_3.innerHTML = nian_html;
        }
        function yue() {
            var yue_html = "";
            for (var i = month; i >0; i--) {
                yue_html = yue_html + "<option value='" + i + "'>" + i + "月</option>";
            }
            test_4.innerHTML = yue_html;
        }
        function yesno() {
            var d = $('#bm').find(".bm1");
            var dd = $('#bm').find(".imgno");
            var ddd = $('#bm').find(".s3");
            for (var i = 0; i < d.length; i++) {
                if (d[i].innerHTML.indexOf("迟到") >= 0 || d[i].innerHTML.indexOf("早退") >= 0 || d[i].innerHTML.indexOf("病假") >= 0 || d[i].innerHTML.indexOf("事假") >= 0 || d[i].innerHTML.indexOf("旷工") >= 0) {
                    dd[i].setAttribute("class", "imgno img3");
                } else {
                    dd[i].setAttribute("class", "imgno img4");
                }               
            }
            for (var j = 0; j < ddd.length; j++) {
                if (ddd[j].innerHTML.indexOf("迟到") >= 0) {
                    ddd[j].setAttribute("class", "s3 bq1");
                }
                if (ddd[j].innerHTML.indexOf("早退") >= 0) {
                    ddd[j].setAttribute("class", "s3 bq2");
                }
                if (ddd[j].innerHTML.indexOf("病假") >= 0) {
                    ddd[j].setAttribute("class", "s3 bq3");
                }
                if (ddd[j].innerHTML.indexOf("事假") >= 0) {
                    ddd[j].setAttribute("class", "s3 bq4");
                }
                if (ddd[j].innerHTML.indexOf("旷工") >= 0) {
                    ddd[j].setAttribute("class", "s3 bq5");
                }
                if (ddd[j].innerHTML.indexOf("正常") >= 0) {
                    ddd[j].setAttribute("class", "s3 bq6");
                }
            }
        }
        function bzt() {
            var xzsj = document.getElementById("xzsj").innerHTML;
            var t1 = document.getElementById("t1").innerHTML;
            t1 = (t1 / 480).toFixed(2);
            var t2 = document.getElementById("t2").innerHTML;
            t2 = (t2 / 480).toFixed(2);
            var t3 = document.getElementById("t3").innerHTML;
            var t4 = document.getElementById("t4").innerHTML;
            var t5 = document.getElementById("t5").innerHTML;
            var t6 = document.getElementById("t6").innerHTML;  
            var canshu = "?t1=" + t1 + "&t2=" + t2 + "&t3=" + t3 + "&t4=" + t4 + "&t5=" + t5 + "&t6=" + t6 + "&year=" + n + "&month=" + y;
            if (xzsj.indexOf("左侧选择时间") >= 0) {
                alert("请先选择时间，加载数据以后，再点击查看饼状图");
            }
            else {
                document.getElementById("zhezhaoshow").innerHTML = "<iframe src='plus/bing.html" + canshu + "' style='width:990px;height:601px;border: 1px solid #F4F4F4;' id='ppshow'></iframe>";
                document.getElementById("zhezhao").style.visibility = "visible";
            }
            
        }
        function zhezhao() {
            document.getElementById("zhezhaoshow").innerHTML = "";
            document.getElementById("zhezhao").style.visibility = "hidden";
        }

        //
        
        function BindYears()
        {
            var years = document.getElementById("years").value;
            //用 ‘,’ 分割years 绑定到年份下拉框
        }

        function BindMonth()
        {
            //绑定1－12月
        }

        function GetDataAndTonji()
        {
            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type: "onekaoqingdata",
                    year:"",//选中的年份
                    month:""//月份
                },
                success: function (data)
                {
                    //1解析data 绑定列表(解析不成功 显示无数据)

                    //2调用原有的统计函数
                    tongji();

                    //3计算迟到，早退，等时间 显示到相应地方

                }
            })
        }

</script>
</head>
<body>
    <input type="hidden" id="years" value="<%=years %>" />
    <div id="zhezhao">
        <div style="width: 1000px; height: 658px; margin: auto">
            <div style="width: 1000px; height: 10px;">
                <img src="img/zz_close.png" class="zzclose" onmouseover="this.style.cursor='pointer'" onclick="javascript:zhezhao();"/>
            </div>
            <div style="width: 1000px; height: 615px;" id="zhezhaoshow">               
            </div>
        </div>
    </div>
    <div style="width: 1000px; height: 658px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 5px">
            <%--此行不能修改--%>
            <div class="top">
                <div class="mid">
                    <div class="row-fluid">
                        <div class="span12" style="height: 80px;margin-top:10px;">
                            <div class="inner1"></div>
                            <div style="float: left; width: 180px;height: 80px;">
                                <select id="test_3">
                                    <option value="none">正在获取年份...</option>
                                </select>
                            </div>
                            <div style="float: left; width: 180px;height: 80px;">
                                <select id="test_4">
                                    <option value="none">正在获取月份...</option>
                                </select>
                            </div>
                            <div class="img2" onmouseover="this.style.cursor='pointer'" onclick="javascript:GetDataAndTonji();"></div>
                            <div style="width: 470px;height: 80px;float: left;margin-left:96px;">
                                <div><span id="xzsj">当前统计时间段为：请在左侧选择时间</span></div>
                                <%--下面的时间如果是分钟就转为分钟数显示，如果是天数就转为天数显示，分钟精度为1分钟，天数精度为0.5天，请勿更改格式--%>
                                <div><span class="sb bs1"></span><span class="tongji">迟到：<span id="t1">30</span>分钟</span><span class="sb bs2"></span><span class="tongji">早退：<span id="t2">50</span>分钟</span><span class="sb bs3"></span><span class="tongji">病假：<span id="t3">1</span>天</span></div>
                                <div><span class="sb bs4"></span><span class="tongji">事假：<span id="t4">0</span>天</span><span class="sb bs5"></span><span class="tongji">旷工：<span id="t5">0.5</span>天</span><span class="sb bs6"></span><span class="tongji">正常：<span id="t6">18</span>天</span></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bm" id="bm">
                    <div class="bm1">
                        <div class="row-fluid">
                            <div class="span8">
                                <div class="imgno"></div>
                                <span class="s1">2015年12月05号</span>
                                <span class="s2">9:07-12:00</span>
                                <span class="s3">正常</span>
                            </div>
                            <div class="span4">
                                <span class="s2">14:30-17:22</span>
                                <span class="s3">正常</span>
                            </div>
                        </div>
                    </div>

                    <div class="bm1">
                        <div class="row-fluid">
                            <div class="span8">
                                <div class="imgno"></div>
                                <span class="s1">2015年12月05号</span>
                                <span class="s2">9:00-11:00</span>
                                <span class="s3">正常</span>
                            </div>
                            <div class="span4">
                                <span class="s2">无签到数据</span>
                                <span class="s3">旷工</span>
                            </div>
                        </div>
                    </div>

                    <div class="bm1">
                        <div class="row-fluid">
                            <div class="span8">
                                <div class="imgno"></div>
                                <span class="s1">2015年12月05号</span>
                                <span class="s2">无签到数据</span>
                                <span class="s3">病假</span>
                            </div>
                            <div class="span4">
                                <span class="s2">无签到数据</span>
                                <span class="s3">事假</span>
                            </div>
                        </div>
                    </div>

                    <div class="bm1">
                        <div class="row-fluid">
                            <div class="span8">
                                <div class="imgno"></div>
                                <span class="s1">2015年12月05号</span>
                                <span class="s2">9:22-11:50</span>
                                <span class="s3">迟到、早退</span>
                            </div>
                            <div class="span4">
                                <span class="s2">14:45-15:20</span>
                                <span class="s3">迟到、早退</span>
                            </div>
                        </div>
                    </div>

                    <div class="bm1">
                        <div class="row-fluid">
                            <div class="span8">
                                <div class="imgno"></div>
                                <span class="s1">2015年12月05号</span>
                                <span class="s2">9:00-12:00</span>
                                <span class="s3">正常</span>
                            </div>
                            <div class="span4">
                                <span class="s2">14:30-17:30</span>
                                <span class="s3">正常</span>
                            </div>
                        </div>
                    </div>

                    <div class="bm1">
                        <div class="row-fluid">
                            <div class="span8">
                                <div class="imgno"></div>
                                <span class="s1">2015年12月05号</span>
                                <span class="s2">9:00-12:00</span>
                                <span class="s3">正常</span>
                            </div>
                            <div class="span4">
                                <span class="s2">14:30-17:30</span>
                                <span class="s3">正常</span>
                            </div>
                        </div>
                    </div>

                    <div class="bm1">
                        <div class="row-fluid">
                            <div class="span8">
                                <div class="imgno"></div>
                                <span class="s1">2015年12月05号</span>
                                <span class="s2">9:00-12:00</span>
                                <span class="s3">正常</span>
                            </div>
                            <div class="span4">
                                <span class="s2">14:30-17:30</span>
                                <span class="s3">正常</span>
                            </div>
                        </div>
                    </div>

                    <div class="bm1">
                        <div class="row-fluid">
                            <div class="span8">
                                <div class="imgno"></div>
                                <span class="s1">2015年12月05号</span>
                                <span class="s2">9:00-12:00</span>
                                <span class="s3">正常</span>
                            </div>
                            <div class="span4">
                                <span class="s2">14:30-17:30</span>
                                <span class="s3">正常</span>
                            </div>
                        </div>
                    </div>
                    <div style="float:left;"><span class="readbzt" onmouseover="this.style.cursor='pointer'" onclick="javascript:bzt();">查看当月考勤饼状图</span></div>
                    <div class="pagination">
                        <ul id="pagebox">
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
</body>
</html>

