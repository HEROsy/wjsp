using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_kaoqing : System.Web.UI.Page
{
    public String years = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        InitYears();
    }


    //查询当前用户考勤数据的年份范围（2015，2016，2017）
    private void InitYears()
    {
       // String userid = Session["user"].ToString().Split('|')[0];//用户ID

        //根据userid 查 oa_kaoqing 表 里不重复的day字段


        //把值付给years
    }
}