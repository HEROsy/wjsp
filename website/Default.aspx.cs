using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    int max = 20;
    public void Muler()
    {

        String space = " ";
       


        for (int i = 1; i < 100; i++)
        {
            // a++;

            for (int j = 1; j <= i; j++)
            {

                // b++;
                space = getSpace(i.ToString()+j.ToString()+"*="+(i*j).ToString());
                if (i==j)
                {
                    Response.Write(Convert.ToString(i) + "*" + Convert.ToString(j) + "="+ Convert.ToString(i * j)+space);
                    Response.Write("<br/>");
                }
                else
                {
                    Response.Write(Convert.ToString(i) + "*" + Convert.ToString(j) + "=" + Convert.ToString(i * j) + space);
                   // Response.Write("<br/>");
                }
            }

        }

    }

    private String getSpace(String str)
    {
        String r = "";

        int lth = str.Length;
        for (int i = 0; i < max-lth; i++)
        {
            r = r + "&nbsp";
        }

        return r;
    }
}