using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_lsspl : System.Web.UI.Page
{
    /*json_lc  返回字段id,titles  表oa_ls_spl  where sender_id=1 or splc_datas包含1   id desc
     * 
     * 
     */
    public String json_lc = "";
    public int totalnum = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        String userid = "";
        try
        {
            userid = Session["user"].ToString().Split('|')[0];
        }
        catch (Exception)
        {
            Response.Redirect("login.aspx");
        }

        json_lc =Tools.BiuldJson("",new _BLL().Json_spl(userid, "ed"));
        totalnum = TotalN(userid);
    }


    private int TotalN(string userid)
    {
        int r = 0;
        DataTable dt = null;
        SqlParameter[] spr = { new SqlParameter("@sender_id", userid) };
        String sql = "select id from oa_ls_spl where sender_id=@sender_id or splc_datas like '%" + userid + "%'";
        dt = SqlHelper.GetTable(sql, CommandType.Text,spr);
        r = dt.Rows.Count;
        return r;

    }
}