using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_center : System.Web.UI.Page
{
    public String NameTitle = "";
    public String json_yckq = "";
    public String json_spl = "";
    public String userid = "";

    _BLL bll = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        bll = new _BLL();
        InitNameTitle();

        InitYCKQ();

        Initspl();

    }

    private void Initspl()
    {
       userid=Session["user"].ToString().Split('|')[0];
       DataTable dt=bll.Json_spl(userid, "ing");
       json_spl = Tools.BiuldJson("", dt);
    }

    private void InitYCKQ()
    {
        String userid = Session["user"].ToString().Split('|')[0];
        SqlParameter[] spr = {new SqlParameter("@u_id",userid) };
        String sql = "select id,day,a_state,p_state,qj_a,qj_p,ar_qj_a,ar_qj_p,hl_a,hl_p from oa_kaoqing where u_id=@u_id and a_state is not null and((a_state<>0 and isnull(qj_a,'')='') or (p_state<>0 and isnull(qj_p,'')='')) order by id";
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
        json_yckq = Tools.BiuldJson("", dt);
    }

    private void InitNameTitle()
    {
        DateTime a=Convert.ToDateTime("12:00:00");
        DateTime p=Convert.ToDateTime("18:00:00");
        String sx = "";
        DateTime d = DateTime.Now;
        if (d.CompareTo(a)==-1)
        {
            sx = "上午好";
        }
        else if (d.CompareTo(p) == -1 || d.CompareTo(p) == 0 || d.CompareTo(p) == 1)
        {
            sx = "下午好";
        }

        NameTitle = Session["user"].ToString().Split('|')[1] + "," + sx;
    }
}