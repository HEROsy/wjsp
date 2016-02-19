<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OA_bulkkaoqing.aspx.cs" Inherits="kaoqingcl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="Script/jquery-1.8.2.min.js"></script>
    <script src="Scripts/bootstrap-datetimepicker.js"></script>
    <script src="Scripts/bootstrap-datetimepicker.min.js"></script>
    <script src="Scripts/bootstrap-datetimepicker.fr.js"></script>
    <link href="Style/bootstrap-datetimepicker.css" rel="stylesheet" />
    <link href="Style/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <style type="text/css">
        .item{width:100%;height:30px;}
        .date{display:inline-block;float:left;}
        .ss{width:380px;float:left;margin-left:28px;}
        .ass{width:109px;float:left;}
        .asst{display:block;float:left;width:38px;}
        .asss{float:left;}


    </style>

    <script type="text/javascript">

        //通过日期控件选择一个日期 就添加一条数据 
        //点确定时 把数据div 里的所有条目通过getdates方法获取成指定格式
        //每条数据加一个删除功能

        window.onload = function ()
        {
            document.getElementById("btn").onclick = function () { send(); };


            $(".form_datetime").datetimepicker({
                format: "yyyy-mm-dd",
            });


            $('.form_datetime').datetimepicker().on('changeDate', function (ev) {
                var rq = document.getElementById("time_1").value;
                settime(rq);
            });

        }
        var sj = new Array();
        var js = 0;

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
            var da = "";
            var names = new Array();
            var len = document.getElementById("time_2").getElementsByTagName("div");
            var len = len.length / 5;
            var aa=document.get
            var inputs = document.getElementById("time_2").getElementsByTagName("input");
            var dates = "";
            dates = huoqu();
            dates = dates.split(",");
            for (var i = 0; i < inputs.length; i++) {
                var y = "";
                if (i == 0) {
                    names.push(inputs[i].name);
                }
                y = names.indexOf(inputs[i].name);
                if (y == -1) {
                    names.push(inputs[i].name);
                }
            }
            for (var i = 0; i < len; i++) {
                var xz = $("input[name='" + names[i] + "']:checked").val();
                if (i==0) {
                    da = da + dates[i] + "," + xz;
                } else {
                    da = da + "|" + dates[i] + "," + xz;
                }
            }
            return da;
        }

        function settime(times) {
            if (js == 0) {
                var liebiao = document.getElementById("time_2");
                var html = document.createElement("div");
                html.className = "item";
                html.id = "ss" + js;
                html.innerHTML = "<span class='date'>" + times + "</span> <div class='ss'><div class='ass'><span class='asst'>上午" +
                    "</span><input class='asssa' type='radio' name='" + js + "' value='1'  /></div>" +
                    "<div class='ass'><span class='asst'>下午</span><input class='asss' type='radio' name='" + js + "' value='2'  /></div>" +
                    "<div class='ass'><span class='asst'>全天</span><input class='asss' type='radio' name='" + js + "' value='3'checked='checked'  /></div>" +
                    "<input type='button' name='" + js + "' value='删除' onclick='del(this.name)' /> </div>";
                liebiao.appendChild(html);
                
                js = js + 1;
                
                sj.push(times);

                return;
            }
            var dates = "";
            dates = huoqu();
            dates = dates.split(",");
            var j = 0;
            for (var i = 0; i < dates.length; i++) {
                if (sj[i] == times) {
                    alert("请不要重复选取同一天！")
                    j = j + 1;
                }
            }
            if (j == 0) {
                var liebiao = document.getElementById("time_2");
                var html = document.createElement("div");
                html.className = "item";
                html.id = "ss" + js;
                html.innerHTML = "<span class='date'>" + times + "</span> <div class='ss'><div class='ass'><span class='asst'>上午" +
                    "</span><input class='asssa' type='radio' name='" + js + "' value='1'  /></div>" +
                    "<div class='ass'><span class='asst'>下午</span><input class='asss' type='radio' name='" + js + "' value='2' /></div>" +
                    "<div class='ass'><span class='asst'>全天</span><input class='asss' type='radio' name='" + js + "' value='3'checked='checked'  /></div>" +
                    "<input type='button' name='" + js + "' value='删除' onclick='del(this.name)' /></div>";
                liebiao.appendChild(html);

                js = js + 1;

                sj.push(times);

            }
        }

        function del(_id) {
            var a = document.getElementById("ss" + _id);
            a.parentNode.removeChild(a);
        }

        function huoqu() {
            var len = document.getElementById("time_2").getElementsByTagName("span");
            var dates = "";
            for (var i = 0; i < len.length;) {
                if (dates=="") {
                    dates = dates + len[i].innerHTML;
                } else {
                    dates = dates + "," + len[i].innerHTML;
                }
                i = i + 4;
            }
            return dates;
        }
    </script>
</head>
<body>
        <div style="width:300px;height:210px;margin-bottom:30px;border:1px solid #cdcdcd"  >
            <div class="input-append date form_datetime">
                <input type="hidden" value="" id="time_1"  />
                <span class="add-on"><i class="icon-remove"></i></span>
                <span class="add-on"><i class="icon-th"></i></span>
                日期控件
            </div>
        </div>
    <div style="width:500px;height:400px;border:1px solid #cdcdcd;" id="time_2">
    </div>
    <div>
        <input type="button" id="btn" value="确认" onclick="btnvalue()" />
    </div>
</body>
</html>
