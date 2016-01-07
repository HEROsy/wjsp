<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_dxfb.aspx.cs" Inherits="OA_dxfb" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Script/swkj.js"></script>
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
        /*json_bm  字段：

        */

        window.onload = function () {

        }
    </script>
</head>

<body>
    <div style="width: 1000px;height:680px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">
            <%--此行不能修改--%>
            定向发布
              <div>
                <div>
                    <div style="float:left;">
                            <select id="st_bm">
                            </select>
                        <div style="border:1px solid #cdcdcd;width:217px;height:250px;"></div>
                    </div>
                    <div style="float:left;width:425px;height:290px;border:1px solid #cdcdcd;margin-left:10px;"></div>
                </div>
                <div style="clear:both">
                    <span>标题：</span><input type="text" />
                </div>
                <div>
                    <span>内容：</span><input type="text" />
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
                    <input type="checkbox"  style="float:left;"/>
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
                      <input type="button" value="确认添加" />
                  </div>
            </div>
        </div>
    </div>
</body>
</html>


