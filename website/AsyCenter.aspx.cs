using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AsyCenter : System.Web.UI.Page
{
    _BLL bll = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        bll = new _BLL();

        String tag = Request.Form["type"];
        if (!String.IsNullOrEmpty(tag))
        {
            switch (tag)
            {
                case "lg":
                    UserLogin();
                    break;

                case "kaoqingpage":
                    KaoQingPage();
                    break;

                default:
                    break;
            }
        }
       

    }

    private void KaoQingPage()
    {
        String year = Request.Form["year"];
        String moth=Request.Form["month"];
        String pagesize = Request.Form["pagesize"];
        String pageindex=Request.Form["pageindex"];

        DateTime stime = Convert.ToDateTime(year + "-" + moth + "-01");
        DateTime etime = stime.AddMonths(1);

        int startindex = 0;
        int endindex = 0;
        try
        {
            startindex = (Convert.ToInt32(pageindex) - 1) * Convert.ToInt32(pagesize);
            endindex = Convert.ToInt32(pageindex) * Convert.ToInt32(pagesize);
        }
        catch (Exception)
        {
            Response.Write("error arg");
            Response.End();
        }

        SqlParameter[] spr ={
                           new SqlParameter("@end",endindex),
                           new SqlParameter("@start",startindex),
                           new SqlParameter("@stime",stime),
                           new SqlParameter("@etime",etime)
                           };
        String sql = "SELECT  w1.id FROM oa_kaoqing w1 where @stime<=day and day<@etime";
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
        int count = dt.Rows.Count;
        sql = "SELECT top (@end) w1.id,w1.a_state,w1.p_state,w1.day FROM oa_kaoqing w1, ( SELECT TOP (@end) row_number() OVER (ORDER BY ID asc ) n, ID FROM oa_kaoqing) w2 WHERE w1.ID = w2.ID AND w2.n > @start and   @stime<=day and day<@etime  ORDER BY w2.n ASC ";
        dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
        String r = Tools.BiuldJson("",dt);
        if (!String.IsNullOrEmpty(r))
	    {
            r = r.Insert(1, "{'"+HttpUtility.UrlEncode("count")+"':'" + count + "'},");
        }
        Response.Write(r);
        Response.End();
    }

    //
    public void UserLogin()
    {
        String r = "用户名或密码错误！";
        String UserName = Request.Form["name"];
        String Password=Request.Form["password"];
        if (String.IsNullOrEmpty(UserName)||String.IsNullOrEmpty(Password))
        {
            Response.Write(r);
            Response.End();
        }
        DataTable dt = bll.UserLogin(UserName, Password);
        if (dt != null)
        {
            if (dt.Rows.Count != 0)
            {
                Session["user"] = dt.Rows[0]["id"].ToString();
                r = "ok";
            }
            Response.Write(r);
            Response.End();
        }
      
    }
}