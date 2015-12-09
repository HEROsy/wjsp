<%@ Page Language="C#" AutoEventWireup="true" CodeFile="oA_bmyhgl.aspx.cs" Inherits="oA_bmyhgl" %>

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
    <title>部门用户管理</title>
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
        .top{
            height:100px;
            width:auto;
        }
        .top1 {
            height: 100px;
            width: 250px;
            float: left;
            margin-left: 391px;
        }

        .top2 {
            height: 100px;
            width: 600px;
            margin-left: 398px;
            border: 1px solid #CFCFCF;
        }

        .img1 {
            height: 40px;
            margin: 30px 0 0 0px;
            display: inline-block;
            width: 40px;
            background-image: url(img/z1.png);
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
        }
        .left{
            height:580px;
            width:400px;
            box-shadow: 1px 1px 1px #0E8613;
            float:left;
        }
        .right {
            height: 580px;
            width: 580px;
            margin-left: 420px;
            box-shadow: 1px 1px 1px #607D8B;
        }
       .left1{
           height:100px;
           width:auto;
           background-color:#0E8613;
           
       }
        .column {
            height: 30px;
            width: 270px;
            margin-top: 27px;
            display: inline-block;
            margin-left: 70px;
            float:left;
        }
        .column1 {
            height: 30px;
            width: 250px;
            margin-top: 3px;
            display: inline-block;
            margin-left: 30px;
            float: left;
        }

        .form1 {
            height: 35px;
            width: 35px;
            margin-top: -22px;
            float: left;
            margin-left: 10px;
            border-radius: 5px;
            background-color: #EE8D09;
        }
        .img2{
            height:25px;
            width:25px;
            margin: 5px;
            background-image:url(img/z4.png);
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
            
        }
        .img3 {
            height: 30px;
            width: 30px;
            float: left;
            margin: 42px 0 0 -6px;
            background-image: url(img/z3.png);
            -moz-transition: all 0.2s ease-in-out;
            -webkit-transition: all 0.2s ease-in-out;
            -o-transition: all 0.2s ease-in-out;
            -ms-transition: all 0.2s ease-in-out;
            transition: all 0.2s ease-in-out;
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
        }

            .img3:hover {
                -moz-transform: rotate(360deg);
                -webkit-transform: rotate(360deg);
                -o-transform: rotate(360deg);
                -ms-transform: rotate(360deg);
                transform: rotate(360deg);
            }
            .img4 {
            height: 30px;
            width: 30px;
            float: left;
            margin: 2px 0 0 30px;
            background-image: url(img/z3.png);
            -moz-transition: all 0.2s ease-in-out;
            -webkit-transition: all 0.2s ease-in-out;
            -o-transition: all 0.2s ease-in-out;
            -ms-transition: all 0.2s ease-in-out;
            transition: all 0.2s ease-in-out;
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
        }

            .img4:hover {
                -moz-transform: rotate(360deg);
                -webkit-transform: rotate(360deg);
                -o-transform: rotate(360deg);
                -ms-transform: rotate(360deg);
                transform: rotate(360deg);
            }
        .right1{
            height:60px;
           width:auto;
           background-color:#607D8B;
        }
        .right11{
            height:40px;
           width:auto;
           background-color:#607D8B;
        }
        .left2{
            height:480px;
            width:auto;
            background-color:#4CAF50;
        }
        .lb{
            height:49px;
            width:auto;
            border-bottom: 1px solid #57B55B;
             background-color:#4CAF50;

        }
        .lb:hover{
            background-color:#68CA6C;
        }
         .lb1{
            height:49px;
            width:580px;
            border-bottom: 1px solid #9FB6C1;
           

        }
        .lb1:hover{
            background-color:#ABC2CE;
        }
        .lbspan {
            display: block;
            margin-top: 16px;
            margin-left: 25px;
            color: #fff;
            
        }
        .lb2 {
            width: 62px;
            height: 30px;
            display: block;
            color: #fff;
            float: left;
            line-height: 30px;
            text-align: center;
            border-radius: 6px;
            margin: -35px 0 0 302px;
            background-color:#FF9800;
        }

            .lb2:hover {
                color: #ffffff;
                background-color:#FFC107;
            }
            .lb3 {
            width: 62px;
            height: 30px;
            display: block;
            float: left;
            line-height: 30px;
            background-color: #4CAF50;
            text-align: center;
            border-radius: 6px;
           margin: 10px 0 0 12px;
           color:#ffffff;
        }

            .lb3:hover {
                color: #ffffff;
                background-color:#35D63B;
            }
            .lb4 {
            width: 80px;
            height: 30px;
            display: block;
            background-color: #0092D7;
            float: left;
            line-height: 30px;
            text-align: center;
            border-radius: 6px;
            margin: 10px;
            color:#ffffff;
        }

            .lb4:hover {
                color: #ffffff;
                background-color:#03A9F4;
            }
             .lb5 {
            width: 62px;
            height: 30px;
            display: block;
            background-color:#FF9800;
            float: left;
            line-height: 30px;
            text-align: center;
            border-radius: 6px;
            margin: 10px 0 0 25px;
            color: #fff;


        }

            .lb5:hover {
                color: #ffffff;
                background-color:#FFC107;
            }
        .sx {
            height: 30px;
            width: 30px;
            margin-top: 1px;
            float: left;
            margin-left: -9px;
            background-image: url(img/z5.png);
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
        }

         
        /*从这里开始都是美化select插件css*/
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
        .inner{
            height:60px;
            width:20px;
            background-color:#607D8B;
            float:left;
        }
         .right2{
            height:480px;
            width:auto;
            background-color:#9CB1BB;
        } 
         .pagination ul li a{
             color: #fff !important;
             background-color: #9CB1BB !important;
         }
        .ss {
            height: 30px;
            width: 220px;
        }
        .left3 {
            width: 400px;
            height: 480px;
            margin-top: 15px;
            display: inline-block;
        }
        .right3{
            width: 580px;
            height: 480px;
            margin-top: 15px;
            display: inline-block;
        }
        .img6 {
            height: 25px;
            width: 25px;
            background-image: url(img/j5.png);
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
            margin: 10px 0 0 38px;
            float: left;
            display: inline-block;
        }
        .img7{
            height: 25px;
            width: 25px;
            background-image: url(img/j10.png);
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
            margin: 10px 0 0 20px;
            float: left;
            display: inline-block;
        }
        .img8 {
            height: 25px;
            width: 25px;
            background-image: url(img/j9.png);
            background-repeat: no-repeat;
            background-position: center 0px;
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100% 100%;
            background-size: 100% 100%;
            margin: 10px 0 0 30px;
            float: left;
            display: inline-block;
        }

        .pagination {
            margin: 20px 0 0 282px;
        }
    </style>
    <script>
        window.onload = function () {
            ss();
            ss1();
        }
        $(function () {
            $("#select_pick").selectpick({
                onSelect: function (value, text) {
                }
            });
            $("#test_3").selectpick({ optionColor: "#92DCE0", selectedColor: "#92DCE0" });
            $("#test_4").selectpick({ optionColor: "#92DCE0", selectedColor: "#92DCE0" });

        });
        
        function ss() {
            $('#input1').focus(function () {
                $(this).css("background-image", "url(img/j1.png)");
            });
            $('#input1').blur(function () {
                if ($('#input1').attr("value") == "") {
                    $(this).css("background-image", "url(img/j3.png)");
                }
            });
        };
        function ss1() {
            $('#input2').focus(function () {
                $(this).css("background-image", "url(img/j6.png)");
            });
            $('#input2').blur(function () {
                if ($('#input2').attr("value") == "") {
                    $(this).css("background-image", "url(img/j8.png)");
                }
            });
        };
    </script>
