<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_dqspl.aspx.cs" Inherits="OA_dqspl" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Script/swkj.js"></script>
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />
    <title>当前审批流</title>
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
        /*json_lc 包括字段：id,titles  解析并绑定到table中 注意：js操作table时 要用innerhtml 并且每次要将整个table一起重建
          编号栏＝ID   标题栏＝titles  查看详细的超链接地址先不管

          搜索功能： 取搜索框里的文字  和 json_lc 的titles 字段对比（相似的就可以 ） 将结果绑定到table 当搜索框的值为空时 点搜索则绑定全部
        */

        window.onload = function () {

        }
    </script>
</head>

<body>
    <div style="width: 100%;height:675px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">
            <%--此行不能修改--%>
            <div>
                <div ><h1>当前审批流</h1></div>
                <div>
                    <div>
                        <input type="text" id="srtxt" />
                        <input type="button" id="serch" value="搜索" />
                    </div>
                    <div>
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>文件编号</th>
                                    <th>标题</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><td>1</td><td>标题一</td><td><a href="javascript:void(0)">查看详细</a></td></tr>
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


