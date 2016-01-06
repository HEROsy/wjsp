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

        var json_bm = "";
        var json_user = "";
        var html = "";
        var jishu = 0;
        var c_id = "";
        var c_txt = "";
        var arr = new Array();

        window.onload = function () {
            json_bm = document.getElementById("j_bm").value;
            json_user = document.getElementById("j_user").value;
            addspl();
        }

        //概述：用户通过下拉框选择不同部门　userbox这个div根据用户的选择显示对应的用户
        //　　　双击某个用户　让它出现在左边的lcbox框　（显示成这样：姜凯源->石晓楠）
        //　　　点‘添加’时　发送异步请求到服务器保存用户的选择
        //step: 
        // 1.json_bm　为部门信息josn字符串　包括字段：id　part
        //  解析它的数据绑定到下拉框中（下拉框id="bm" 每条选项的文本显示part内容　value为id）

        //  2.为下拉框bm　添加onchange事件　每次触发这个事件时　获取当前选项的值　并根据这个值在
        //  　json_user 这个joson字符串里筛选要显示的值　它包括字段：u_part name,id
        //    关系为 选中项的值=u_part

        //    3.点‘添加’时：
        //    发请求到AsyCenter.aspx
        //type:'addspl'
        //userid:'1'
        //contents:选中的每一个人的ＩＤ用逗号隔开
        //splname:splname.value  //流程名称.value
        //contents_txt:选中的每一个人的名字用逗号隔开
        //最后提示添加成功或失败

        //请求返回结果‘1’表示成功  否则失败

        function decode(str) {
            str = decodeURIComponent(str.replace(/\+/g, '%20'));
            return str;
        }

        function addspl() {
            var data = eval("(" + json_bm + ")");
            html = "";
            for (var i = 0; i < data.length; i++) {
                html = html + "<option value='" + decode(data[i].id) + "'>" + decode(data[i].part) + "</option>";
            }
            document.getElementById("bm").innerHTML = html;
            var a = document.getElementById("bm").value;
            change(a);
        }

        function change(id) {
            var _id = document.getElementById("bm").value;
            var data = eval("(" + json_user + ")");
            html = "";
            var newobj = null;
            document.getElementById("userbox").innerHTML = "";
            for (var i = 0; i < data.length; i++) {
                if (data[i].u_part == _id) {
                    newobj = document.createElement("div");
                    newobj.innerHTML = "<span id='" + decode(data[i].id) + "'>" + decode(data[i].name) + "</span>";
                    newobj.ondblclick = function (){    click(this)  };
                    document.getElementById("userbox").appendChild(newobj);
                }
            }
        }

        function click(mydiv) {
            var s_name = mydiv.getElementsByTagName("span")[0].innerHTML;
            //getElementByTagName 返回的是一个数组，你要自己指定需要的是哪个下标的值 
            var q_id = mydiv.getElementsByTagName("span")[0].id;
            jishu = jishu + 1;
            var a = 0;
            var newobj = null;
            newobj = document.createElement("span");
            arr = c_id.split(",");
            a = arr.indexOf(q_id);
            if (a == -1) {
                if (jishu == 1) {
                    c_id = c_id + q_id;
                } else {
                    c_id = c_id + "," + q_id;
                }
                if (jishu==1) {
                    c_txt = c_txt + s_name;
                } else {
                    c_txt = c_txt + "," + s_name;
                }
                if (jishu == 1) {
                    newobj.innerHTML = "" + s_name + "";
                    document.getElementById("lcbox").appendChild(newobj);
                } else {
                    newobj.innerHTML = "->" + s_name + "";
                    document.getElementById("lcbox").appendChild(newobj);
                }
            }
        }

        function yes() {
            var splname = document.getElementById("splname").value;
            if (splname.replace(/\s+/g, "") == "") {
                alert("流程名不能为空")
            } else if (c_id == "") {
                alert("流程不能为空")
            } else {
                Data(splname);
            }
        }
        
        function Data(splname) {
            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type: "addspl",
                    userid: "1",
                    contents: c_id,
                    contents_txt: c_txt,
                    splname: splname
                },
                success: function (data) {
                    if (data==1) {
                        alert("流程添加成功！");
                    } else {
                        alert("流程添加失败，请重新添加！")
                    }
                }
            })
        }

    </script>
</head>

<body>
    <input type="hidden" id="j_bm" value='<%=json_bm %>' />
    <input type="hidden" id="j_user" value='<%=json_user %>' />
    <div style="width: 1000px; height: 680px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">
            <%--此行不能修改--%>
            预定义流程添加

            <div>
                <div style="float: left">
                    <div>
                        <select id="bm" onchange="change(this)">
                            <option value="xz">请选择部门</option>
                        </select>
                    </div>
                    <div id="userbox" style="width: 217px; height: 300px; border: 1px solid #cdcdcd;">
                        <div><span>name</span></div>
                    </div>
                </div>

                <div style="float: left">
                    <div><span>流程名称：</span><input type="text" id="splname" /></div>
                    <div style="width: 550px; height: 300px; margin: 40px 1px 1px 53px; border: 1px solid #cdcdcd" id="lcbox">
                    </div>
                    <div>
                        <input type="button" value="确认添加" id="addbtn" style="margin-left: 53px" onclick="yes()" />
                    </div>
                </div>
            </div>


        </div>
    </div>
</body>
</html>
