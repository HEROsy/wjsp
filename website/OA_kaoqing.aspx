<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_kaoqing.aspx.cs" Inherits="OA_kaoqing" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%--<script src="Script/jquery-1.8.2.min.js"></script>--%>
    <script src="Script/swkj.js"></script>
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />
    <script src="Script/selectpick.js"></script>
    <script src="Script/jquery-1.8.3.js"></script>
    <script src="Script/selectpick.js"></script>
    <title>我的考勤界面</title>
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

   .top{
            height:100px;
            width:auto;
        }
        .top1{
            height:100px;
            width:400px;
            margin:auto;
        }
            .img {
                height: 40px;
                margin: 40px 0 0 80px;
                display: inline-block;
                width: 40px;
                background-image: url(img/c1.png);
                background-repeat: no-repeat;
                background-position: center 0px;
                filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
                -moz-background-size: 100% 100%;
                background-size: 100% 100%;
            }
            .mid{
                height:60px;
                width:auto;
                background-image:url(img/g1.png);
                background-repeat: no-repeat;
                background-position: center 0px;
                filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
                -moz-background-size: 100% 100%;
                background-size: 100% 100%;

            }
            .select{
                height:30px;
                width:150px;
              
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
                width:150px;
            }
            .selectpick_no_select {
                cursor: default;
                color: #9a9898;
                background-color: #F5F5F5;
            }
            .select_span{
                float:left;
                height: 30px;
                width: 60px;
            }
            .inner{
                height:30px;
                width:auto;
                background-color:#0092D7;
            }
            .inner1{
                height:60px;
                width:40px;
                float:left;
            }
            .img2{
                height:30px;
                width:30px;
                margin-left: 400px;
                background-image:url(img/v2.png);
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
          .bm{
              height:800px;
              background-color:#F1F1F1;

          }
            .bm1 {
                height: 60px;
                width: auto;
                border-bottom: 1px solid #B4B5B5;
            }
            .img3 {
                height: 30px;
                width: 30px;
                background-image: url(img/x1.png);
                display: block;
                margin: 15px 0 0 39px;
                float:left;
            }
            .img4 {
                height: 30px;
                width: 30px;
                display: block;
                margin: 15px 0 0 39px;
                float: left;
            }
            .s1 {
                display: block;
                width: 200px;
                height: 60px;
                line-height: 60px;
                margin-left: 50px;
                font-family: "微软雅黑" !important;
                letter-spacing: 1px;
                font-size: 14px;
                float:left;
            }
            .s2 {
                height: 60px;
                width: 200px;
                line-height: 60px;
                margin-left: -24px;
                font-family: "微软雅黑" !important;
                letter-spacing: 1px;
                font-size: 14px;
            }
            .s3{
                font-family: "微软雅黑" !important;
                letter-spacing: 1px;
                font-size: 14px;
                margin-left: 50px;
            }
        </style>

    <script type="text/javascript">
        $(function () {
            $("#select_pick").selectpick({
                onSelect: function (value, text) {
                }
            });
            $("#test_3").selectpick({ optionColor: "#92DCE0", selectedColor: "#92DCE0" });
            $("#test_4").selectpick({ optionColor: "#92DCE0", selectedColor: "#92DCE0" });

        });
        function getCurDate() {
            var d = new Date();
            var week;
            switch (d.getDate()) {
                case 1: week = "星期二"; break;
                case 2: week = "星期三"; break;
                case 3: week = "星期四"; break;
                case 4: week = "星期五"; break;
                case 5: week = "星期六"; break;
                case 6: week = "星期天"; break;
                case 7: week = "星期一"; break;
            }
            var years = d.getFullYear();
            var month = add_zero(d.getMonth() + 1);
            var days = add_zero(d.getDate());
            var hours = add_zero(d.getHours());
            var minites = add_zero(d.getMinutes());
            var seconds = add_zero(d.getSeconds());
            var ndate = "当前时间:" + years + "年" + month + "月" + days + "日" + hours + "：" + minites + ":" + seconds + "" + week;
            document.getElementById("shijian").innerHTML = ndate;
        }
        function add_zero(temp) {
            if (temp < 10) return "0" + temp;
            else return temp;
        }
        window.onload = function () {
            add_zero();
            flush();
        }

        function flush() {
            setInterval("getCurDate()", 1000);
        }
    </script>
</head>
<body>
    <div style="width: 1000px;height:680px; margin: auto"> <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">   <%--此行不能修改--%>
            <div class="top">
                <div class="top1">
                    <div class="img"></div>
                    <span style="font-size: 30px;margin-left: 140px;margin-top: -36px;height: 50px;display: block;">我的考勤</span>
                </div>
                <div class="inner"></div>

                <div class="mid">
                    <div class="row-fluid">
                        <div class="span6" style="height: 60px;">
                            <div class="inner1"></div>
                            <div style="float: left; width: 180px;">
                                <select id="test_3">
                                    <option value="1">2015年</option>
                                    <option value="2">2014年</option>
                                    <option value="3">2013年</option>
                                    <option value="4">2012年</option>
                                </select>
                            </div>
                            <div style="float: left; width: 180px;">
                                <select id="test_4">
                                    <option value="1">12月</option>
                                    <option value="2">11月</option>
                                    <option value="3">10月</option>
                                    <option value="4">09月</option>
                                    <option value="4">08月</option>
                                    <option value="4">07月</option>
                                    <option value="4">06月</option>
                                    <option value="4">05月</option>
                                    <option value="4">04月</option>
                                    <option value="4">03月</option>
                                    <option value="4">02月</option>
                                    <option value="4">01月</option>
                                </select>
                            </div>
                            <div class="img2" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'"></div>
                        </div>
                        <div class="span6" style="height:60px;">
                            <span class="shijian" id="shijian">当前时间15:26分</span>
                        </div>
                    </div>
                </div>
                <div class="bm">
                    <div class="bm1">
                        <div class="row-fluid">
                            <div class="span6">
                                <div class="img3"></div>
                                <span class="s1">2015年12月05号</span>
                                <span class="s2">9:00-11:00</span>
                                <span class="s3">异常</span>
                            </div>
                            <div class="span6">
                                <span class="s2" style="margin-left: 100px;">14:00-16:00</span>
                                <span class="s3">迟到</span>
                            </div>
                        </div>
                    </div>
                    <div class="bm1">
                        <div class="row-fluid">
                            <div class="span6">
                                <div class="img4"></div>
                                <span class="s1">2015年12月05号</span>
                                <span class="s2">9:00-11:00</span>
                                <span class="s3">正常</span>
                            </div>
                            <div class="span6">
                                <span class="s2" style="margin-left: 100px;">14:00-16:00</span>
                                <span class="s3">正常</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</body>
</html>
