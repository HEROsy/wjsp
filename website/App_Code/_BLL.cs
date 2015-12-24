using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// _BLL 的摘要说明
/// </summary>
public class _BLL
{
	

    public DataTable UserLogin(String name,String password)
    {
        DataTable dt=null;

        SqlParameter[] spr={new SqlParameter("@name",name),
                            new SqlParameter("@pw",password)};
        String sql = SqlHelper.GetSQLSelect_normal("1", "id,name", "oa_kaoqing", spr, "=,=", "and", "id asc");
       
        dt = SqlHelper.GetTable(sql, CommandType.Text, spr);

        return dt;
    }

    /// <summary>
    /// 获取考勤数据
    /// </summary>
    /// <param name="StartDate">开始日期</param>
    /// <param name="EndDate">结束日期</param>
    /// <param name="UserId">用户ＩＤ</param>
    /// <returns>出错返回null</returns>
    public DataTable GetKaoQing(String StartDate,String EndDate,String UserId)
    {   
        DataTable dt = null;
        SqlParameter[] spr = {
                                  new SqlParameter("@startdate",StartDate),
                                  new SqlParameter ("@enddate",EndDate),
                                  new SqlParameter ("@userid", UserId )
                              };
        try 
	{
        string sql = SqlHelper.GetSQLSelect_normal("", "", "user",spr, ">=,<=,=", "and,and", "StartDate,EndDate,UserId");
  
            dt = SqlHelper.GetTable(sql, CommandType.Text,spr);
         
            return dt;
	}
	catch (Exception)
	{
		return null;
	}
    }

    /// <summary>
    /// 获取考勤分页数据
    /// </summary>
    /// <param name="Startdate">开始日期</param>
    /// <param name="EndDate">结束日期</param>
    /// <param name="UserId">用户ＩＤ</param>
    /// <param name="PageSize">每页数据条数</param>
    /// <param name="PageIndex">第几页</param>
    /// <returns>出错返回ＮＵＬＬ</returns>
    public DataTable GetKaoQingPage(String Startdate,String EndDate,String UserId,String PageSize,String PageIndex)
    {



        DataTable dt = null;
        SqlParameter[] spr = {
                                  new SqlParameter("@startdate",Startdate),
                                  new SqlParameter ("@enddate",EndDate),
                                  new SqlParameter ("@userid", UserId ),
                                  new SqlParameter("@pagesize",PageSize),
                                  new SqlParameter ("@pageindex",PageIndex)
                                 
                              };
        try
        {
            string sql = "SELECT TOP @pagesize *FROM oa_kaoqing WHERE id=@userid Startdate=@startdate EndDate=@enddate NOT IN( SELECT TOP  @pagesize*(@pageindex-1) id=@userid FROM oa_kaoqing ORDER BY id asc )ORDER BY id asc";


            
            dt = SqlHelper.GetTable(sql, CommandType.Text, spr);

            return dt;
                         
        }
        catch (Exception)
        {
            return null;
        }

       
    }


/// <summary>
/// 签到
/// </summary>
/// <param name="userId">用户id</param>
/// <param time="a_start_time">用户签到时间</param>
/// <returns></returns>

    private DataTable Register(string userId, string a_start_time)
    
    {
        DataTable dt = null;

        SqlParameter[] spr ={new SqlParameter("@id",userId),
                            new SqlParameter("@time", a_start_time)};
        String sql = SqlHelper.GetSQLSelect_normal("", "id,day=null", "oa_kaoqing", spr, "=,=", "and", "id asc");

        dt = SqlHelper.GetTable(sql, CommandType.Text,spr);

        return dt;

           }

  
    public  void RegisterA(string userId, string a_start_time,string a_end_time, string day )
     
    {
        try
        {
            SqlParameter[]spr ={new SqlParameter("@id",userId),
                            new SqlParameter("@time",a_start_time)};

            SqlParameter[]set_spr ={new SqlParameter("@id",userId),
                            new SqlParameter("@time",a_end_time)};
            
            
            SqlParameter[]where_spr ={new SqlParameter("@id",userId),
                            new SqlParameter(null,day)};

            DataTable r = Register(userId, a_start_time);


            if (r.Rows.Count <= 0 )
            {
                String sql = SqlHelper.GetSQLInsert_normal("oa_kaoqing", spr);

                SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
            }
            else
            {
                String sql = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", set_spr, where_spr, "=,=,=", "and");
                          
                              
                    

                SqlHelper.ExcoutSQL(sql, CommandType.Text,spr);
            }
        }
        catch (Exception)
        {
            
            throw;
        }

       

    }

