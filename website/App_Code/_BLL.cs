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

    //public bool JieSuan(string userId,  string day )
    //{
    //    DateTime aas = new DateTime(2015, 1, 1, 9, 0, 0);
    //    DateTime ad = new DateTime(2015, 1, 1, 12, 0, 0);
    //    DateTime ps = new DateTime(2015, 1, 1, 14, 0, 0);
    //    DateTime pd = new DateTime(2015, 1, 1, 18, 0, 0);


    //    try
    //    {
    //        SqlParameter[] spr ={new SqlParameter("@id",userId),
    //                        new SqlParameter("@day",day)};

    //        string sqlaa = SqlHelper.GetSQLSelect_normal("", "a_start_time", "oa_kaoqing", spr, "=,=", "and", "");
    //        string sqlad = SqlHelper.GetSQLSelect_normal("", "a_end_time", "oa_kaoqing", spr, "=,=", "and", "");
    //        string sqlps = SqlHelper.GetSQLSelect_normal("", "p_start_time", "oa_kaoqing", spr, "=,=", "and", "");
    //        string sqlpd = SqlHelper.GetSQLSelect_normal("", "p_end_time", "oa_kaoqing", spr, "=,=", "and", "");

    //        DateTime a_starttime = (DateTime)SqlHelper.ExecuteScalar(sqlaa, CommandType.Text);
    //        DateTime p_starttime = (DateTime)SqlHelper.ExecuteScalar(sqlps, CommandType.Text);
    //        DateTime a_endtime = (DateTime)SqlHelper.ExecuteScalar(sqlad, CommandType.Text);
    //        DateTime p_endtime = (DateTime)SqlHelper.ExecuteScalar(sqlpd, CommandType.Text);

    //        TimeSpan cspan = a_starttime - aas;
    //        TimeSpan cspan1 = p_starttime - ps;
    //        TimeSpan zspan = a_endtime - ad;
    //        TimeSpan zspan1 = p_endtime - pd;

    //        if (cspan.Hours <= 0 || cspan1.Hours <= 0)
    //        {
    //            string sql = "update oakaoqing set u_cd = u_cd+1 where u_id = @id and day =@day";
    //            SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);

    //        }



    //        else if (zspan.Hours > 0 || zspan1.Hours > 0)
    //        {
    //            string sql = "update oakaoqing set u_zt = u_zt+1 where u_id = @id and day =@day";
    //            SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
    //        }
    //        return true;

    //    }
    //    catch (Exception)
    //    {
            
    //       return false;
    //    }
       
       
     
    //}

     public DataTable JieSuant (string userId,  string day )
    
     {

          DataTable dt = null;

        SqlParameter[] spr ={new SqlParameter("@id",userId),
                            new SqlParameter("@time", day)};

        String sql = SqlHelper.GetSQLSelect_normal("", " u_cd, u_zt", "oa_kaoqing", spr, "=,=", "and", "id asc");

        dt = SqlHelper.GetTable(sql, CommandType.Text,spr);

        return dt;
         
    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>



  
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
   
    
    
    
    //json_lc   表 oa_ydylc  返回值 id,spl_name,spl_content_txt   where  u_id=1   id desc

    public DataTable Jsonlcc(String u_id)
    {
        

        DataTable dt = null;


        SqlParameter[] spr = { new SqlParameter("@u_id", u_id) };

        String sql = SqlHelper.GetSQLSelect_normal("","id,spl_name,spl_content_txt", "oa_ydylc", spr, "=", "","id desc");

        dt = SqlHelper.GetTable(sql, CommandType.Text, spr);

        return dt;
    }

    //json_lc  返回字段id,titles  表oa_dq_spl  where sender_id=1 or splc_datas包含1   id desc
   
    public DataTable Jsonllc(string sender_id,string splc_datas )
    {


        DataTable dt = null;


        SqlParameter[] spr = { 
                                 new SqlParameter("@sender_id", sender_id),
                                new SqlParameter("@splc_datas", splc_datas)
                            
                             };

       String sql = SqlHelper.GetSQLSelect_normal("", "id,titles", "oa_dq_spl", spr, "=,like", "or", "id desc");
      
       dt = SqlHelper.GetTable(sql, CommandType.Text, spr);

        return dt;
    }

    /* 目标表  if  type=ing   table=oa_dq_spl     if  type=ed  table=oa_ls_spl
    * 查询条件  id=lcid
    *           公共变量        对应数据库字段
       * 编号： bh              id
       标题：   title           titles
      发布时间：biuldtime       sender_times
      文件内容：contents        contents
      是否回执：ishz            spl_huizhi  （如果 数据库数据为true  ishz='是'  否则...）
    * 
    * 
    * json_lc_datas ＝splc_datas的数据（长成这样：高阳，25｜姜凯源，26） 包装成json  字段为 name  和 id

       json_fj  =fj_url的数据  （文件一，/UpFile/2016010510145533.doc|文件二,/UpFile/2016010302530843.doc）  json  字段 filename  filepath

       json_yj=spyj_id_contents_times  (25,意见内容,2015-01-01|26,意见内容,2015-01-03)  包含与此流程相关所有审批意见 json 字段名：id,yj,times   
    */

    public DataTable Oa_dq_spl(string id)
   
  
    {

        DataTable dt = null;

        SqlParameter[] spr = { 
                                 new SqlParameter("@id", id)                         
                             };

        String sql = SqlHelper.GetSQLSelect_normal("", "titles,sender_times,contents,spl_huizhi,splc_datas,fj_url,spyj_id_contents_times ", "oa_dq_spl", spr, "=", "", "id desc");

        dt = SqlHelper.GetTable(sql, CommandType.Text, spr);

        return dt;


    }

 
    public DataTable Oa_ls_spl(string id)
    {

        DataTable dt = null;

        SqlParameter[] spr = { 
                                 new SqlParameter("@id", id)                          
                             };

        String sql = SqlHelper.GetSQLSelect_normal("", "titles,sender_times,contents,spl_huizhi,splc_datas,fj_url,spyj_id_contents_times ", "oa_ls_spl", spr, "=", "", "id desc");

        dt = SqlHelper.GetTable(sql, CommandType.Text, spr);

        return dt;

    }

    public  DataTable  Oapart()
    
    {

        DataTable dt = null;

        String sql = SqlHelper.GetSQLSelect_normal("", "id,part", "oa_part", null, "", "", "id asc");

        dt = SqlHelper.GetTable(sql, CommandType.Text, null);

        return dt;

    }
     
    
    
      public DataTable Oauser()
    
      {


        DataTable dt = null;

        String sql = SqlHelper.GetSQLSelect_normal("", "id,name,u_part", "oa_user", null, "", "", "id asc");

        dt = SqlHelper.GetTable(sql, CommandType.Text, null);

        return dt;

    }

}