<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_splxq.aspx.cs" Inherits="OA_splxq" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Script/swkj.js"></script>
    <link href="Style/swkj.css" rel="stylesheet" />
    <link href="Style/swkjbt.css" rel="stylesheet" />
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
        var mfapp = null;
        var onepath = "http://192.168.1.85:94/UpFile/2016010302353814.doc";
        window.onload = function () {
            mfapp = document.all.WebOffice1;
            mfapp.HideMenuItem(0x01 + 0x02 + 0x04 + 0x10 + 0x1000 + 0x4000);
        }

        function showdoc(docpath)
        {
            alert(docpath);
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
    </script>
</head>

<body>
    <div style="width: 1000px;height:680px; margin: auto">
        <%--此行不能修改--%>
        <div class="row-fluid" style="margin-top: 10px">
            <%--此行不能修改--%>

            
            <div>
                <div>
                    <h1>文件审批流详情</h1>
                </div>
                <div style="height:80px;margin-top:10px;">
                    <div style="float:left;width:300px;"><span>编号:</span><span></span>       </div>
                    <div style="float:left;width:300px;"><span>标题：</span><span></span>      </div>
                    <div style="float:left;width:300px;"><span>发布时间：</span><span></span>  </div>
                </div>
                <div style="min-height:50px;">
                    <div style="background-color:aqua;width:50px;height:50px;border-radius:10px;float:left"></div>
                    <span style="display:block;float:left;line-height:50px;margin:0 5px;">--></span>
                    <div style="background-color:aqua;width:50px;height:50px;border-radius:10px;float:left"></div>
                </div>
                <div style="clear: both; width: 800px; margin: 10px auto;">
                    <div style="height: 200px;">
                        <div style="float: left; width: 550px; height: 200px; border: 1px solid #cdcdcd">
                            文件内容
                        </div>
                        <div style="float: left; width: 150px; height: 200px; border: 1px solid #cdcdcd; border-left: none;">
                            <div style="height: 35px;">
                                <input type="button" value="显示" onclick="showdoc(onepath);" style="float: left; margin: 4px 10px 0 37px;" />
                                <input type="button" value="下载" style="float: left; margin-top: 4px" />
                            </div>
                            <div style="height: 165px; overflow-y: scroll;">
                                <ul style="list-style: none">
                                    <li><span>文件名一</span><input type="hidden" value="x.doc" /></li>
                                    <li>2</li> 
                                    <li>3</li>
                                    <li>4</li>
                                    <li>5</li>
                                    <li>6</li>
                                    <li>7</li>
                                    <li>8</li>
                                    <li>9</li>
                                </ul>
                            </div>

                        </div>
                    </div>
                    <div style="width: 702px; height: 220px; border: 1px solid #cdcdcd; border-top: none;">
                        <script src="WebOffice/loadweboffice.js"></script>
                    </div>
                    <div style="width: 700px; height: 80px; border: 1px solid #cdcdcd; margin-top: 10px;">
                        <div style="float:left;">
                            审批意见！审批意见！审批意见！审批意见！
                        </div>
                        <div style="float:right;">
                            是否回执:是/否
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

