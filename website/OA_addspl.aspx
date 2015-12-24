<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_addspl.aspx.cs" Inherits="OA_addspl" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Script/swkj.js"></script>
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />
    <title>预定义流程管理</title>
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
    </style>

    <script type="text/javascript">
        window.onload = function () {

        }

        //概述：用户通过下拉框选择不同部门　userbox这个div根据用户的选择显示对应的用户
        //　　　双击某个用户　让它出现在左边的lcbox框　（显示成这样：姜凯源—>石晓楠）
        //　　　点‘添加’时　发送异步请求到服务器保存用户的选择
        //step:
      　 // 1.json_bm　为部门信息josn字符串　包括字段：id　part
        //  解析它的数据绑定到下拉框中（下拉框id="bm" 每条选项的文本显示part内容　value为id）

        //  2.为下拉框bm　添加onchange事件　每次触发这个事件时　获取当前选项的值　并根据这个值在
        //  　json_user 这个joson字符串里筛选要显示的值　它包括字段：u_part name
        //    关系为 选中项的值=u_part

        //    3.点‘添加’时：
        //    发请求到AsyCenter.aspx
        //type:'addspl'
        //userid:'1'
        //contents:选中的每一个人的ＩＤ用逗号隔开
        //contents_txt:选中的每一个人的名字用逗号隔开
        //splname:splname.value

        //请求返回结果‘1’表示成功  否则失败

    </script>
</head>

<body>
    <div style="width: 1000px;height:680px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">
            <%--此行不能修改--%>
            预定义流程添加

            <div>
                <div style="float:left">
                    <div>
                        <select id="bm"></select>
                    </div>
                    <div style="width:217px;height:300px;border:1px solid #cdcdcd"　id="userbox">
                        <div><span>name</span></div>
                    </div>
                </div>

                <div style="float:left">
                    <div><span>流程名称：</span><input type="text" id="splname"/></div>
                    <div style="width:550px; height:300px;margin:40px 1px 1px 53px;border:1px solid #cdcdcd" id="lcbox">

                    </div>
                    <div >
                        <input type="button" value="确认添加"　id="addbtn"  style="margin-left:53px"/>
                    </div>
                </div>
            </div>
           

        </div>
    </div>
</body>
</html>
