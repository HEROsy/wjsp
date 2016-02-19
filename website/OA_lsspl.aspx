<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_lsspl.aspx.cs" Inherits="OA_lsspl" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Script/swkj.js"></script>
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />
    <title>历史审批流</title>
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


        var json_lc = "";

        window.onload = function () {
            json_lc = document.getElementById("j_lc").value;
            spl();
        }

        function decode(str) {
            str = decodeURIComponent(str.replace(/\+/g, '%20'));
            return str;
        }

        function spl() {
            var data = "";
            var html = "";
            try {
                data = eval("(" + json_lc + ")");
                html = html + "<table class='table table-hover'>"
                    + "<thead>"
                    + "<tr>"
                    + "<th>文件编号</th><th>标题</th><th>操作</th>"
                    + "</tr>"
                    + "</thead>"
                    + "<tbody>"
                for (var i = 0; i < data.length; i++) {
                    html = html + "<tr><td>" + decode(data[i].id) + "</td><td>" + decode(data[i].titles) + "</td><td><a href=oa_splxq.aspx?lcid=" + data[i].id + "&type=ed>查看详细</a></td></tr>";
                }
                html = html + "</tbody></table>";
                document.getElementById("tb").innerHTML = html;
            } catch (e) {
                document.getElementById("tb").innerHTML = "<span>当前审批流为空请发布审批流。</span>";
            }
        }

        function selesql() {
            var suoso = document.getElementById("srtxt").value;
            var data = "";
            var html = "";
            try {
                data = eval("(" + json_lc + ")");
                html = html + "<table class='table table-hover'>"
                    + "<thead>"
                    + "<tr>"
                    + "<th>文件编号</th><th>标题</th><th>操作</th>"
                    + "</tr>"
                    + "</thead>"
                    + "<tbody>"
                for (var i = 0; i < data.length; i++) {
                    var y = null;
                    y = decode(data[i].titles).indexOf(suoso);
                    if (y != -1) {
                        html = html + "<tr><td>" + decode(data[i].id) + "</td><td>" + decode(data[i].titles) + "</td><td><a href=oa_splxq.aspx?lcid=" + data[i].id + "&type=ing>查看详细</a></td></tr>";
                    }
                    if (suoso == "") {
                        spl();
                    }
                }
                html = html + "</tbody></table>";
                document.getElementById("tb").innerHTML = html;
            } catch (e) {
                alert("无数据")
            }
        }
    </script>
</head>

<body>
   <input type="hidden" id="j_lc" value='<%=json_lc %>' />
    <div style="width: 100%;height:675px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">
            <%--此行不能修改--%>
            <div>
                <div ><h1>历史审批流</h1></div>
                <div>
                    <div>
                        <input type="text" id="srtxt" />
                        <input type="button" id="serch" value="搜索"  onclick="selesql()"/>
                    </div>
                    <div  id="tb">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>文件编号</th>
                                    <th>标题</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><td>1</td><td>标题一</td><td><a href="oa_splxq.aspx">查看详细</a></td></tr>
                                <tr><td>2</td><td>标题二</td><td><a href="javascript:void(0)">查看详细</a></td></tr>
                                <tr><td>3</td><td>标题三</td><td><a href="javascript:void(0)">查看详细</a></td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            

        </div>
    </div>
</body>
</html>


