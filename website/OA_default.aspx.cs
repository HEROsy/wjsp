using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_default : System.Web.UI.Page
{
    public String un = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        object oun=Session["user"];
        if (oun == null)
        {
            Response.Redirect("oa_login.aspx");
            Response.End();
        }
        else {
            un = oun.ToString();
        }
    }
}