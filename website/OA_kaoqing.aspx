<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_kaoqing.aspx.cs" Inherits="OA_kaoqing" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%--<script src="Script/jquery-1.8.2.min.js"></script>--%>
    <script src="Script/jquery-1.8.3.js"></script>
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />
    <script src="Script/swkj.js"></script>
    <script src="Script/selectpick.js"></script>
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
            height: 60px;
            width: auto;
            background-image: url(img/G2.png);
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
        }

        .select {
            height: 30px;
            width: 150px;
        }

        .selectpick_div {
            background-color: #FFFFFF;
            font-size: 13px;
            font-weight: 500;
            border-radius: 5px;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border: solid 1px #CFCFCF;
            line-height: 30px;
            position: absolute;
            padding-left: 5px;
            overflow: hidden;
            cursor: pointer;
            overflow: hidden;
            z-index: 9060;
        }

        .selectpick_icon {
            float: right;
            background: url(img/C5.png) no-repeat center;
            margin-right: 5px;
            height: 20px;
            margin-top: 5px;
            width: 20px;
            cursor: pointer;
        }

        .selectpick_div:hover {
            background-color: #F5F5F5;
            border: solid 1px #ccc;
        }

        .selectpick_div:active {
            -moz-box-shadow: 0 0 3px #0099CC;
            -webkit-box-shadow: 0 0 3px #0099CC;
            box-shadow: 0 0 3px #0099CC;
            border: solid 1px #0099CC;
        }

        .selectpick_options {
            border: solid 1px #CFCFCF;
            border-bottom: none;
            position: absolute;
            z-index: 9060;
            font-size: 13.5px;
        }

            .selectpick_options ul {
                list-style: none;
                height: auto;
                margin: 0px;
                padding: 0px;
                z-index: 9060;
                font-size: 13.5px;
            }

                .selectpick_options ul li {
                    border-bottom: solid 1px #CFCFCF;
                    padding-left: 5px;
                    display: block;
                    font-size: 13.5px;
                    z-index: 9060;
                    background-color: #fff;
                }

        .selectpick_options_selected {
            font-size: 13.5px;
            z-index: 9060;
        }

        .select_hide {
            -moz-opacity: 0;
            opacity: 0;
            -webkit-opacity: 0;
            filter: alpha(opacity = 0);
            width: 150px;
        }

        .selectpick_no_select {
            cursor: default;
            color: #9a9898;
            background-color: #F5F5F5;
        }

        .select_span {
            float: left;
            height: 30px;
            width: 60px;
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
            width: 30px;
            margin-left: 397px;
            background-image: url(img/v2.png);
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
        }

        .shijian {
            display: block;
            margin-left: 170px;
            color: #fff;
            font-size: 14px;
            font-family: 微软雅黑 !important;
            margin-top: 9px;
        }

        .bm {
            height: 490px;
            background-color: #F1F1F1;
        }

        .bm1 {
            height: 50px;
            width: auto;
            border-bottom: 1px solid #B4B5B5;
        }

        .img3 {
            height: 25px;
            width: 25px;
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
            background-image: url(img/y2.png);
            display: block;
            margin: 16px 0 0 39px;
            float: left;
        }

        .img4 {
            height: 25px;
            width: 25px;
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
            background-image: url(img/y3.png);
            display: block;
            margin: 16px 0 0 39px;
            float: left;
        }

        .s1 {
            display: block;
            width: 200px;
            height: 50px;
            line-height: 60px;
            margin-left: 50px;
            font-family: "微软雅黑" !important;
            letter-spacing: 1px;
            font-size: 14px;
            float: left;
        }

        .s2 {
            height: 50px;
            width: 200px;
            line-height: 50px;
            margin-left: -24px;
            font-family: "微软雅黑" !important;
            letter-spacing: 1px;
            font-size: 14px;
        }

        .s3 {
            font-family: "微软雅黑" !important;
            letter-spacing: 1px;
            font-size: 14px;
            margin-left: 50px;
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
            margin: 40px 0 0 610px;
        }

        #w1 {
            color: #f26666;
        }

        #w2 {
            color: #f26666;
        }

        #w3 {
            color: #f26666;
        }
    </style>

    <script type="text/javascript">
        var select_year = "";
        var value = "";
        var times;
        var box;
        var pagebox = null;
        var max = 110;
        var min = 6;
        var isopen = false;
        var pagesize=8;

        $(function () {
            $("#select_pick").selectpick({
                onSelect: function (value, text) {
                }
            });
            $("#test_3").selectpick({
                optionColor: "#92DCE0", selectedColor: "#92DCE0", onSelect: function (value) {
                    select_year = value;
                }
            });
            $("#test_4").selectpick({ optionColor: "#92DCE0", selectedColor: "#92DCE0",onSelect: function (value)
            {
                value = value;
                $.ajax({
                    type: "post",
                    url: "AsyCenter.aspx",
                    data: {
                        type: "kaoqingpage",
                        year: select_year,
                        month: value,
                        pagesize: '8',
                        pageindex: "1",
                        //uid:document.getElementById("uid").value
                    },
                    success: function (data) {
                        var json_infor = null;
                        try {
                            json_infor = eval("(" + data + ")");
                        }
                        catch (e) {
                            document.getElementById("bm").innerHTML= "<div class='bm1'><div class='row-fluid'><div class='span6'><div></div><span class='s1'>无数据........</span>"
                            + "<span class='s2'></span>"
                            + "<span class='s3' id='w1'></span></div>"
                            + "<div class='span6'>"
                            + "<span class='s2' style='margin-left: 100px;'></span>"
                            + "<span class='s3' id='w2'></span></div></div></div>";

                            document.getElementById("pagebox").innerHTML = "";

                            return false;
                        }
                        var html = "";
                        if (json_infor != null) {
                            for (var i = 0; i < json_infor.length; i++) {
                                if (i == 0) {
                                    var count =parseInt(json_infor[i].count);
                                    //get totalpage
                                    var totalpage = "";
                                    if (count < pagesize) {
                                        totalpage = 1;
                                    } else {
                                        if (count % pagesize == 0) {
                                            totalpage = count / pagesize;
                                        } else {
                                            totalpage =parseInt((count / pagesize))+1;
                                        }
                                    }
                                    //Initpage
                                    InitPages(document.getElementById("pagebox"), totalpage, 1);
                                } else {
                                    //binddate 
                                    if ((json_infor[i].a_state) == "正常" && (json_infor[i].p_state) == "正常")
                                    {
                                        html = html + liebiao_2(decode(json_infor[i].day), decode(json_infor[i].a_state) ,decode(json_infor[i].p_state));
                                    } else {
                                        html = html + liebiao_1(decode(json_infor[i].day), decode(json_infor[i].a_state), decode(json_infor[i].p_state));
                                    }
                                }
                               
                            }
                        }
                        document.getElementById("bm").innerHTML = html;
                    }
                })
            }
            });
        });

        function getCurDate() {
            var d = new Date();
            var week;
            var years = d.getFullYear();
            var month = add_zero(d.getMonth() + 1);
            var days = add_zero(d.getDate());
            var hours = add_zero(d.getHours());
            var minites = add_zero(d.getMinutes());
            var seconds = add_zero(d.getSeconds());
            var ndate = "当前时间:" + years + "年" + month + "月" + days + "日" + hours + "：" + minites + ":" + seconds + "";
            document.getElementById("shijian").innerHTML = ndate;
        }

        function add_zero(temp) {
            if (temp < 10) return "0" + temp;
            else return temp;
        }

        window.onload = function () {
            select_year = document.getElementById("test_3").value;
            value = document.getElementById("test_4").value;
            add_zero();
            flush();
            box = document.getElementById("zsk");
            pagebox = document.getElementById("pagebox");
            GetData(1);
            tit();
        }
        
        function decode(str) {
            str = decodeURIComponent(str.replace(/\+/g, '%20'));
            return str;
        }

        function flush() {
            setInterval("getCurDate()", 1000);
        }

        function donghua() {
            var oldtop = box.offsetTop;
            if (isopen==true) {
                if (oldtop <= max) {
                    oldtop += 1;
                    box.style.top = oldtop + "px";
                    times = setTimeout("donghua()", 5);
                }
                else {
                    clearTimeout(times);
                    isopen = false;
                }
            } else {
                if (oldtop > min) {
                    oldtop -= 1;
                    box.style.top = oldtop + "px";
                    times = setTimeout("donghua()", 5);
                }
                else {
                    clearTimeout(times);
                    isopen = true;
                }
            }
        }

        function liebiao_1(id,a_state,p_state,day) {
            var color_zt = "";
            var color_zt_1 = "";
            if (a_state == "正常")
            {
                color_zt = "#000000";
            } else {
                color_zt = "#f26666";
            }
            if (p_state == "正常") {
                color_zt_1 = "#000000";
            } else {
                color_zt_1 = "#f26666";
            }
            var a = "<div class='bm1'><div class='row-fluid'><div class='span6'><div class='img3'></div><span class='s1'>" + day + "</span>"
                            + "<span class='s2'> 9:00-11:00  </span>"
                            + "<span class='s3' id='w1' style='color:" + color_zt + "'>" + a_state + "</span></div>"
                            + "<div class='span6'>"
                            + "<span class='s2' style='margin-left: 100px;'>14:00-16:00</span>"
                            + "<span class='s3' id='w2' style='color:" + color_zt_1 + "'>" + p_state + "</span></div></div></div>";
                            return a;
        }

        function liebiao_2(id,a_state,p_state,day) {
            var color_zt = "";
            var coor_zt_1 = "";
            if (a_state == "正常") {
                color_zt = "#000000";
            } else {
                color_zt = "#f26666";
            }
            if (p_state=="正常") {
                color_zt_1 = "#000000";
            } else {
                color_zt_1 = "#f26666";
            }
            var a = "<div class='bm1'><div class='row-fluid'><div class='span6'><div class='img4'></div><span class='s1'>" + day + "</span>"
                            + "<span class='s2'> 9:00-11:00 </span>"
                            + "<span class='s3' id='w1' style='color:" + color_zt + "'>" + a_state + "</span></div>"
                            + "<div class='span6'>"
                            + "<span class='s2' style='margin-left: 100px;'>14:00-16:00</span>"
                            + "<span class='s3' id='w2' style='color:" + color_zt_1 + "'>" + p_state + "</span></div></div></div>";
            return a;
        }
        
        function InitPages(pagebox, totalpage, pageindex) {
            pagebox.innerHTML = "";
            totalpage = parseInt(totalpage);                //强制类型转换 
            pageindex = parseInt(pageindex);

            var pagenum = 3;
            var middleindex = parseInt(pagenum / 2) + 1;
            var newobj = null;
            if (pageindex == 1) {
                newobj = Create("上页", "disabled");
                pagebox.appendChild(newobj);
            } else {
                newobj = Create("上页", "");
                pagebox.appendChild(newobj);
            }

            //if (pageindex == 1) {
            //    newobj = Create("第一页", "disabled");
            //    pagebox.appendChild(newobj);
            //} else {
            //    newobj = Create("第一页", "");
            //    pagebox.appendChild(newobj);
            //}

            if (totalpage < pagenum) {
                for (var i = 1; i < totalpage + 1; i++) {
                    if (i != pageindex) {
                        newobj = Create(i, "");
                        pagebox.appendChild(newobj);
                    } else {
                        newobj = Create(i, "active");
                        pagebox.appendChild(newobj);
                    }
                }
            } else {
                if (pageindex <= middleindex) {
                    for (var i = 1; i < pagenum + 1; i++) {
                        if (i != pageindex) {
                            newobj = Create(i, "");
                            pagebox.appendChild(newobj);
                        } else {
                            newobj = Create(i, "active");
                            pagebox.appendChild(newobj);
                        }
                    }
                } else {
                    var offsetindex = middleindex - 1;
                    var beginindex = pageindex - offsetindex;
                    var endindex = 0;
                    if (parseInt(pageindex) + offsetindex < totalpage) {
                        endindex = parseInt(pageindex) + offsetindex;
                    } else {
                        endindex = beginindex + (totalpage - beginindex);
                    }

                    for (var i = beginindex; i < endindex + 1; i++) {
                        if (i != pageindex) {
                            newobj = Create(i, "");
                            pagebox.appendChild(newobj);
                        } else {
                            newobj = Create(i, "active");
                            pagebox.appendChild(newobj);
                        }
                    }
                }
            }

            //if (parseInt(pageindex) >= totalpage) {
            //    newobj = Create("最后一页", "disabled");
            //    pagebox.appendChild(newobj);
            //} else {
            //    newobj = Create("最后一页", "");
            //    pagebox.appendChild(newobj);
            //}

            if (parseInt(pageindex) >= totalpage) {
                newobj = Create("下页", "disabled");
                pagebox.appendChild(newobj);
            } else {
                newobj = Create("下页", "");
                pagebox.appendChild(newobj);
            }


            function Create(inname, classtype) {
                var obj = null;
                var oli = document.createElement("li");
                var oa = document.createElement("a");

                if (classtype != "") { oli.className = classtype; }

                oa.innerHTML = inname;
                oa.href = "javascript:void(0)";
                if ((inname + "").indexOf("页") < 0) {
                    oa.style.width = 15 + "px";
                }
                oa.onclick = function () {
                    pageclick(oa);
                }
                oli.appendChild(oa);

                return oli;
            }

            function pageclick(sender) {
                var pe = sender.parentElement.className;
                if (pe == "disabled" || pe == "active") { return false; }
                var _value = sender.innerHTML;
                switch (_value) {
                    case "上页":
                        GetData(pageindex - 1);
                        InitPages(pagebox, totalpage, pageindex - 1);
                        break;
                    case "下页":
                        GetData(pageindex + 1);
                        InitPages(pagebox, totalpage, pageindex + 1);
                        break;
                        //case "第一页":
                        //    GetData(1);
                        //    InitPages(pagebox, totalpage, 1);
                        //    break;
                        //case "最后一页":
                        //    GetData(totalpage);
                        //    InitPages(pagebox, totalpage, totalpage);
                        //    break;
                    default:
                        GetData(_value);
                        InitPages(pagebox, totalpage, _value);

                }
            }
        }

        function GetData(pageindex) {
            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type: "kaoqingpage",
                    year: select_year,
                    month: value,
                    pagesize: "8",
                    pageindex: pageindex,
                    //uid:document.getElementById("uid").value
                },
                success: function (data) {
                    var json_infor = null;
                    try {
                        json_infor = eval("(" + data + ")");
                    } catch (e) {

                    }
                    var html = "";
                    if (json_infor != null) {
                        for (var i = 0; i < json_infor.length; i++) {
                            if (i == 0) {
                                var count = parseInt(json_infor[i].count);
                                //get totalpage
                                var totalpage = "";
                                if (count < pagesize) {
                                    totalpage = 1;
                                } else {
                                    if (count % pagesize == 0) {
                                        totalpage = count / pagesize;
                                    } else {
                                        totalpage = parseInt((count / pagesize)) + 1;
                                    }
                                }
                                //Initpage
                                InitPages(document.getElementById("pagebox"), totalpage, 1);
                            } else {
                                //binddate 
                                if ((json_infor[i].a_state) == "正常" && (json_infor[i].p_state) == "正常") {
                                    html = html + liebiao_2(decode(json_infor[i].day), decode(json_infor[i].a_state), decode(json_infor[i].p_state));
                                } else {
                                    html = html + liebiao_1(decode(json_infor[i].day), decode(json_infor[i].a_state), decode(json_infor[i].p_state));
                                }
                            }

                        }
                    }
                    document.getElementById("bm").innerHTML = html;
                }
            })
            }

        function changeup() {
            var gengxing = document.getElementById("test_3").value;
            alert(gengxing);
        }
    </script>