</head>
<body>
    <div style="width: 1000px; height: 680px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">
            <%--此行不能修改--%>
            <div class="top">
                <div class="top1">
                <div class="img1"></div>
                <span style="font-size: 30px; margin-left: 50px; margin-top: -36px; height: 50px; display: block;">部门用户管理</span>
                </div>
            </div>
            <%--部门列表--%>
            <div class="left">
                <div class="left1">
                    <div class="column">
                       
                            
                        <div class="ss">
                            <input type="text" id="input1" style="background-image:url(img/j3.png);margin-top: 12px;margin-left: -30px;"/>
                        </div>
                    </div>
               
                    <div class="img3"></div>
                </div>
                <div class="left2">
                    <div class="left3">
                    <div class="lb" style="border-top: 1px solid #57B55B;">
                        <div class="img6"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 50px;" >部门1</span>
                        <span class="lb2" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                    </div>
                        <div class="lb">
                        <div class="img6"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 50px;" >部门1</span>
                        <span class="lb2" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                    </div>
                        <div class="lb">
                        <div class="img6"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 50px;" >部门1</span>
                        <span class="lb2" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                    </div>
                        <div class="lb">
                        <div class="img6"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 50px;" >部门1</span>
                        <span class="lb2" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                    </div>
                        <div class="lb">
                        <div class="img6"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 50px;" >部门1</span>
                        <span class="lb2" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                    </div>
                        <div class="lb">
                        <div class="img6"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 50px;" >部门1</span>
                        <span class="lb2" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                    </div>
                        <div class="lb">
                        <div class="img6"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 50px;" >部门1</span>
                        <span class="lb2" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                    </div>
                        <div class="lb">
                        <div class="img6"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 50px;" >部门1</span>
                        <span class="lb2" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                    </div>
                        <div class="lb">
                        <div class="img6"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 50px;" >部门1</span>
                        <span class="lb2" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                    </div>
                   
                 </div>

                </div>
            </div>
            <div class="right">
                <div class="right11"></div>
                <div class="right1">
                    <div class="inner"></div>
                    <div style="float: left; width: 180px;">
                        <select id="test_3">
                            <option>请选择机构</option>
                            <option value="1">机构1</option>
                            <option value="2">机构2</option>
                            <option value="3">机构3</option>
                            <option value="4">机构4</option>
                            <option value="5">机构5</option>
                            <option value="6">机构6</option>
                            <option value="7">机构7</option>
                            <option value="8">机构8</option>
                            <option value="9">机构9</option>
                        </select>
                    </div>
                    <div class="sx"></div>
                    <div class="column1">
                        <div  class="sss">
                                <input class="sb-search-input"id="input2" type="text" style="height:22px;background-image:url(img/j8.png);margin-left: 67px;float: left;width: 185px;margin-top: -2px;display: block;" />
                                <span class="sb-icon-search"></span>
                        </div>
                    </div>
                    <div class="img4"></div>
                </div>
                <div class="right2">
                    <div class="right3">
                    <div class="lb1"    style="border-top: 1px solid #9FB6C1;" >
                        <div class="img7"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 70px;" >姓名:高阳</span>
                        <div class="img8"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 120px;" >用户名:8888888</span>
                        <span class="lb5" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                        <span class="lb3" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">照相</span>
                        <span class="lb4" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">重置密码</span>
                    </div>
                        <div class="lb1" >
                        <div class="img7"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 70px;" >姓名:高阳</span>
                        <div class="img8"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 120px;" >用户名:8888888</span>
                        <span class="lb5" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                        <span class="lb3" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">照相</span>
                        <span class="lb4" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">重置密码</span>
                    </div>
                        <div class="lb1" >
                        <div class="img7"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 70px;" >姓名:高阳</span>
                        <div class="img8"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 120px;" >用户名:8888888</span>
                        <span class="lb5" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                        <span class="lb3" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">照相</span>
                        <span class="lb4" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">重置密码</span>
                    </div>
                        <div class="lb1" >
                        <div class="img7"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 70px;" >姓名:高阳</span>
                        <div class="img8"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 120px;" >用户名:8888888</span>
                        <span class="lb5" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                        <span class="lb3" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">照相</span>
                        <span class="lb4" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">重置密码</span>
                    </div>
                        <div class="lb1" >
                        <div class="img7"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 70px;" >姓名:高阳</span>
                        <div class="img8"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 120px;" >用户名:8888888</span>
                        <span class="lb5" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                        <span class="lb3" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">照相</span>
                        <span class="lb4" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">重置密码</span>
                    </div>
                        <div class="lb1" >
                        <div class="img7"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 70px;" >姓名:高阳</span>
                        <div class="img8"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 120px;" >用户名:8888888</span>
                        <span class="lb5" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                        <span class="lb3" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">照相</span>
                        <span class="lb4" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">重置密码</span>
                    </div>
                        <div class="lb1" >
                        <div class="img7"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 70px;" >姓名:高阳</span>
                        <div class="img8"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 120px;" >用户名:8888888</span>
                        <span class="lb5" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                        <span class="lb3" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">照相</span>
                        <span class="lb4" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">重置密码</span>
                    </div>
                        <div class="lb1" >
                        <div class="img7"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 70px;" >姓名:高阳</span>
                        <div class="img8"></div>
                        <span class="lbspan"style="margin-left:10px;float:left;width: 120px;" >用户名:8888888</span>
                        <span class="lb5" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">删除</span>
                        <span class="lb3" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">照相</span>
                        <span class="lb4" onmouseover="this.style.cursor='pointer'" onclick="window.location.href='#'">重置密码</span>
                    </div>
                       
                            <div class="pagination" >
                                <ul>
                                    <li><a href="#">上一页</a></li>
                                    <li><a href="#">1</a></li>
                                    <li><a href="#">2</a></li>
                                    <li><a href="#">3</a></li>
                                    <li><a href="#">4</a></li>
                                    <li><a href="#">下一页</a></li>
                                </ul>
                            </div>
       
                    </div>

                </div>
               
        </div>
    </div>
        </div>
</body>
</html>
