<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_bulkkaoqing.aspx.cs" Inherits="kaoqingcl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="Script/jquery-1.8.2.min.js"></script>
    <style type="text/css">
        .item{width:100%;height:30px;}
        .date{display:inline-block;float:left;}
        .ss{width:400px;float:left;margin-left:28px;}
        .ass{width:109px;float:left;}
        .asst{display:block;float:left;width:38px;}
        .asss{float:left;}


    </style>

    <script type="text/javascript">

        //通过日期控件选择一个日期 就添加一条数据 
        //点确定时 把数据div 里的所有条目通过getdates方法获取成指定格式
        //第条数据加一个删除功能

        window.onload = function ()
        {
            document.getElementById("btn").onclick = function () { send(); };
        }

        function send()
        {
            var dates = "";

            dates = getdates();

            $.ajax({
                type: "post",
                url: "AsyCenter.aspx",
                data: {
                    type: "bulkkaoqing",
                    dates:dates
                },
                success: function (data)
                {
                    if (data == "-1") {
                        alert("处理时出现异常");
                    } else {
                        alert("处理完成");
                    }
                }
            })
        }

        function getdates()
        {
            return "2016-01-12,1|2016-01-13,2";
        }
    </script>
</head>
<body>
    <div style="width:300px;height:200px;margin-bottom:30px;border:1px solid #cdcdcd">
        日期控件
    </div>
    <div style="width:500px;height:400px;border:1px solid #cdcdcd;">
        <div class="item">
            <span class="date">2016-12-1</span>
            <div class="ss">
                <div class="ass"><span class="asst">上午</span><input class="asss" type="radio" name="ss1" value="1" /></div>
                <div class="ass"><span class="asst">下午</span><input class="asss" type="radio" name="ss1" value="2" /></div>
                <div class="ass"><span class="asst">全天</span><input class="asss" type="radio" name="ss1" value="3" /></div>
            </div>
        </div>

        <div class="item">
            <span class="date">2016-12-2</span>
            <div class="ss">
                <div class="ass"><span class="asst">上午</span><input class="asss" type="radio" name="ss2" value="1" /></div>
                <div class="ass"><span class="asst">下午</span><input class="asss" type="radio" name="ss2" value="2" /></div>
                <div class="ass"><span class="asst">全天</span><input class="asss" type="radio" name="ss2" value="3" /></div>
            </div>
        </div>
    </div>
    <div>
        <input type="button" id="btn" value="确认" />
    </div>
</body>
</html>
