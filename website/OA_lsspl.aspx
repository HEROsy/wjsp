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
        var pagebox;
        var pageindex;
        var val = "";
        window.onload = function () {
            json_lc = document.getElementById("j_lc").value;
            //spl();
            pagebox = document.getElementById("pagebox");
            //totol();
            GetData(1);

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
            val = document.getElementById("srtxt").value;
            if (val.replace(/\s+/g, "") == "")
            {
                val = "";
            }
            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type: "pagels",
                    key: val,
                    pageindex: '1',
                    pagesize: "10"
                },
                success: function (data) {
                    var json_tv = "";
                    var html = "";
                    var totalcount = "";
                    try {
                        totalcount = data.split("|")[0];
                        var json_data = data.split("|")[1];
                        alert(totalcount);
                        json_tv = eval("(" + json_data + ")");
                        html = html + "<table class='table table-hover'>"
                            + "<thead>"
                            + "<tr>"
                            + "<th>文件编号</th><th>标题</th><th>操作</th>"
                            + "</tr>"
                            + "</thead>"
                            + "<tbody>"
                        totol(totalcount);
                        for (var i = 0; i < json_tv.length; i++) {

                                html = html + "<tr><td>" + decode(json_tv[i].id) + "</td><td>" + decode(json_tv[i].titles) + "</td><td><a href=oa_splxq.aspx?lcid=" + json_tv[i].id + "&type=ed>查看详细</a></td></tr>";

                        }
                        html = html + "</tbody></table>";
                        document.getElementById("tb").innerHTML = html;
                    } catch (e) {
                        document.getElementById("tb").innerHTML = "<span>当前审批流为空请发布审批流。</span>";
                    }

                },
                error: function (data) {

                }
            })

        }

        function InitPages(pagebox, totalpage, pageindex) {
            pagebox.innerHTML = "";

            totalpage = parseInt(totalpage);
            pageindex = parseInt(pageindex);

            var pagenum = 10;
            var middleindex = parseInt(pagenum / 2) + 1;
            var newobj = null;
            if (pageindex == 1) {
                newobj = Create("上页", "disabled");
                pagebox.appendChild(newobj);
            } else {
                newobj = Create("上页", "");
                pagebox.appendChild(newobj);
            }

            //if (pageindex == 1) {
            //    newobj = Create("第一页", "disabled");
            //    pagebox.appendChild(newobj);
            //} else {
            //    newobj = Create("第一页", "");
            //    pagebox.appendChild(newobj);
            //}

            if (totalpage < pagenum) {
                for (var i = 1; i < totalpage + 1; i++) {
                    if (i != pageindex) {
                        newobj = Create(i, "");
                        pagebox.appendChild(newobj);
                    } else {
                        newobj = Create(i, "active");
                        pagebox.appendChild(newobj);
                    }
                }
            } else {
                if (pageindex <= middleindex) {
                    for (var i = 1; i < pagenum + 1; i++) {
                        if (i != pageindex) {
                            newobj = Create(i, "");
                            pagebox.appendChild(newobj);
                        } else {
                            newobj = Create(i, "active");
                            pagebox.appendChild(newobj);
                        }
                    }
                } else {
                    var offsetindex = middleindex - 1;
                    var beginindex = pageindex - offsetindex;
                    var endindex = 0;
                    if (parseInt(pageindex) + offsetindex < totalpage) {
                        endindex = parseInt(pageindex) + offsetindex;
                    } else {
                        endindex = beginindex + (totalpage - beginindex);
                    }

                    for (var i = beginindex; i < endindex + 1; i++) {
                        if (i != pageindex) {
                            newobj = Create(i, "");
                            pagebox.appendChild(newobj);
                        } else {
                            newobj = Create(i, "active");
                            pagebox.appendChild(newobj);
                        }
                    }
                }
            }

            //if (parseInt(pageindex) >= totalpage) {
            //    newobj = Create("最后一页", "disabled");
            //    pagebox.appendChild(newobj);
            //} else {
            //    newobj = Create("最后一页", "");  
            //    pagebox.appendChild(newobj);
            //}

            if (parseInt(pageindex) >= totalpage) {
                newobj = Create("下页", "disabled");
                pagebox.appendChild(newobj);
            } else {
                newobj = Create("下页", "");
                pagebox.appendChild(newobj);
            }


            function Create(inname, classtype) {
                var obj = null;
                var oli = document.createElement("li");
                var oa = document.createElement("a");

                if (classtype != "") { oli.className = classtype; }

                oa.innerHTML = inname;
                oa.href = "javascript:void(0)";
                if ((inname + "").indexOf("页") < 0) {
                    oa.style.width = 15 + "px";
                }
                oa.onclick = function () {
                    pageclick(oa);
                }
                oli.appendChild(oa);

                return oli;
            }

            function pageclick(sender) {
                var pe = sender.parentElement.className;
                if (pe == "disabled" || pe == "active") { return false; }
                var _value = sender.innerHTML;
                switch (_value) {
                    case "上页":
                        GetData(pageindex - 1);
                        InitPages(pagebox, totalpage, pageindex - 1);
                        break;
                    case "下页":
                        GetData(pageindex + 1);
                        InitPages(pagebox, totalpage, pageindex + 1);
                        break;
                        //case "第一页":
                        //    GetData(1);
                        //    InitPages(pagebox, totalpage, 1);
                        //    break;
                        //case "最后一页":
                        //    GetData(totalpage);
                        //    InitPages(pagebox, totalpage, totalpage);
                        //    break;
                    default:
                        GetData(_value);
                        InitPages(pagebox, totalpage, _value);

                }
            }
        }

        function GetData(pageindex) {
            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type: "pagels",
                    key: val,
                    pageindex: pageindex,
                    pagesize: "10"
                },
                success: function (data) {
                    var json_tv = "";
                    var html = "";
                    var totalcount = "";
                    try {
                        totalcount = data.split("|")[0];
                        var json_data = data.split("|")[1];
                        json_tv = eval("(" + json_data + ")");
                        html = html + "<table class='table table-hover'>"
                            + "<thead>"
                            + "<tr>"
                            + "<th>文件编号</th><th>标题</th><th>操作</th>"
                            + "</tr>"
                            + "</thead>"
                            + "<tbody>"
                        totol(totalcount);
                        for (var i = 0; i < json_tv.length; i++) {

                                html = html + "<tr><td>" + decode(json_tv[i].id) + "</td><td>" + decode(json_tv[i].titles) + "</td><td><a href=oa_splxq.aspx?lcid=" + json_tv[i].id + "&type=ed>查看详细</a></td></tr>";
                        }
                        html = html + "</tbody></table>";
                        document.getElementById("tb").innerHTML = html;
                    } catch (e) {
                        document.getElementById("tb").innerHTML = "<span>当前审批流为空请发布审批流。</span>";
                    }

                },
                error: function (data) {

                }
            })
        }

        function totol(totalcount) {
            var page = totalcount;
            var yu = page % 10;
            if (yu == 0) {
                page = page / 10;
            } else {
                page = (page / 10) + 1;
            }
            InitPages(pagebox, page, 1);
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
                    <div class="container-fluid">
                        <div class="pagination">
                            <ul id="pagebox">
                                <li>
                                    <a href="#">上一页</a>
                                </li>
                                <li>
                                    <a href="#">1</a>
                                </li>
                                <li>
                                    <a href="#">2</a>
                                </li>
                                <li>
                                    <a href="#">下一页</a>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
            

        </div>
    </div>
</body>
</html>


