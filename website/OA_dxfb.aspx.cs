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
    
    public String json_bm= "";         //id,part
    public String json_user="";             //id name u_part



    protected void Page_Load(object sender, EventArgs e)
    {
        b = new _BLL();

         json_bm = jsonbm ();
         json_user = jsonuser();
        
    }


    public  string  jsonbm()
    {
        string jason ="";

        DataTable dt = b.Oapart();
        jason = Tools.BiuldJson("",dt);
        return jason;
    }

    public string jsonuser()
    {

        string jason ="";

        DataTable dt = b.Oauser();
        jason = Tools.BiuldJson("",dt);
        return jason;
    }

}