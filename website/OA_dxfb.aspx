<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_dxfb.aspx.cs" Inherits="OA_dxfb" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Script/swkj.js"></script>
    <script src="Script/jquery.form.js"></script>
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />
    <title>定向发布</title>
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
        /*json_bm  字段：id part 
        json_user 字段 : id name u_part
        lc_datas:name,id|name,id
        */
        var upok = true;
        var jinji = null;
        var sfhz = false;
        var filepath = "";
        var html = "";
        var jishu = 0;
        var js = 0;
        var c_id = "";
        var lc_datas = "";
        var arr = "";
        var json_bm = "";
        var json_user = "";

        window.onload = function () {
            json_bm = document.getElementById("j_bm").value;
            json_user = document.getElementById("j_user").value;
            bindupchange();
            bm();
        }

        function decode(str) {
            str = decodeURIComponent(str.replace(/\+/g, '%20'));
            return str;
        }

        function bindupchange() {
            var uf = document.getElementById("upfile");
            js = 0;
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
                            if (js == 0) {
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
                            upok = true;
                            return true;
                        }
                    },
                    erorr: function (data) {
                    }
                })
            }
        }

        function bm() {
            document.getElementById("st_bm").innerHTML = "";
            var data = "";
            html = "";
            try {
                data = eval("(" + json_bm + ")");
                for (var i = 0; i < data.length; i++) {
                    html = html + "<option value='" + decode(data[i].id) + "'>" + decode(data[i].part) + "</option>";
                }
                document.getElementById("st_bm").innerHTML = html;
                var a = document.getElementById("st_bm").value;
            } catch (e) {
                alert("流程数据出错，请检查数据")
            }
            bm_name(a);
        }

        function bm_name(u_part) {
            var data = "";
            html = "";
            var newobj = null;
            document.getElementById("bm_name").innerHTML = "";
            try {
                data = eval("(" + json_user + ")");
                for (var i = 0; i < data.length; i++) {
                    if (data[i].u_part == u_part) {
                        newobj = document.createElement("div");
                        newobj.innerHTML = "<span id='" + decode(data[i].id) + "'>" + decode(data[i].name) + "</span>";
                        newobj.ondblclick = function () { u_name(this) };
                        document.getElementById("bm_name").appendChild(newobj);
                    }
                }
            } catch (s) {

            }
        }

        function u_name(mydiv) {
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
                if (jishu == 1) {
                    lc_datas = lc_datas + s_name + "," + q_id;
                } else {
                    lc_datas = lc_datas + "|" + s_name + "," + q_id;
                }
                if (jishu == 1) {
                    newobj.innerHTML = "" + s_name + "";
                    document.getElementById("namebox").appendChild(newobj);
                } else {
                    newobj.innerHTML = "->" + s_name + "";
                    document.getElementById("namebox").appendChild(newobj);
                }
            }
        }

        function ck(myck) {
            jinji = myck.getElementsByTagName("input")[0].value;
            for (var i = 1; i < 5; i++) {
                document.getElementsByTagName("img")[i].setAttribute("src", "img/d2.png");
            }
            for (var i = 0; i < jinji; i++) {
                document.getElementsByTagName("img")[i].setAttribute("src", "img/h3.png");
            }
        }

        function huizhi() {
            if (sfhz == true) {
                sfhz = false;
            } else {
                sfhz = true;
            }
        }

        function GetData() {
            var tit = document.getElementById("bt").value;
            var conten = document.getElementById("nr").value;
            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type: "newstream",
                    userid: "1",
                    title: tit,
                    contents: conten,
                    sfhz: sfhz,
                    jjcd: jinji,
                    fjpath: filepath,
                    lc_datas: lc_datas
                },
                success: function (data) {
                    if (data == 1) {
                        alert("流程发布成功！");
                    } else {
                        alert("流程发布失败，请重新发布！")
                    }
                }
            })
            shuxing();
        }

        function shuxing() {
            bm();
            document.getElementById("namebox").innerHTML = "";
            document.getElementById("st_fj").innerHTML = "<option>无附件</option>";
            document.getElementById("bt").value = "";
            document.getElementById("nr").value = "";
            arr = "";
            c_id = "";
            jishu = 0;
            js = 0;
            for (var i = 0; i < 5; i++) {
                document.getElementsByTagName("img")[i].setAttribute("src", "img/d2.png");
            }

        }

    </script>
</head>

<body>
    <input type="hidden" id="j_bm" value='<%=json_bm %>' />
    <input type="hidden" id="j_user" value='<%=json_user %>' />
    <div style="width: 1000px;height:680px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">
            <%--此行不能修改--%>
            定向发布
              <div>
                <div>
                    <div style="float:left;">
                            <select onchange="bm_name(value)" id="st_bm">
                                
                            </select>
                        <div style="border:1px solid #cdcdcd;width:217px;height:250px;" id="bm_name">
                            
                        </div>
                    </div>
                    <div style="float:left;width:425px;height:290px;border:1px solid #cdcdcd;margin-left:10px;" id="namebox" ></div>
                </div>
                <div style="clear:both">
                    <span id="titile">标题：</span><input type="text" id="bt" />
                </div>
                <div>
                    <span id="contents">内容：</span><input type="text" id="nr" />
                </div>
                <div>
                     <span style="display:block;float:left" >紧急程度：</span>
                     <ul style="list-style:none;float:left;" >
                         <li onclick="ck(this);" style="float:left;width:60px;"><img src="img/d2.png" /><input type="hidden" value="1" /></li>
                         <li onclick="ck(this);" style="float:left;width:60px" ><img src="img/d2.png" /><input type="hidden" value="2" /></li>
                         <li onclick="ck(this);" style="float:left;width:60px" ><img src="img/d2.png" /><input type="hidden" value="3" /></li>
                         <li onclick="ck(this);" style="float:left;width:60px" ><img src="img/d2.png" /><input type="hidden" value="4" /></li>
                         <li onclick="ck(this);" style="float:left;width:60px" ><img src="img/d2.png" /><input type="hidden" value="5" /></li>
                     </ul>
                </div>
                <div style="clear:both">
                    <span style="display:block;float:left;">是否回执</span>
                    <input type="checkbox"  style="float:left;" onclick="huizhi()"/>
                    <form method="post" id="ufrm" style="width: 126px; height: 30px; display: block; overflow: hidden; position: relative;float:left;margin:0 10px;">
                         <input type="button" value="添加附件" id="upbtn" class="btn" style="width: 126px; height: 30px;" />
                         <input type="file" name="upfile" id="upfile" style="width: 126px; height: 30px; position: absolute; top: 0; left: 0; opacity: 0; filter: alpha(opacity=0);" />
                         <input type="hidden" id="ufname" value="" />
                     </form>
                     <select id="st_fj" style="display:block;float:left;margin:0 10px;">
                         <option>无附件</option>
                     </select>
                </div>
                  <div style="clear:both;">
                      <input type="button" value="确认添加"  onclick="GetData()"/>
                  </div>
            </div>
        </div>
    </div>
</body>
</html>