</head>
<body>
<%--    <input type="hidden" id="uid" value="<%=uid %>" />;--%>
    <div style="width: 1000px; height: 680px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">
            <%--此行不能修改--%>
            <div class="top">
                <div class="top1">
                    <div class="img"></div>
                    <span style="font-size: 30px; margin-left: 50px; margin-top: -36px; height: 50px; display: block;">我的考勤</span>
                </div>
                <div class="top2" id="zsk">
                    <div class="top3">
                        <div class="img5"></div>
                        <span class="chuqin">2015年一月出勤统计</span>
                    </div>
                    <div class="top4">
                        <div class="img6"></div>
                        <span class="chidao1">迟到：</span>
                        <span class="chidao2">2</span>
                        <span class="chidao1">天</span>
                    </div>
                    <div class="top4">
                        <div class="img6"></div>
                        <span class="chidao1">早退：</span>
                        <span class="chidao2">2</span>
                        <span class="chidao1">天</span>
                    </div>
                    <div class="top4">
                        <div class="img6"></div>
                        <span class="chidao1">病假：</span>
                        <span class="chidao2">2</span>
                        <span class="chidao1">天</span>
                    </div>
                    <div class="top4">
                        <div class="img6"></div>
                        <span class="chidao1">事假：</span>
                        <span class="chidao2">2</span>
                        <span class="chidao1">天</span>
                    </div>
                    <div class="top4">
                        <div class="img6"></div>
                        <span class="chidao1">旷工：</span>
                        <span class="chidao2">2</span>
                        <span class="chidao1">天</span>
                    </div>
                    <div class="top4">
                        <div class="img11"></div>
                        <span class="chidao1">正常：</span>
                        <span class="chidao2">2</span>
                        <span class="chidao1">天</span>
                    </div>
                </div>


                <div class="inner"></div>

                <div class="mid">
                    <div class="row-fluid">
                        <div class="span6" style="height: 60px;">
                            <div class="inner1"></div>
                            <div style="float: left; width: 180px;">
                                <select id="test_3" >
                                    <option value="2015">2015年</option>
                                    <option value="2014">2014年</option>
                                    <option value="2013">2013年</option>
                                    <option value="2012">2012年</option>
                                </select>
                            </div>
                            <div style="float: left; width: 180px;">
                                <select id="test_4" >
                                    <option value="12">12月</option>
                                    <option value="11">11月</option>
                                    <option value="10">10月</option>
                                    <option value="09">09月</option>
                                    <option value="08">08月</option>
                                    <option value="07">07月</option>
                                    <option value="06">06月</option>
                                    <option value="05">05月</option>
                                    <option value="04">04月</option>
                                    <option value="03">03月</option>
                                    <option value="02">02月</option>
                                    <option value="01">01月</option>
                                </select>
                            </div>
                            <div class="img2" onmouseover="this.style.cursor='pointer'" onclick="donghua()"></div>
                        </div>
                        <div class="span6" style="height: 60px;">
                            <span class="shijian" id="shijian">当前时间15:26分</span>
                        </div>
                    </div>
                </div>
                <div class="bm">
                    <div id="bm">

                    </div>
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

