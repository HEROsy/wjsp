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

        SqlParameter[] spr={new SqlParameter("@u_name",name),
                            new SqlParameter("@u_password",password)};
        String sql = SqlHelper.GetSQLSelect_normal("top 1", "id,name", "oa_user", spr, "=,=", "and", "id asc");
       
        dt = SqlHelper.GetTable(sql, CommandType.Text, spr);

        return dt;
    }
}