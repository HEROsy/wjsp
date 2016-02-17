using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_kaoqing : System.Web.UI.Page
{
    public String years = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        InitYears();
        
    }


    //查询当前用户考勤数据的年份范围（2015，2016，2017）
    private void InitYears()
    {
        String userid = Session["user"].ToString().Split('|')[0];//用户ID
        string s1 = "";
        string s2 = "";
        string s3 = "";
        string s4 = "";
        int r = 0;
        string year = "";
        ArrayList arr = new ArrayList();
        DataTable dt = null;
        DataTable dtt = null;
        //根据userid 查 oa_kaoqing 表 里不重复的day字段
        SqlParameter[] spr ={ 
                                new SqlParameter("@u_id",userid)
                            };
       
        //把值付给years
        try
        {
            string sql = "select top 1 day from oa_kaoqing where u_id=@u_id order by id asc";
            string sqll = "select top 1 day from oa_kaoqing where u_id=@u_id order by id desc";

            dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
            dtt = SqlHelper.GetTable(sqll, CommandType.Text, spr);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                s1 = dt.Rows[i]["day"].ToString();
            }
            for (int i = 0; i < dtt.Rows.Count; i++)
            {
                s2 = dtt.Rows[i]["day"].ToString();
            }


            //s1 = SqlHelper.ExecuteScalar(sql, spr).ToString();
            //s2 = SqlHelper.ExecuteScalar(sqll, spr).ToString();
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
            year="时间格式有误";
        }
       
    }
}