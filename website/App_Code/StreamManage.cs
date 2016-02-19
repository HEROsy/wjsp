using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// StreamManage 的摘要说明
/// </summary>
public static class StreamManage
{
	
    /// <summary>
    /// 
    /// </summary>
    /// <param name="splid"></param>
    /// <returns>返回下一个人的ＩＤ 如果没有返回空</returns>
    public static String SetNextID(String splid,String userid)
    {
        String nowid = "";
        String newid = "";
        String[] datas =null;
        String spl_type = "";
      //get nowid
        
        SqlParameter[] spr = {new SqlParameter("@id",splid) };
        String sql = SqlHelper.GetSQLSelect_normal("top 1", "splc_datas,next_id,spl_type", "oa_dq_spl", spr, "=", "", "id asc");
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
        nowid = dt.Rows[0]["next_id"].ToString();
        spl_type = dt.Rows[0]["spl_type"].ToString();

        //get newid
        String str="";
        if (spl_type.Equals("1"))
        {
            str=dt.Rows[0]["splc_datas"].ToString();
            if (str.Contains("|"))
	        {
		            datas = dt.Rows[0]["splc_datas"].ToString().Split('|');
	        }else
            {
            datas=new String[]{str};
            }
            
            String a = "";
            int ii = -1;
            for (int i = 0; i < datas.Length; i++)
            {
                a = datas[i].Split(',')[1];
                if (a.Equals(nowid))
                {
                    if (i + 1 == datas.Length)
                    {
                        return "";
                    }
                    else
                    {
                        ii = i + 1;
                        break;
                    }
                }
            }

            //update id
            newid = datas[ii].Split(',')[1];
            SqlParameter[] spr1 = { new SqlParameter("@next_id", newid) };
            SqlParameter[] spr2 = { new SqlParameter("@id", splid) };
            sql = SqlHelper.GetSQLUpdate_normal("oa_dq_spl", spr1, spr2, "=", "");
            SqlHelper.ExcoutSQL_2Parmter(sql, CommandType.Text, spr1, spr2);
            return newid;

        }
        else if (spl_type.Equals("0"))
        {
            str=dt.Rows[0]["next_id"].ToString();
            if (str.Contains(","))
        	{
		    datas=str.Split(',');
            }else
            {
            datas=new String[]{str};
            }
            ArrayList arr_datas=new ArrayList(datas);
            String a = "";
            int ii = -1;
            for (int i = 0; i < arr_datas.Count; i++)
            {
                a = arr_datas[i].ToString();
                if (userid.Equals(a))
                {
                    ii = i;
                    break;
                }
            }
            arr_datas.RemoveAt(ii);
            foreach (String item in arr_datas)
            {
                newid = newid + item + ",";
            }
            
            if (String.IsNullOrEmpty(newid))
            {
                return "";
            }
            else
            {
                newid = newid.Substring(0,newid.LastIndexOf(","));
                SqlParameter[] spr1 = { new SqlParameter("@next_id", newid) };
                SqlParameter[] spr2 = { new SqlParameter("@id", splid) };
                sql = SqlHelper.GetSQLUpdate_normal("oa_dq_spl", spr1, spr2, "=", "");
                SqlHelper.ExcoutSQL_2Parmter(sql, CommandType.Text, spr1, spr2);
                return "1";
            }
           
            
        }
        else
        {
            return "err";
        }

        

        
    }

    public static string[] GetTZIDs()
    {
        String[] r = null;

        String sql = SqlHelper.GetSQLSelect_normal("", "next_id", "oa_dq_spl", null, "", "", "id asc");
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, null);
        int c = dt.Rows.Count;
        r = new String[c];
        for (int i = 0; i < c; i++)
        {
            r[i] = dt.Rows[i]["next_id"].ToString();
        }
        return r;
    }

    public static Boolean TryGetTZIDs(String id)
    {
        SqlParameter[] spr = { new SqlParameter("@next_id",id)};
        String sql = "select id from oa_dq_spl where next_id=@next_id or next_id like '%"+id+"%'";// SqlHelper.GetSQLSelect_normal("top 1", "id", "oa_dq_spl", spr, "=", "", "id asc");
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
        if (dt.Rows.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }

       
    }


    public static string InitNextId_Normal(string lcid)
    {
        String newid = "";
        String[] datas = null;
        try
        {
            SqlParameter[] spr = { new SqlParameter("@id", lcid) };
            String sql = SqlHelper.GetSQLSelect_normal("top 1", "splc_datas", "oa_dq_spl", spr, "=", "", "id asc");
            DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);

            //get firstid
            String splcdata = dt.Rows[0]["splc_datas"].ToString();
            if (splcdata.Contains("|"))
            {
                datas = splcdata.Split('|');
                newid = datas[0].Split(',')[1];
            }
            else
            {
                newid = splcdata.Split(',')[1];
            }

            //update id
            SqlParameter[] spr1 = { new SqlParameter("@next_id", newid) };
            SqlParameter[] spr2 = { new SqlParameter("@id", lcid) };
            sql = SqlHelper.GetSQLUpdate_normal("oa_dq_spl", spr1, spr2, "=", "");
            SqlHelper.ExcoutSQL_2Parmter(sql, CommandType.Text, spr1, spr2);
            return newid;
        }
        catch (Exception)
        {
            return null;
        }

    }

    public static string InitNextId_all(string lcid)
    {
        String newid = "";
        String[] datas = null;
        try
        {
            SqlParameter[] spr = { new SqlParameter("@id", lcid) };
            String sql = SqlHelper.GetSQLSelect_normal("top 1", "splc_datas", "oa_dq_spl", spr, "=", "", "id asc");
            DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);

            //get firstid
            String splcdata = dt.Rows[0]["splc_datas"].ToString();
            if (splcdata.Contains("|"))
            {
                datas = splcdata.Split('|');
                foreach (String item in datas)
                {
                    newid =newid+item.Split(',')[1]+",";
                }
            }
            else
            {
                newid = splcdata.Split(',')[1];
            }
            if (newid.Contains(','))
            {
                newid = newid.Substring(0, newid.LastIndexOf(","));
            }

            //update id
            SqlParameter[] spr1 = { new SqlParameter("@next_id", newid) };
            SqlParameter[] spr2 = { new SqlParameter("@id", lcid) };
            sql = SqlHelper.GetSQLUpdate_normal("oa_dq_spl", spr1, spr2, "=", "");
            SqlHelper.ExcoutSQL_2Parmter(sql, CommandType.Text, spr1, spr2);
            return newid;
        }
        catch (Exception)
        {
            return null;
        }

    }
}