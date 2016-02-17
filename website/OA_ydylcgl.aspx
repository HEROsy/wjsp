<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_ydylcgl.aspx.cs" Inherits="OA_ydylcgl" %>

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
        //流程数据json_lc 绑定到列表 删除调用deletelc(id)方法
        window.onload = function () {

        }

        function deletelc(id,title)
        {
            if (confirm("确定要删除 " + title + " 吗？")) {

                $.ajax({
                    type: "post",
                    url: "AsyCenter.aspx",
                    data: {
                        type: "s",
                        lcid:id
                    },
                    success: function (data) {
                        if (data != "1") {
                            alert("删除失败");
                        } else {
                            //隐藏该列 display:none
                        }
                    }
                })

            }
        }
    </script>
</head>

<body>
    <input type="hidden" id="json_lc" value='<%=json_lc %>' />
    <div style="width: 1000px;height:680px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">
            <%--此行不能修改--%>

            预定义流程管理
            <input type="button" value="添加流程" id="addbtn" onclick="document.location.href='OA_addspl.aspx'" />
            <div>
                <table class="table table-hover table-striped">
				<thead>
					<tr>
						<th>
							标题
						</th>
						<th>
							内容
						</th>
						<th>
							操作
						</th>
					</tr>
				</thead>
				<tbody>
					<tr><td>title1</td><td>1-->2</td><td>删除</td></tr>
                    <tr><td>title1</td><td>1-->2</td><td>删除</td></tr>
				</tbody>
			</table>

            </div>
        </div>
    </div>
</body>
</html>


