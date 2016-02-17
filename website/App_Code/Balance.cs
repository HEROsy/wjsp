using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Balance 的摘要说明
/// </summary>
public class Balance
{

    DateTime sys_ast;
    DateTime sys_aet;
    DateTime sys_pst;
    DateTime sys_pet;
    

    public Balance()
    {
        sys_ast = Convert.ToDateTime(ConfigurationManager.AppSettings["a_start_time"].ToString());
        sys_aet = Convert.ToDateTime(ConfigurationManager.AppSettings["a_end_time"].ToString());
        sys_pst = Convert.ToDateTime(ConfigurationManager.AppSettings["p_start_time"].ToString());
        sys_pet = Convert.ToDateTime(ConfigurationManager.AppSettings["p_end_time"].ToString());
    }


	public  void Balance_Day()
    {
        String Btime = DateTime.Now.ToString("yyyy-MM-dd");
        DataTable dt_kaoqing = null;
        DataTable dt_user = null;

        SqlParameter[] spr = {new SqlParameter("@day",Btime) };
        String sql = SqlHelper.GetSQLSelect_normal("", "id,u_id,a_start_time,a_end_time,p_start_time,p_end_time", "oa_kaoqing", spr, "=", "", "id");
        dt_kaoqing = SqlHelper.GetTable(sql, CommandType.Text, spr);
        sql = SqlHelper.GetSQLSelect_normal("","id","oa_user",null,"","","id");
        dt_user = SqlHelper.GetTable(sql, CommandType.Text, null);
        DataColumn[] prikey = new DataColumn[1];
        prikey[0]=dt_user.Columns["id"];
        dt_user.PrimaryKey = prikey;

        DataRow dr = null;
        foreach (DataRow item in dt_kaoqing.Rows)
        {
            balance_row(item);
            dr = dt_user.Rows.Find(item["u_id"]);
            if (dr!=null)
            {
                 dt_user.Rows.Remove(dr);
            }
        }


        int cdtime = (int)(sys_aet - sys_ast).TotalMinutes+(int)(sys_pet - sys_pst).TotalMinutes;
        foreach (DataRow item in dt_user.Rows)
        {
            InsertEmptyRow(item["id"].ToString(),4,4,cdtime,0,Btime);
        }
    }

    private void InsertEmptyRow(string p1, int p2, int p3, int cdtime, int p4, string Btime)
    {
        SqlParameter[] spr = {new SqlParameter("@u_id",p1),new SqlParameter("@a_state",p2),new SqlParameter("@p_state",p3),new SqlParameter("@u_cd",cdtime),new SqlParameter("@u_zt",p4),new SqlParameter("@day",Btime) };
        String sql = SqlHelper.GetSQLInsert_normal("oa_kaoqing", spr);
        SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
    }
    
    //state: 0:正常  1迟到  2早退  3迟到早退  4旷工
    private void balance_row(DataRow item)
    {
        String ast = item["a_start_time"].ToString();
        String aet = item["a_end_time"].ToString();
        String pst = item["p_start_time"].ToString();
        String pet = item["p_end_time"].ToString();
        int a_stat = 0;
        int p_stat = 0;
        int T_zt = 0;
        int T_cd = 0;

        int m_a_cd = 0;
        int m_a_zt = 0;
        int m_p_cd = 0;
        int m_p_zt = 0;
        int m_a_start_stat = 0;
        int m_a_end_stat = 0;
        int m_p_start_stat = 0;
        int m_p_end_stat = 0;


        if (String.IsNullOrEmpty(ast))
        {
            a_stat = 4;
            m_a_cd = (int)(sys_aet - sys_ast).TotalMinutes;
        }
        else
        {
            if (String.IsNullOrEmpty(aet))
            {
                a_stat = 4;
                m_a_cd = (int)(sys_aet - sys_ast).TotalMinutes;
            }
            else
            {
                DateTime a_qd_time = Convert.ToDateTime(ast);
                if (a_qd_time.CompareTo(sys_ast) == 1)
                {
                    m_a_cd = (int)(a_qd_time - sys_ast).TotalMinutes;
                    m_a_start_stat = 1;
                }

                DateTime a_qt_time = Convert.ToDateTime(aet);
                if (a_qt_time.CompareTo(sys_aet) == -1)
                {
                    m_a_zt = (int)(sys_aet - a_qt_time).TotalMinutes;
                    m_a_end_stat = 1;
                }
                else {
                    int QToffset = Convert.ToInt32(ConfigurationManager.AppSettings["QToffsettime"].ToString());
                    DateTime lastQTtime = sys_aet.AddMinutes(QToffset);
                    if (a_qt_time.CompareTo(lastQTtime)==1)
                    {
                        a_stat = 4;
                        m_a_cd = (int)(sys_aet - sys_ast).TotalMinutes;
                    }
                }
                
            }
        }

        if (String.IsNullOrEmpty(pst))
        {
            p_stat = 4;
            m_p_cd = (int)(sys_pet - sys_pst).TotalMinutes;
        }
        else
        {
            if (String.IsNullOrEmpty(pet))
            {
                p_stat = 4;
                m_p_cd = (int)(sys_aet - sys_ast).TotalMinutes;
            }
            else
            {
                DateTime p_qd_time = Convert.ToDateTime(pst);
                if (p_qd_time.CompareTo(sys_pst) == 1)
                {
                    m_p_cd = (int)(p_qd_time - sys_pst).TotalMinutes;
                    m_p_start_stat = 1;
                }

                DateTime p_qt_time = Convert.ToDateTime(pet);
                if (p_qt_time.CompareTo(sys_pet) == -1)
                {
                    m_p_zt = (int)(sys_pet - p_qt_time).TotalMinutes;
                    m_p_end_stat = 1;
                }

            }
        }

        T_cd = m_a_cd + m_p_cd;
        T_zt = m_a_zt + m_p_zt;

        if (a_stat==0)
        {
            if (m_a_start_stat!=0&&m_a_end_stat!=0)
            {
                a_stat = 3;
            }
            else if (m_a_start_stat!=0)
            {
                a_stat = 1;
            }
            else if (m_a_end_stat!=0)
            {
                a_stat = 2;
            }
        }

        if (p_stat == 0)
        {
            if (m_p_start_stat != 0 && m_p_end_stat != 0)
            {
                p_stat = 3;
            }
            else if (m_p_start_stat != 0)
            {
                p_stat = 1;
            }
            else if (m_p_end_stat != 0)
            {
                p_stat = 2;
            }
        }

        UpRow(a_stat, p_stat, T_cd, T_zt, item["id"].ToString());
        

    }

    private int UpRow(int a_stat, int p_stat, int T_cd, int T_zt, string id)
    {
        SqlParameter[] spr1 = {new SqlParameter("@a_state",a_stat),new SqlParameter("@p_state",p_stat),new SqlParameter("@u_cd",T_cd),new SqlParameter("@u_zt",T_zt) };
        SqlParameter[] spr2 = {new SqlParameter("@id",id) };
        String sql = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", spr1, spr2, "=", "");
        return SqlHelper.ExcoutSQL_2Parmter(sql, CommandType.Text, spr1, spr2);
    }

}