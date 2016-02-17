<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_splxq.aspx.cs" Inherits="OA_splxq" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Script/swkj.js"></script>
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />
    <script src="Scripts/jquery.signalR-2.2.0.min.js"></script>
    <script src="signalr/hubs"></script>
    <script src="WebOffice/main.js"></script>
    <title>文件审批流详情</title>
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
        $.connection.myhub;
        $.connection.hub.start().done();

        /*

        编号：bh
        标题：title
        发布时间：biuldtime
        文件内容：contents
        是否回执：ishz   

        json_lc_datas 包含流程中的所有人名和用户ID  字段名：name,id  解析并以界面格式显示 框里显示人名 框这间用箭头隔开

        json_fj  包含流程中的附件信息 字段名:filename,filepath  解析并在附件列表中显示 

        json_yj  包含与此流程相关所有审批意见  字段名：id,yj,times   
        事件：

           点击流程中的人名框后  1  框变色  2 在意见框 显示此人的审批意见 json_lc_datas 中的id  和 json_yj 中的id 对应

           点击附件列表中的某一项 此项要变色（选定效果） 并记录当前选中项的filepath  

           点显示  如果当前附件列表有选中项则调 用showdoc（filepath） 否则  提示用户先选中
        */

        var mfapp = null;
        var onepath = "http://192.168.1.85:94/UpFile/2016010302353814.doc";
        var data = "";
        var html = "";
        var filepath = "";
        var json_lc_datas = "";
        var json_fj = "";
        var json_yj = "";
        window.onload = function () {
            mfapp = document.all.WebOffice1;
            if (mfapp!=null) {
            mfapp.HideMenuItem(0x01 + 0x02 + 0x04 + 0x10 + 0x1000 + 0x4000);
            }
            json_lc_datas = document.getElementById("j_lc").value;
            json_fj = document.getElementById("j_fj").value;
            json_yj = document.getElementById("j_yj").value;
            lcxs();
            fjzs();
            //bind  spyj send
            bindsend();
            bindsend_qj();

        }

        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }

        function getradiovalue()
        {
            var temp = document.getElementsByName("agree");
            var _value="";
            for(var i=0;i<temp.length;i++)
            {
                if(temp[i].checked)
                    _value = temp[i].value;
            }
            return _value;
        }

        function bindsend()
        {
            var bt = document.getElementById("send");
            if (bt==null||bt=="") { 
                return false;
            }
           
            bt.onclick = function ()
            {
                var contents=document.getElementById("spyj").value;
                if (contents.replace(/\s+/g, "") == "") {  return false; }

                $.ajax({
                    type: "post",
                    url: "AsyCenter.aspx",
                    data: {
                        type: "addspyj",
                        lcid: GetQueryString("lcid"),
                        contents:contents
                    },
                    success: function (data)
                    {
                        if (data=="no") {
                            alert("审批意见上传失败！");
                        }else if(data=="ok1")
                        {
                            window.location.reload();
                        }else if(data=="ok2")
                        {
                            alert("审批意见已上传，当前审批流程已结束。");
                            window.location.href = "OA_dqspl.aspx";
                        } else if (data=="ok3") {
                            window.location.reload();
                        } else if (data == "err") {
                            alert("出现错误!");
                        } else {
                            alert("未知错误！！");
                        }
                    },
                    error: function (data)
                    {
                    
                    }

                });
            }
        }

        function bindsend_qj() {
            var bt = document.getElementById("send_qj");
            if (bt == null || bt == "") {
                return false;
            }

            bt.onclick = function () {
                var contents = document.getElementById("spyj").value;
                var agree = getradiovalue();

                if (contents.replace(/\s+/g, "") == "") { return false; }

                $.ajax({
                    type: "post",
                    url: "AsyCenter.aspx",
                    data: {
                        type: "addspyj_qj",
                        lcid: GetQueryString("lcid"),
                        contents: contents,
                        agree:agree
                    },
                    success: function (data) {
                        if (data=="ok") {
                            alert("处理已完成！");
                            window.location.href = "oa_lsspl.aspx";
                        } else if (data=="no") {
                            alert("处理过程出现问题");
                            window.location.href = "oa_dqspl.aspx";
                        }
                    },
                    error: function (data) {

                    }

                });
            }
        }

        function showdoc(docpath)
        {
            newDocAtServer_doc(docpath);
        }

        function newDocAtServer_doc(path) {
            try {
                var webObj = document.getElementById("WebOffice1");
                var doctype = "doc";// document.getElementById("doctype").value;
                webObj.LoadOriginalFile(path, doctype);
            } catch (e) {
                alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description);
            }
             hideAll('hideall', '', '', '')
        }

        function decode(str) {
            str = decodeURIComponent(str.replace(/\+/g, '%20'));
            return str;
        }

        function lcxs() {
            data = "";
            html = "";
            var js = 0;
            try {
                data = eval("(" + json_lc_datas + ")");
                for (var i = 0; i < data.length; i++) {
                    if (js==0) {
                        html = html + "<div style='background-color:aqua;width:50px;height:50px;border-radius:10px;float:left' onclick='spyj(this)' >" + decode(data[i].name) + ""
                                             +"<input type='hidden' value=" + decode(data[i].id) + " /></div>";
                        js = js + 1;
                    } else {
                        html = html + "<span style='display:block;float:left;line-height:50px;margin:0 5px;'>--></span>"
                                        + "<div style='background-color:aqua;width:50px;height:50px;border-radius:10px;float:left' onclick='spyj(this)'>" + decode(data[i].name) + ""
                                                 +"<input type='hidden' value=" + decode(data[i].id) + " /> </div>";
                    }
                }
                document.getElementById("lcxm").innerHTML = html;
            } catch (e) {
                alert("流程数据解析失败。")
            }
        }

        function fjzs() {
            data = "";
            html = "";
            try {
                data = eval("(" + json_fj + ")");
                for (var i = 0; i < data.length; i++) {
                    html = html + "<li onclick='spfj(this)'><span>" + decode(data[i].filename) + "</span><input type='hidden' value=" + decode(data[i].filepath) + " /></li>";
                }
                document.getElementById("fjzs").innerHTML = html;
            } catch (e) {
                alert("附件数据解析失败");
            }
        }

        function spyj(mydiv) {
            var div3 = document.getElementById("lcxm").getElementsByTagName("div");
            var len = div3.length;
            for (var i = 0; i < len; i++) {
                div3[i].style.backgroundColor = "aqua";
            }
            mydiv.style.backgroundColor = "red";
            data = "";
            html = "";
            try {
              data = eval("(" + json_yj + ")");
            } catch (e) {
                document.getElementById("yj").innerHTML = "无数据";
                return false;
            }
            
            var a = mydiv.getElementsByTagName("input")[0].value;
            for (var i = 0; i < data.length; i++) {
                if (data[i].id==a) {
                    html = decode(data[i].yj);
                    if(html==""){html="无数据"}
                }
            }
            document.getElementById("yj").innerHTML = html;
        }

        function spfj(myli) {
            var li3 = document.getElementById("fjzs").getElementsByTagName("li");
            var len = li3.length;
            for (var i = 0; i < len; i++) {
                li3[i].style.color = "black";
            }
            myli.style.color = "red";
            filepath = myli.getElementsByTagName("input")[0].value;
        }

        function xianshi() {
            if (filepath!="") {
                showdoc("http://192.168.1.85:5339" + filepath);
            } else {
                alert("你未选中附件");
            }
        }

    </script>
