using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class kaoqingCL : System.Web.UI.Page
{
    public String datetime = "";
    public String sw = "";
    public String xw = "";
    public String aop = "";

    public String bm = "";
    public String users = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        String id=Request.QueryString["id"];
        String _aop = Request.QueryString["aop"]; if (_aop.Equals("sw")) { aop = "上午"; } else if (_aop.Equals("xw")) { aop = "下午"; } else { aop = "未获取"; }

        SqlParameter[] spr = {new SqlParameter("@id",id) };
        String sql = SqlHelper.GetSQLSelect_normal("top 1", "a_start_time,a_end_time,p_start_time,p_end_time,day", "oa_kaoqing", spr, "=", "", "id");
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);

        DataRow r = dt.Rows[0];

        datetime = r["day"].ToString();
        String aas= r["a_start_time"].ToString();
        String pps= r["p_start_time"].ToString();
        String aae=r["a_end_time"].ToString();
        String ppe=r["p_end_time"].ToString();
        if (String.IsNullOrEmpty(aas))
        {
            aas = "未签到";
        }
        if (String.IsNullOrEmpty(aae))
        {
            aae = "未签退";
        }
        if (String.IsNullOrEmpty(pps))
        {
            pps = "未签到";
        }
        if (String.IsNullOrEmpty(ppe))
        {
            ppe = "未签退";
        }

        sw = aas + " - " + aae;
        xw = pps + " - " + ppe;


        sql = SqlHelper.GetSQLSelect_normal("", "id,part", "oa_part", null, "", "", "id");
        DataTable dt_part = SqlHelper.GetTable(sql, CommandType.Text, null);
        sql = SqlHelper.GetSQLSelect_normal("", "id,name,u_part", "oa_user", null, "", "", "id");
        DataTable dt_user = SqlHelper.GetTable(sql, CommandType.Text, null);

        bm = Tools.BiuldJson("", dt_part);
        users = Tools.BiuldJson("", dt_user);
    }
}