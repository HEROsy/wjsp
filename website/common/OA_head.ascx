<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OA_head.ascx.cs" Inherits="common_head" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Script/swkj.js"></script>
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />
    <title>雅安劳务公司文件审批流系统头部页面</title>

    <style type="text/css">
        p {
            font-family:"微软雅黑" !important; /*强制使用这种字体*/
            letter-spacing:1px;                /*最小间距1px，可根据需要调整，不得低于1px*/
            font-size:14px;                    /*最小文字大小14px，可根据需要调整，不得低于14px*/
        }
        span {
            font-family:"微软雅黑" !important; /*强制使用这种字体*/
            letter-spacing:2px;                /*最小间距1px，可根据需要调整，不得低于1px*/
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
        .top_title {
            color: #ffffff;
            text-align: center;
            line-height: 50px;
            display: block;
        }

        .top_back:hover {
            background-image: url(img/top_hover.png);
            background-repeat: no-repeat;
        }

            .top_back:hover .top_title {
                color: #0092D7 !important;
            }
        .xiala1 {
            display: block;
            width: 180px;
            height: 40px;
            position: absolute;
            z-index:2;
            background-color: #ffffff;
            margin: 0 0 0 1px;
            border-left: 1px solid #f1efef;
            border-right: 1px solid #f1efef;
        }
            .xiala1:hover {
                background-color:#0092D7;
            }
            .xiala1:hover span{
                color:#ffffff;
            }

            .xiala1 span {
                line-height: 40px;
                display: block;
                margin-left: 17px;
                float:left;
                color:#0092D7;
            }

        .xiala2 {
            display: block;
            width: 180px;
            height: 40px;
            position: absolute;
            z-index:2;
            background-color: #ffffff;
            margin: 40px 0 0 1px;
            border-left: 1px solid #f1efef;
            border-right: 1px solid #f1efef;
            border-top: 1px solid #f1efef;
        }
        .xiala2:hover {
                background-color:#0092D7;
            }
            .xiala2:hover span{
                color:#ffffff;
            }
            .xiala2 span {
                line-height: 40px;
                display: block;
                margin-left: 17px;
                float:left;
                color:#0092D7;
            }

        .xiala3 {
            display: block;
            width: 180px;
            height: 40px;
            position: absolute;
            z-index:2;
            background-color: #ffffff;
            margin: 81px 0 0 1px;
            border-left: 1px solid #f1efef;
            border-right: 1px solid #f1efef;
            border-bottom: 1px solid #f1efef;
            border-top: 1px solid #f1efef;
        }
        .xiala3:hover {
                background-color:#0092D7;
            }
            .xiala3:hover span{
                color:#ffffff;
            }
            .xiala3 span {
                line-height: 40px;
                display: block;
                margin-left: 17px;
                float:left;
                color:#0092D7;
            }
        .jiantou1 {
            float:right !important;
            margin-right:8px;
            font-weight:bold;
            color:#0092D7;
        }
        .wjfbxl {
           display:none;
        }
        .wjfb:hover .wjfbxl {
           display:block;
        }
        .splxl {
           display:none;
        }
        .spl:hover .splxl {
           display:block;
        }
        .kaoqingxl {
           display:none;
        }
        .kaoqing:hover .kaoqingxl {
           display:block;
        }
        .xtszxl {
           display:none;
        }
        .xtsz:hover .xtszxl {
           display:block;
        }
    </style>

    <script type="text/javascript">

    </script>
<%--     onmouseover="this.style.cursor='pointer'" onclick="window.location.href='Default.aspx'"--%>
</head>
<body>
    <div style="width: 100%; height: 80px; margin: auto; border-bottom: 1px solid #f1efef;background-image:url(img/oa_top_bg.jpg)">
        <div style="width: 1000px; height: 80px; margin: auto;">
            <div class="row-fluid">
                <div class="span4"><img src="img/oa_logo.png" /></div>
                <div class="span8">
                    <div class="row-fluid" style="height: 30px;"><a href="http://www.10-net.cn/" target="_blank" style="display:block;text-align:right;line-height:30px;color:#68C3FF; margin-right: 20px;">系统开发：雅安十网科技开发有限公司</a></div>
                    <div class="row-fluid" style="height: 50px;">
                        <div class="span2 top_back" onmouseover="this.style.cursor='pointer'" onclick="document.getElementById('center').src='OA_center.aspx'"><span class="top_title">用户中心</span></div>
                        <div class="span2 top_back wjfb" onmouseover="this.style.cursor='pointer'">
                            <span class="top_title">文件发布</span>
                            <div class="wjfbxl">
                            <div class="xiala1" onclick="document.getElementById('center').src='OA_ydylcfb.aspx'"><span>预定义流程发布</span><span class="jiantou1">●</span></div>
                            <div class="xiala2" onclick="document.getElementById('center').src='OA_zdylcfb.aspx'"><span>自定义流程发布</span><span class="jiantou1">●</span></div>
                            <div class="xiala3" onclick="document.getElementById('center').src='OA_dxfb.aspx'"><span>定向发布</span><span class="jiantou1">●</span></div>
                            </div>
                        </div>
                        <div class="span2 top_back" onmouseover="this.style.cursor='pointer'" onclick="document.getElementById('center').src='OA_ydylcgl.aspx'"><span class="top_title">流程管理</span></div>
                        <div class="span2 top_back spl" onmouseover="this.style.cursor='pointer'">
                            <span class="top_title">审批流</span>
                            <div class="splxl">
                            <div class="xiala1" onclick="document.getElementById('center').src='OA_dqspl.aspx'"><span>当前审批流</span><span class="jiantou1">●</span></div>
                            <div class="xiala2" style="border-bottom: 1px solid #f1efef;" onclick="document.getElementById('center').src='OA_lsspl.aspx'"><span>历史审批流</span><span class="jiantou1">●</span></div>
                            </div>
                        </div>
                        <div class="span2 top_back kaoqing" onmouseover="this.style.cursor='pointer'">
                            <span class="top_title">考勤管理</span>
                            <div class="kaoqingxl">
                            <div class="xiala1" onclick="document.getElementById('center').src='OA_kaoqing.aspx'"><span>我的所有考勤</span><span class="jiantou1">●</span></div>
                            <div class="xiala2" style="border-bottom: 1px solid #f1efef;" onclick="document.getElementById('center').src='OA_kaoqing_all.aspx'"><span>所有员工考勤</span><span class="jiantou1">●</span></div>
                            </div>
                        </div>
                        <div class="span2 top_back xtsz" onmouseover="this.style.cursor='pointer'">
                            <span class="top_title">系统设置</span>
                            <div class="xtszxl">
                            <div class="xiala1" style="margin-left:-84px;" onclick="document.getElementById('center').src='OA_bmyhgl.aspx'"><span>部门员工管理</span><span class="jiantou1">●</span></div>
                            <div class="xiala2" style="border-bottom: 1px solid #f1efef;margin-left:-84px;" onclick="document.getElementById('center').src='OA_mb_manage.aspx'"><span>常用模板管理</span><span class="jiantou1">●</span></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