    public void RegisterP(string userId, string p_start_time, string p_end_time, string day)
    {
        try
        {
            SqlParameter[] spr ={new SqlParameter("@id",userId),
                            new SqlParameter("@time",p_start_time)};

            SqlParameter[] set_spr ={new SqlParameter("@id",userId),
                            new SqlParameter("@time",p_end_time)};


            SqlParameter[] where_spr ={new SqlParameter("@id",userId),
                            new SqlParameter(null,day)};

            DataTable r = Register(userId, p_start_time);

            if (r.Rows.Count <= 0 )
            {
                String sql = SqlHelper.GetSQLInsert_normal("oa_kaoqing", spr);

                SqlHelper.ExcoutSQL(sql, CommandType.Text,spr);
            }
            else
            {

                String sql = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", set_spr, where_spr, "=,=,=", "and");
                  
               
               
                SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);


            }
        }
        catch (Exception)
        {
            
            throw;
        }

        


    }

    /// <summary>
    /// 结算
    /// </summary>
    /// <param name="userId"></param>
    /// <param name="day"></param>
    /// <returns></returns>

    public bool JieSuan(string userId,  string day )
    {
        DateTime aas = new DateTime(2015, 1, 1, 9, 0, 0);
        DateTime ad = new DateTime(2015, 1, 1, 12, 0, 0);
        DateTime ps = new DateTime(2015, 1, 1, 14, 0, 0);
        DateTime pd = new DateTime(2015, 1, 1, 18, 0, 0);


        try
        {
            SqlParameter[] spr ={new SqlParameter("@id",userId),
                            new SqlParameter("@day",day)};

            string sqlaa = SqlHelper.GetSQLSelect_normal("", "a_start_time", "oa_kaoqing", spr, "=,=", "and", "");
            string sqlad = SqlHelper.GetSQLSelect_normal("", "a_end_time", "oa_kaoqing", spr, "=,=", "and", "");
            string sqlps = SqlHelper.GetSQLSelect_normal("", "p_start_time", "oa_kaoqing", spr, "=,=", "and", "");
            string sqlpd = SqlHelper.GetSQLSelect_normal("", "p_end_time", "oa_kaoqing", spr, "=,=", "and", "");

            DateTime a_starttime = (DateTime)SqlHelper.ExecuteScalar(sqlaa, CommandType.Text);
            DateTime p_starttime = (DateTime)SqlHelper.ExecuteScalar(sqlps, CommandType.Text);
            DateTime a_endtime = (DateTime)SqlHelper.ExecuteScalar(sqlad, CommandType.Text);
            DateTime p_endtime = (DateTime)SqlHelper.ExecuteScalar(sqlpd, CommandType.Text);

            TimeSpan cspan = a_starttime - aas;
            TimeSpan cspan1 = p_starttime - ps;
            TimeSpan zspan = a_endtime - ad;
            TimeSpan zspan1 = p_endtime - pd;

            if (cspan.Hours <= 0 || cspan1.Hours <= 0)
            {
                string sql = "update oakaoqing set u_cd = u_cd+1 where u_id = @id and day =@day";
                SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);

            }



            else if (zspan.Hours > 0 || zspan1.Hours > 0)
            {
                string sql = "update oakaoqing set u_zt = u_zt+1 where u_id = @id and day =@day";
                SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
            }
            return true;

        }
        catch (Exception)
        {
            
           return false;
        }
       
       
     
    }

     public DataTable JieSuant (string userId,  string day )
    
     {

          DataTable dt = null;

        SqlParameter[] spr ={new SqlParameter("@id",userId),
                            new SqlParameter("@time", day)};

        String sql = SqlHelper.GetSQLSelect_normal("", " u_cd, u_zt", "oa_kaoqing", spr, "=,=", "and", "id asc");

        dt = SqlHelper.GetTable(sql, CommandType.Text,spr);

        return dt;
         
    }
  
    public  DataTable  Json_bm()
    
    
    {
         DataTable dt = null;

         String sql = SqlHelper.GetSQLSelect_normal("*", "", "oa_part", null, "", "", "id asc");

        dt = SqlHelper.GetTable(sql, CommandType.Text,null);

        return dt; 

     }

    public  DataTable  Json_user()
   
    {
        DataTable dt = null;

        String sql = SqlHelper.GetSQLSelect_normal("", "id,name,u_part", "oa_user", null, "", "", "id asc");

        dt = SqlHelper.GetTable(sql, CommandType.Text, null);

        return dt; 
    }
  
    
    
    
    //在表oa_ydylc 里添加一条项目 u_id=userid ,spl_name=splname,spl_content=contents, spl_content_txt=contents_txt 返回值为 ‘受影响的行数’

    public int Addspll(string userid, string contents, string splname, string contents_txt)
   
  {  

      int r = 0;

      SqlParameter[] spr ={new SqlParameter("@userid",userid),
                         new SqlParameter("@contents",contents),
                      new SqlParameter("@splname", splname),
                           new SqlParameter("@contents_txt", contents_txt)};

      string sql = SqlHelper.GetSQLInsert_normal("oa_ydylc", spr);

      r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);

      return r;

    }
}