</head>

<body>
    <form id="form1" runat="server">
    <input type="hidden" id="j_lc" value='<%=json_lc_datas %>' />
    <input type="hidden" id="j_fj" value='<%=json_fj %>' />
    <input type="hidden" id="j_yj" value='<%=json_yj %>' />
    <div style="width: 1000px;height:680px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">
            <%--此行不能修改--%>
            
            <div>
                <div>
                    <h1>文件审批流详情</h1>
                </div>
                <div style="height:80px;margin-top:10px;">
                    <div style="float:left;width:300px;"><span>编号：</span><span><%=bh %></span>       </div>
                    <div style="float:left;width:300px;"><span>标题：</span><span><%=title %></span>      </div>
                    <div style="float:left;width:300px;"><span>发布时间：</span><span><%=biuldtime %></span>  </div>
                </div>
                <div style="min-height:50px;" id="lcxm">
                    <div style="background-color:aqua;width:50px;height:50px;border-radius:10px;float:left"></div>
                    <input type="hidden" value="a" />
                    <span style="display:block;float:left;line-height:50px;margin:0 5px;">--></span>
                    <div style="background-color:aqua;width:50px;height:50px;border-radius:10px;float:left"></div>
                </div>
                <div style="clear: both; width: 800px; margin: 10px auto;">
                    <div style="height: 200px;">
                        <div style="float: left; width: 550px; height: 200px; border: 1px solid #cdcdcd">
                            <%=contents %>
                        </div>
                        <div style="float: left; width: 150px; height: 200px; border: 1px solid #cdcdcd; border-left: none;">
                            <div style="height: 35px;">
                                <input type="button" value="显示" onclick="xianshi();" style="float: left; margin: 4px 10px 0 37px;" />
                                <input type="button" value="下载" style="float: left; margin-top: 4px" />
                            </div>
                            <div style="height: 165px; overflow-y: scroll;">
                                <ul style="list-style: none" id="fjzs">
                                    <li><span>无附件</span><input type="hidden" value="x.doc" /></li>
                                </ul>
                            </div>

                        </div>
                    </div>
                    <%=weboffice %>
                    
                    <div style="width: 700px; height: 80px; border: 1px solid #cdcdcd; margin-top: 10px;">
                        <div style="float:left;" id="yj">
                            审批意见！审批意见！审批意见！审批意见！
                        </div>
                        <div style="float:right;">
                            是否回执:<%=ishz %>
                        </div>
                    </div>

                   <%=spyj %>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>

