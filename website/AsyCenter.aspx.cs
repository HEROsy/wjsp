using System;
using System.Collections.Generic;
using System.Data;
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
                    UserLogin1();
                    break;

                default:
                    break;
            }
        }
       

    }

    private void UserLogin1()
    {
        
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