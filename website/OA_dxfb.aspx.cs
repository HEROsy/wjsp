using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_dxfb : System.Web.UI.Page
{

    _BLL b = null; 
    
    public String json_bm= "";         //返回id,part
    public String json_user="";             //返回id name u_part
    public String userid = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        b = new _BLL();
        try
        {
            userid = Session["user"].ToString().Split('|')[0];
        }
        catch (Exception)
        {
            Response.Redirect("OA_login.aspx");
        }
         json_bm = jsonbm ();
         json_user = jsonuser(userid);
        
    }


    public  string  jsonbm()
    {
        string jason ="";

        DataTable dt = b.Oapart();
        jason = Tools.BiuldJson("",dt);
        return jason;
    }

    public string jsonuser(string userid )//返回自己以外的所有用户
    {
        string jason ="";

        DataTable dt = b.Oauser(userid);
        jason = Tools.BiuldJson("",dt);
        return jason;
    }

}