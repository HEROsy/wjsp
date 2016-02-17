<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_kaoqingCL.aspx.cs" Inherits="kaoqingCL" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script src="Script/jquery-1.8.2.min.js"></script>
    <title></title>
    <style>
        span{
            font-family:微软雅黑 !important;
            letter-spacing:1px !important;
        }
    </style>
    <script>

        var jbm = "";
        var jusers = "";
        window.onload = function ()
        {
            document.getElementById("send").onclick = function () { send(); }
            Initbm();
        }

        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }

        function send()
        {
            var id = GetQueryString("id");
            var qjtype = getradiovalue(); 
            var contents = document.getElementById("ly").value;
            var userid = document.getElementById("people").getElementsByTagName("input")[0].value;
            var username = document.getElementById("people").getElementsByTagName("span")[0].innerHTML;
            var aop = GetQueryString("aop"); if (aop == "sw") { aop = "a" } else if (aop == "xw") { aop = "p"; } else { return false; }

            if (document.getElementById("wxzyx").innerHTML == "未选择") { alert("请选择部门，然后选择相应人员！"); return false; }
            if (contents.replace(/\s+/g, "") == "") { alert("请输入请假事由！"); return false; }
            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type: "qj",
                    kqid: id,
                    qjtype: qjtype,
                    ly: contents,
                    spuserid: userid,
                    spusername: username,
                    aop:aop
                },
                success: function (data)
                {
                    window.location.href = "oa_center.aspx";
                }

            })
        }

        function getradiovalue()
        {
            var temp = document.getElementsByName("tp");
            var _value="";
            for(var i=0;i<temp.length;i++)
            {
                if(temp[i].checked)
                     _value = temp[i].value;
            }
            return _value;
        }

        function Initbm()
        {
            var bm = document.getElementById("bm").value;
            var users = document.getElementById("users").value;
            var stbox = document.getElementById("stbox");

           
            var html = "";
            try {
                jbm = eval("(" + bm + ")");
                jusers = eval("("+users+")");
            } catch (e) {
                html = "<select id='bmst' onchange='binduser()'><option value='－1'>无部门数据</option></select>";
                stbox.innerHTML = html;
            }

            html = "<select id='bmst' onchange='binduser()'><option value='-1'>请选择</option>";
            for (var i = 0; i < jbm.length; i++) {
                html = html + "<option value='"+jbm[i].id+"'>"+decode(jbm[i].part)+"</option>";//
            }
            html = html + "</select>";
            stbox.innerHTML = html;
        }

        function decode(str) {
            str = decodeURIComponent(str.replace(/\+/g, '%20'));
            return str;
        }

        function binduser()
        {
            var st = document.getElementById("bmst");
            var sv = st.options[st.selectedIndex].value;
           
            if (sv == "-1") { document.getElementById("ubox").innerHTML = ""; return false;}

            var id = "";
            var up = "";
            var name = "";
            var html = "";
            for (var i = 0; i < jusers.length; i++) {
                id = jusers[i].id;
                up = jusers[i].u_part;
                name =decode(jusers[i].name);
                if (sv==up) {
                    html +="<div ondblclick=dbc("+id+",'"+name+"')><input type='hidden' value='"+id+"' /><span style='display:block; color:#ffffff;'>"+name+"</span></div>";
                }
            }
            document.getElementById("ubox").innerHTML = html;
        }

        function dbc(id,name)
        {
            document.getElementById("people").innerHTML = "<div ><input type='hidden' value='"+id+"' /><span style='display:block; color:#ffffff;' id='wxzyx'>"+name+"</span></div>";
        }

    </script>
</head>
<body>
    <input type="hidden" id="bm" value='<%=bm %>'/>
    <input type="hidden" id="users" value='<%=users %>' />

    <div style="height:72px; line-height:72px; background-color:#004B7C;">
        <div style="float:left; color:#ffffff;"><span style="margin-left:10px;">当前处理日期：</span><span><%=datetime %></span></div>
        <div style="float:left; color:#ffffff; margin-left:164px;"><span><%=aop %>：</span><span><%=sw %></span></div>
        <div style="float:left; color:#ffffff; margin-left:164px;">
            <span>病假</span><input type="radio" name="tp" checked="checked" value="2" />
            <span>事假</span><input type="radio" name="tp" value="3" />
            <span>公假</span><input type="radio" name="tp" value="4" />
        </div>

    </div>

    <div style="background-color:#0563A0; height:550px;">
        <div>
            <div style="height: 280px; float:left; margin-left:75px;margin-top:75px;">
                <span style="display: block; color: #ffffff;">请假事由：</span>
                <textarea id="ly" style="resize: none; height: 200px; width: 400px; margin-top:30px;"></textarea>
            </div>
            <div style="float:left; width:303px;margin-left:75px;">
                <span style="display:block; margin-top:75px; margin-bottom:30px; color:#ffffff;">请选择部门和人员：</span>
                <div style="height: 50px; float: left;">
                    <div id="stbox" style="float: left;">
                        <select id="bmst" onchange="binduser()">
                            <option value="1">加载中</option>
                        </select>
                    </div>

                    <div id="people" style="float: left; margin-left: 10px; display: block;">
                        <div>
                            <input type="hidden" value="-1" /><span style="display: block; color:#ffffff;" id="wxzyx">未选择</span>
                        </div>
                    </div>

                </div>


                <div style="margin-left: 150px;">
                    <div id="ubox" style="width: 150px; height: 200px; border: 1px solid #cdcdcd">
                    </div>
                </div>
        <div style="margin-top: -21px;">
            <input type="button" id="send" value="确定" />
        </div>
            </div>
        </div>

    </div>
</body>
</html>
