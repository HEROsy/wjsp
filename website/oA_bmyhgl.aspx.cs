using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class oA_bmyhgl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String uid = "";
        try
        {
            uid = Session["user"].ToString().Split('|')[0];
        }
        catch (Exception)
        {
            Response.Write("<script>window.parent.location.href = 'oa_login.aspx';</script>");
            Response.End();
        }
        SqlParameter[] spr = { new SqlParameter("@id", uid) };
        String sql = SqlHelper.GetSQLSelect_normal("top 1", "u_quanxian", "oa_user", spr, "=", "", "id");
        String qx = SqlHelper.GetTable(sql, CommandType.Text, spr).Rows[0]["u_quanxian"].ToString();
        if (qx.Trim().Equals("1"))
        {

        }
        else
        {
            Response.Write("<script>window.parent.location.href = 'oa_login.aspx';</script>");
            Response.End();
        }
    }

}