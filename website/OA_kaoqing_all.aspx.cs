using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_kaoqing_all : System.Web.UI.Page
{
    public String years = "";
    public String json_users = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        InitYears();
       // InitUsers();

        Response.Write(years);
    }

    private void InitUsers()
    {       
        //查询oa_user表里所有用户 反回字段 id name
        //包装成json 付给json_users
        DataTable dt = null;
        string sql = "select id, name from oa_user";
        dt = SqlHelper.GetTable(sql,CommandType.Text,null);
        json_users = Tools.BiuldJson("",dt);
    }

    private void InitYears()
    {
        //oa_kaoqing 表里 所有的不重复的年份(如：2015，2016，2017)
        //把值付给years
        string s1 = "";
        string s2 = "";
        string s3 = "";
        string s4 = "";
        int r = 0;
        string year = "";
        ArrayList arr = new ArrayList();
        DataTable dt = null;
        DataTable dtt = null;
        try
        {
            string sql = "select top 1 day from oa_kaoqing order by id asc";
            string sqll = "select top 1 day from oa_kaoqing order by id desc";
            dt = SqlHelper.GetTable(sql, CommandType.Text, null);
            dtt = SqlHelper.GetTable(sqll, CommandType.Text, null);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                s1 = dt.Rows[i]["day"].ToString();
            }
            for (int i = 0; i < dtt.Rows.Count; i++)
            {
                s2 = dtt.Rows[i]["day"].ToString();
            }
            //s1 = SqlHelper.ExecuteScalar(sql, null).ToString();
            // s2 = SqlHelper.ExecuteScalar(sqll, null).ToString();
            s3 = s1.Substring(0, 4);
            s4 = s2.Substring(0, 4);
            int st = Convert.ToInt32(s3);
            int sf = Convert.ToInt32(s4);
            r = Math.Abs(st - sf);
            if (st < sf)
            {
                for (int i = 0; i <= r; i++)
                {

                    arr.Add(st + i);
                }
            }
            else
            {
                for (int i = 0; i <= r; i++)
                {
                    arr.Add(sf + i);
                }
            }

            foreach (var item in arr)
            {
                year += item.ToString() + ",";
            }

            years = year.Substring(0, year.LastIndexOf(','));

        }
        catch (Exception)
        {
            Response.Write("时间格式有误");
            Response.End();
        }
     
    }
}