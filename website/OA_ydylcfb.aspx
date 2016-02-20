<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_ydylcfb.aspx.cs" Inherits="OA_ydylcfb" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Script/jquery.form.js"></script>
    <script src="Script/swkj.js"></script>
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />
    <title>预定义流程发布</title>
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
        .title1 {
            background-color: #004B7C;
            height: 72px;
            line-height: 82px;
            display: block;
            color: #ffffff;
            text-align: center;
            font-size: 19px;
            letter-spacing: 4px;
            font-weight: bold;
        }
        #dqjj {
            color: #ffffff;
            line-height: 24px;
            margin-left: 40px;
        }
        #send {
            cursor: pointer;
            color: #ffffff;
            line-height: 40px;
            text-align: center;
            display: block;
            letter-spacing: 4px;
            font-weight: bold;
            font-size: 16px;
        }
        .qrfb {
            float: left;
            height: 40px;
            width: 180px;
            margin-left: 160px;
            background-color: #f26666;
            margin-top: 28px;
        }
    </style>

    <script type="text/javascript">
       /* json_lc 字段包括：id spl_name spl_content_txt   将它邦定到st_lc (value=id  text=spl_name )
        *当用户选择某个流程时 显示对应流程名 和流程信息
        *
        *紧急程度 绑定点击事件 像这样  点第二个标志  就记录一个值2 同时第一个标志和第二个都变色  点第三个就记录3  一到三个标志都变色
        *
        *
        *点“发布”时 发异步   type:post 
                               url:AsyCenter.aspx    
                               data:{
                               type:newstream
                               userid:1
                               lcid:st_lc选定的值
                               title:标题
                               contents:内容
                               sfhz:勾起为true 否则为false
                               jjcd：记录的紧急程度值
                               fjpath:记录的filepath值
                               }
                               成功返回 1 
        */
        var json_le = "";
        var filepath = "";
        var upok = true;
        var jinji = null;
        var sfhz = false;

        window.onload = function () {
            bindupchange();
            json_le = document.getElementById("lc").value;
            process();
        }

        function decode(str) {
            str = decodeURIComponent(str.replace(/\+/g, '%20'));
            return str;
        }

        function bindupchange() {
            var uf = document.getElementById("upfile");
            var js = 0;
            uf.onchange = function () {
                if (!upok) { alert('正在上传...'); return false; }
                upok = false;
                $("#ufrm").ajaxSubmit({
                    url: "ReceivFile.ashx",
                    type: "post",
                    success: function (data) {
                        data = data.replace("<PRE>", "").replace("</PRE>", "");
                        var r = null;
                        try {
                            r = eval("(" + data + ")");
                        } catch (e) {
                            alert("上传失败！");
                            upok = true;
                            return false;
                        }
                       
                        if (r.state == "no") {
                            alert("上传的文件不符合规范，请重试！");
                            upok = true;
                            return false;
                        } else if (r.state == "ok") {
                            if (js==0) {
                                document.getElementById("st_fj").innerHTML = "";
                            }
                            var newobj = null;
                            newobj = document.createElement("option");
                            newobj.innerHTML = "" + r.filename + "";
                            document.getElementById("st_fj").appendChild(newobj);
                            js = js + 1;
                            if (filepath == "") {
                                filepath = filepath + r.filename + "," + r.filepath;
                            } else {
                                filepath = filepath + "|" + r.filename + "," + r.filepath;
                            }
                            alert(filepath)
                            upok = true;
                            return true;
                        }
                    },
                    erorr: function (data) {
                    }
                })
            }
        }

        function process() {
            if (json_le=="") {
                return;
            }
            document.getElementById("st_lc").innerHTML = "";
            var data = "";
            var html = "<select id='st_lc' onchange='process_1(value)'>";
            try {
                data = eval("(" + json_le + ")");
                for (var i = 0; i < data.length; i++) {
                    html = html + "<option value='" + decode(data[i].id) + "'>" + decode(data[i].spl_name) + "</option>";
                }
                html = html + "</select>";
                document.getElementById("st_box").innerHTML = html;
                var a = document.getElementById("st_lc").value;
            } catch (e) {
                alert("流程数据出错，请检查数据")
            }
            process_1(a);
        }

        function process_1(id) {
            var data = "";
            try {
                data = eval("(" + json_le + ")");
                for (var i = 0; i < data.length; i++) {
                    if (data[i].id== id) {
                        document.getElementById("st_lc1").innerHTML = "当前选择流程《"+decode(data[i].spl_name)+"》 :我-> ";
                        document.getElementById("st_lc2").innerHTML = decode(data[i].spl_content_txt).replace(/\,/g, "->");
                    }
                }
            } catch (s) {

            }
        }

        function ck(myck) {
            jinji = myck.getElementsByTagName("input")[0].value;
            document.getElementById("dqjj").innerHTML = "当前紧急程度： " + dxx(jinji) + " 星";
            for (var i = 1; i < 5; i++) {
                document.getElementsByTagName("img")[i].setAttribute("src", "img/d2.png");
            }
            for (var i = 0; i < jinji; i++) {
                document.getElementsByTagName("img")[i].setAttribute("src", "img/h3.png");
            }
        }

        function dxx(val) {
            if (val == "1") {
                return "一";
            }
            if (val == "2") {
                return "两";
            }
            if (val == "3") {
                return "三";
            }
            if (val == "4") {
                return "四";
            }
            if (val == "5") {
                return "五";
            }
        }

        function huizhi() {
            if (sfhz==true) {
                sfhz = false;
            } else {
                sfhz = true;
            }
        }

        function GetData() {
            var tit = document.getElementById("titile").value;
            var conten = document.getElementById("contents").value;
            var lcid = document.getElementById("st_lc").value;
            if (tit.replace(/\s+/g, "") == "") {
                alert("请输入标题！");
                return false;
            }
            if (conten.replace(/\s+/g, "") == "") {
                alert("请输入内容！");
                return false;
            }
            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type: "newstream",
                    userid: document.getElementById("uid").value,
                    lcid: lcid,
                    title: tit,
                    contents: conten,
                    sfhz: sfhz,
                    jjcd: jinji,
                    fjpath: filepath,
                    lctype:"1"
                },
                success: function (data) {
                    if (data == 1) {
                        alert("流程发布成功！");
                    } else {
                        alert("流程发布失败，请重新发布！")
                    }
                }
            })
        }
    </script>
