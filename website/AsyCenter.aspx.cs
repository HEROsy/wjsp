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

                case "addbm":
                    AddM();
                    break;

                case "getallbm":
                    GetAllBM();
                    break;

                case "deletebm":
                    DeleteBM();
                    break;

                case "deleteyh":
                    DeleteYH();
                    break;

                case "addyh":
                    AddYH();
                    break;

                case "getfyyh":
                    GetFYYH();
                    break;

                default:
                    break;
            }
        }
       

    }

    private void GetFYYH()
    {
        String partid = Request.Form["partid"];
        String pagesize = Request.Form["pagesize"];
        String pageindex=Request.Form["pageindex"];

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
                           new SqlParameter("@partid",partid)
                           };
        String sql = "SELECT  w1.id FROM oa_user w1 where u_part=@partid";
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
        int count = dt.Rows.Count;
        sql = "SELECT top (@end) w1.id,w1.name,w1.u_name FROM oa_user w1, ( SELECT TOP (@end) row_number() OVER (ORDER BY ID desc ) n, ID FROM oa_user where u_part=@partid) w2 WHERE w1.ID = w2.ID AND w2.n > @start   ORDER BY w2.n ASC ";
        dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
        String r = Tools.BiuldJson("", dt);
        if (!String.IsNullOrEmpty(r))
        {
            r = r.Insert(1, "{'" + HttpUtility.UrlEncode("count") + "':'" + count + "'},");
        }
        Response.Write(r);
        Response.End();
    }

    private void AddYH()
    {
        String name=Request.Form["yhname"];
        String partid=Request.Form["partid"];
        SqlParameter[] spr={new SqlParameter("@name",name),new SqlParameter("@u_part",partid)};
        String sql = SqlHelper.GetSQLInsert_normal("oa_user", spr);
        int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
        Response.Write(r);
        Response.End();
    }

    private void DeleteBM()
    {
        String id=Request.Form["id"];
        SqlParameter spr = new SqlParameter("@id", id);
        String sql = "delete from oa_part where id=@id";
        int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
        Response.Write(r);
        Response.End();
    }

    private void DeleteYH()
    {
        String id = Request.Form["id"];
        SqlParameter spr = new SqlParameter("@id", id);
        String sql = "delete from oa_user where id=@id";
        int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
        Response.Write(r);
        Response.End();
    }

    private void GetAllBM()
    {
        String sql = SqlHelper.GetSQLSelect_normal("", "id,part", "oa_part", null, "", "", "id desc");
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, null);
        String r = Tools.BiuldJson("", dt);
        Response.Write(r);
        Response.End();
    }

    private void AddM()
    {
        String bmname=Request.Form["bmname"];

        SqlParameter[] spr={new SqlParameter("@part",bmname)};
        String sql = SqlHelper.GetSQLInsert_normal("oa_part", spr);
        int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
        Response.Write(r);
        Response.End();
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