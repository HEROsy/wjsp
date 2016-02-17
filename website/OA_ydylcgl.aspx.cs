using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_ydylcgl : System.Web.UI.Page
{
    public String json_lc = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        String uid = "";

        try
        {
            uid = Session["user"].ToString().Split('|')[0];
        }
        catch (Exception)
        {
            Response.Redirect("OA_login.aspx");

        }

        json_lc = GetUserLc(uid);
    }

    private string GetUserLc(string uid)//返回指定用户的流程数据   表oa_ydylc  [u_id]=uid  返回[id][spl_name][spl_contents_txt] 
    {
        return "";
    }
}