</head>

<body>
    <input type="hidden" id="lc" value='<%=json_lc%>' />
    <input type="hidden" id="uid" value="<%=uid %>" />
    <div style="width:1000px;height:650px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid">
            <%--此行不能修改--%>

            <span class="title1">预定义流程发布</span>
            <div style="background-color: #0563A0; height: 550px;">
                <div style="height: 110px; padding-top: 20px; margin-left: 60px;">
                    <div style="width: 240px; height: 100px; float: left;">
                        <span style="color: #ffffff">请选择流程：</span>
                        <div id="st_box" style="margin-top: 20px;">
                            <select id="st_lc" onchange="process_1(value)">
                                <option value="-1">无数据</option>
                            </select>
                        </div>

                    </div>
                    <div style="width: 540px; height: 100px; float: left; margin-left: 35px;">
                        <span style="display: block; margin-bottom: 20px; color: #ffffff;">请输入标题：</span>
                        <input id="titile" type="text" style="width:600px;" />
                    </div>
                    <div style="height: 30px;width: 100%;float: left;color:#ffffff;">
                    <span id="st_lc1">流程名</span>
                    <span id="st_lc2">A->B->C...</span>
                    </div>
                </div>
                <div style="margin-left: 60px; width: 877px;margin-top:50px;">
                    <span style="display: block; color: #ffffff;">请输入内容：</span>
                    <textarea id="contents" style="width: 100%; height: 150px; resize: none; overflow-y: auto"></textarea>
                </div>
                 <div style="clear:both; height:50px; margin-left:60px;margin-top:35px;">
                     <span style="display:block;float:left;color:#ffffff;line-height:32px;">是否回执:</span>
                     <input type="checkbox" id="huizhi" onclick="huizhi()" style="display:block;float:left;margin: 10px 10px 0 15px;" />

                     <form method="post" id="ufrm" style="width: 126px; height: 30px; display: block; overflow: hidden; position: relative;float:left;margin:0 10px;">
                         <input type="button" value="添加附件" id="upbtn" class="btn" style="width: 126px; height: 30px;" />
                         <input type="file" name="upfile" id="upfile" style="width: 126px; height: 30px; position: absolute; top: 0; left: 0; opacity: 0; filter: alpha(opacity=0);" />
                         <input type="hidden" id="ufname" value="" />
                     </form>
                     <span style="display:block;float:left;line-height:34px;color:#ffffff;margin-left:50px;">当前上传附件列表：</span>
                     <select id="st_fj" style="display:block;float:left;margin:0 10px;width:448px;">
                         <option>无附件</option>
                     </select>
                 </div>


                <div style="height: 60px; margin-left: 60px; margin-top: 30px;float:left;width:55%">
                    <span style="display: block; float: left;color:#ffffff;line-height:24px;">紧急程度：</span>
                    <ul style="list-style: none; float: left;margin-left:34px;">
                        <li onclick="ck(this);" style="float: left; width: 30px;">
                            <img src="img/d2.png" /><input type="hidden" value="1" /></li>
                        <li onclick="ck(this);" style="float: left; width: 30px">
                            <img src="img/d2.png" /><input type="hidden" value="2" /></li>
                        <li onclick="ck(this);" style="float: left; width: 30px">
                            <img src="img/d2.png" /><input type="hidden" value="3" /></li>
                        <li onclick="ck(this);" style="float: left; width: 30px">
                            <img src="img/d2.png" /><input type="hidden" value="4" /></li>
                        <li onclick="ck(this);" style="float: left; width: 30px">
                            <img src="img/d2.png" /><input type="hidden" value="5" /></li>
                    </ul>
                    <span id="dqjj">当前紧急程度： 0 星</span>
                 </div>
                 <div class="qrfb">
                     <%--<input type="button" id="send" value="确认发布" onclick="GetData()"/>--%>
                     <span id="send" onmouseover="this.style.cursor='pointer'" onclick="GetData()">确认发布</span>
                 </div>
            </div>
            
        </div>
    </div>
</body>
</html>


