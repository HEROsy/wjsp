using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_dqspl : System.Web.UI.Page
{
    _BLL b = null;
    /*json_lc  返回字段id,titles  表oa_dq_spl  where sender_id=1 or splc_datas包含1   id desc
     * 
     * 
     */

    public string json_lc = "";
    public String userid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        
        try
        {
            userid = Session["user"].ToString().Split('|')[0];
        }
        catch (Exception)
        {
            Response.Redirect("login.aspx");
        }
        b = new _BLL();

        json_lc = Jsonllcc(userid,"1");
       
 }

    private string Jsonllcc(string sender_id, string splc_datas)
    {

        string jason = "";

        DataTable dt = b.Json_spl(sender_id,"ing");
      
        jason = Tools.BiuldJson("", dt);
        return jason;


    }


}