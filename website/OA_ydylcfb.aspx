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
                             
        *
        *
        *
        */

        window.onload = function () {
            bindupchange();
        }

        var upok = true;
        function bindupchange() {
            var uf = document.getElementById("upfile");
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
                            //1. 把r.filename添加到st_fj里
                            //2.把r.filepath记录起来 

                            alert(r.filename+r.filepath);
                            upok = true;
                            return true;
                        }
                    },
                    erorr: function (data) {
                    }
                })
            }
        }
    </script>
</head>

<body>
    <div style="width: 1000px;height:680px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">
            <%--此行不能修改--%>

            <h1>预定义流程发布</h1>
            <div>
                 <div>
                     <span>流程：</span>
                     <select id="st_lc"><option value="-1">请选择</option></select>
                     <span>流程名</span>
                     <span>A->B->C...</span>
                 </div>
                 <div>
                     <span>标题：</span>
                     <input id="titile" type="text" />
                 </div>
                 <div>
                      <span style="display:block;float:left">内容：</span>
                      <textarea id="contents" style="width:80%;height:300px;resize:none;overflow-y:auto"></textarea>
                 </div>
                 <div>
                     <span style="display:block;float:left">紧急程度：</span>
                     <ul style="list-style:none;float:left;">
                         <li style="float:left;width:60px"><a href="javascript:void(0);"><img src="img/d2.png" /></a><input type="hidden" value="1" /></li>
                         <li style="float:left;width:60px"><a href="javascript:void(0);"><img src="img/d2.png" /></a><input type="hidden" value="1" /></li>
                         <li style="float:left;width:60px"><a href="javascript:void(0);"><img src="img/d2.png" /></a><input type="hidden" value="1" /></li>
                         <li style="float:left;width:60px"><a href="javascript:void(0);"><img src="img/d2.png" /></a><input type="hidden" value="1" /></li>
                         <li style="float:left;width:60px"><a href="javascript:void(0);"><img src="img/d2.png" /></a><input type="hidden" value="1" /></li>
                     </ul>
                 </div>
                 <div style="clear:both;">
                     <span style="display:block;float:left;">是否回执</span>
                     <input type="checkbox" id="huizhi" style="display:block;float:left;margin:0 10px;" />

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
                     <input type="button" id="send" value="确认发布"/>
                 </div>
            </div>
            
        </div>
    </div>
</body>
</html>


