using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_kaoqing_all : System.Web.UI.Page
{
    public String years = "";
    public String json_users = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        InitYears();
        InitUsers();
    }

    private void InitUsers()
    {
        //查询oa_user表里所有用户 反回字段 id name
        //包装成json 付给json_users
    }

    private void InitYears()
    {
        //oa_kaoqing 表里 所有的不重复的年份(如：2015，2016，2017)
        //把值付给years
    }
}