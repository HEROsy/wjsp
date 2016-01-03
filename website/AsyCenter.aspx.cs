using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
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
                case "userlogin":
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

                case "saveimgb64":
                    SaveImgB64();
                    break;

                case "resetuserpasswor":
                    ResetUserPassword();
                    break;
              
                case "addspl":
                    Addspl();
                    break;

              
              

                default:
                    break;
            }
        }


    }

    private void ResetUserPassword()
    {
        String id = Request.Form["id"];
        String newpasseord = "666666";
        String sql = "update oa_user set u_password=" + newpasseord + " where id=" + id;
        int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, null);
        Response.Write(r);
        Response.End();
    }

    private void SaveImgB64()
    {
        String id = Request.Form["id"];
        String data = Request.Form["b64"];
        SqlParameter[] set_spr = { new SqlParameter("@imgbase64", data) };
        SqlParameter[] where_spr = { new SqlParameter("@id", id) };
        String sql = SqlHelper.GetSQLUpdate_normal("oa_user", set_spr, where_spr, "=", "");
        int r = SqlHelper.ExcoutSQL_2Parmter(sql, CommandType.Text, set_spr, where_spr);
        Response.Write(r);
        Response.End();
    }

    private void GetFYYH()
    {
        String partid = Request.Form["partid"];
        String pagesize = Request.Form["pagesize"];
        String pageindex = Request.Form["pageindex"];

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
        String name = Request.Form["yhname"];
        String partid = Request.Form["partid"];
        SqlParameter[] spr = { new SqlParameter("@name", name), new SqlParameter("@u_part", partid) };
        String sql = SqlHelper.GetSQLInsert_normal("oa_user", spr);
        int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
        Response.Write(r);
        Response.End();
    }

    private void DeleteBM()
    {
        String id = Request.Form["id"];
        String sql = "select id from oa_user where u_part=" + id;
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, null);
        if (dt != null)
        {
            if (dt.Rows.Count > 0)
            {
                Response.Write("no:该部门下存在用户信息，如果想删除该部门请先删除相关用户，删除失败!");
                Response.End();
            }
        }
        SqlParameter spr = new SqlParameter("@id", id);
        sql = "delete from oa_part where id=@id";
        int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
        Response.Write(r + ":");
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
        String bmname = Request.Form["bmname"];

        SqlParameter[] spr = { new SqlParameter("@part", bmname) };
        String sql = SqlHelper.GetSQLInsert_normal("oa_part", spr);
        int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
        Response.Write(r);
        Response.End();
    }

    private void KaoQingPage()
    {
        String year = Request.Form["year"];
        String moth = Request.Form["month"];
        String pagesize = Request.Form["pagesize"];
        String pageindex = Request.Form["pageindex"];

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
        String r = Tools.BiuldJson("", dt);
        if (!String.IsNullOrEmpty(r))
        {
            r = r.Insert(1, "{'" + HttpUtility.UrlEncode("count") + "':'" + count + "'},");
        }
        Response.Write(r);
        Response.End();
    }
    //
    public void UserLogin()
    {
        String r = "用户名或密码错误！";
        String UserName = Request.Form["username"];
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

    //签到
    public void QianDao()
    {
        string id = Request.Form["ID"];

        DateTime t;
        t = DateTime.Now;
        string p = t.ToString();

        DataTable dt = null;
        SqlParameter[] spr = { new SqlParameter("@id", id) };
        String sql = SqlHelper.GetSQLSelect_normal("", "day=null,p_start_time=null", "oa_kaoqing", spr, "=", "", "id asc");
        dt = SqlHelper.GetTable(sql, CommandType.Text, null);


        if (dt.Rows.Count > 0)
        {

            bll.RegisterA(id, p, null, null);

        }

        else if (dt.Rows.Count <= 0)
        {
            bll.RegisterP(id, p, null, null);
        }


    }
    //结算
     public string JieSuan()
    {
        bool r = false;
        DataTable dt = null;
        string jason = "";

         string id = Request.Form["ID"];
         string day = Request.Form ["Day"];

           r =bll.JieSuan(id, day);
          
         if (r==true)
         {
             dt = bll.JieSuant(id, day);

            jason = Tools.BiuldJson("", dt);
             
         }
            
         return jason;
       
   }

   
    
    
    private void  Addspl ()
     {
       int r = 0;

      string Userid = Request.Form["userid"];
      string Contents = Request.Form["contents"];
      string Splname = Request.Form["splname"];
      string Contents_txt = Request.Form["contents_txt"];

      r = bll.Addspll(Userid, Contents, Splname, Contents_txt);

      Response.Write(r);
      Response.End();

   }


       

    }


    

