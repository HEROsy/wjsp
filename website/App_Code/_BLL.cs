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
        String sql = SqlHelper.GetSQLSelect_normal("1", "id,name", "user", spr, "=,=", "and", "id asc");
       
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
        string sql = SqlHelper.GetSQLSelect_normal("", "", "user",spr, ">=,<=,=", "and,and,and", "StartDate,EndDate,UserId");
  
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
                                  new SqlParameter("@startdate",PageSize),
                                  new SqlParameter ("@enddate",PageIndex)
                                 
                              };
        try
        {
            string sql = SqlHelper.GetSQLSelect_normal("", "", "user", spr, ">=,<=,=,=,=", "and,and,and,and,and", "StartDate,EndDate,UserId,PageSize,PageIndex");
            
            dt = SqlHelper.GetTable(sql, CommandType.Text, spr);

            return dt;
                         
        }
        catch (Exception)
        {
            return null;
        }

       
    }
}