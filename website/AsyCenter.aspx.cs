using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AsyCenter : System.Web.UI.Page
{
    _BLL bll = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        bll = new _BLL();
        
        String tag = Request.Form["type"];
        if (!String.IsNullOrEmpty(tag))
        {
            switch (tag)
            {
                case "userlogin":
                    UserLogin();
                    break;

                case "loginout":
                    LoginOut();
                    break;

                case "kaoqingpage":
                    KaoQingPage();
                    break;

                case "addbm":
                    AddM();
                    break;

                case "getallbm":
                    GetAllBM();
                    break;

                case "deletebm":
                    DeleteBM();
                    break;

                case "deleteyh":
                    DeleteYH();
                    break;

                case "addyh":
                    AddYH();
                    break;

                case "getfyyh":
                    GetFYYH();
                    break;

                case "saveimgb64":
                    SaveImgB64();
                    break;

                case "resetuserpasswor":
                    ResetUserPassword();
                    break;

                case "addspl":
                    Addspl();
                    break;

                case "newstream":
                    Newstream();
                    break;

                case "addspyj":
                    AddSPYJ();
                    break;

                case "qd":
                    QD();
                    break;

                case "qt":
                    QT();
                    break;

                case "qj":
                    QJ();
                    break;

                case "addspyj_qj":
                    AddSPYJ_QJ();
                    break;

                case "hl":
                    HL();
                    break;

                case "requestimgdata":
                    requestimgdata();
                    break;
                case "vdata":
                    vdata();
                    break;
                case "getname":
                    GetName();
                    break;
                case "dau":
                    dadata();
                    break;

                case "bulkkaoqing":
                    BulkKaoQing();
                    break;

                case "deletelc":
                    DeleteLC();
                    break;


                case "checkuser":
                    CheckUser();
                    break;

                case "cpw":
                    CPW();
                    break;
                case "pagedq":
                    Pagedq();
                    break;

                case "pagels":
                    Pagels();

                    break;
                default:
                    break;
            }
        }

    }

    private void CPW()
    {
        String old=Request.Form["old"];
        String newpw=Request.Form["newpw"];

        String uid = "";
        try
        {
            uid = Session["user"].ToString().Split('|')[0];
        }
        catch (Exception)
        {
            Response.Write("<script>window.parent.location.href = 'oa_login.aspx';</script>");
            Response.End();
        }

        String syspw = "";
        SqlParameter[] spr={new SqlParameter("@id",uid)};
        String sql = SqlHelper.GetSQLSelect_normal("top 1", "u_password", "oa_user", spr, "=", "", "id");
        syspw = SqlHelper.GetTable(sql, CommandType.Text, spr).Rows[0][0].ToString();

        if (!old.Equals(syspw))
        {
            Response.Write("no");
            Response.End();
        }
        else
        {
            SqlParameter[] sspr = {new SqlParameter("@u_password",newpw) };
            sql=SqlHelper.GetSQLUpdate_normal("oa_user", sspr, spr, "=", "");
            Response.Write(SqlHelper.ExcoutSQL_2Parmter(sql, CommandType.Text, sspr, spr));
            Response.End();
        }
    }

    private void CheckUser()
    {
        String uid = "";
        try
        {
            uid = Session["user"].ToString().Split('|')[0];
        }
        catch (Exception)
        {
            Response.Write("no");
            Response.End();
        }
        SqlParameter[] spr={new SqlParameter("@id",uid)};
        String sql = SqlHelper.GetSQLSelect_normal("top 1", "u_quanxian", "oa_user", spr, "=", "", "id");
        String qx = SqlHelper.GetTable(sql, CommandType.Text, spr).Rows[0]["u_quanxian"].ToString();
        if (qx.Trim().Equals("1"))
        {
            Response.Write("ok");
            Response.End();
        }
        else
        {
            Response.Write("no");
            Response.End();
        }
    }

    private void DeleteLC()
    {
        String lcid=Request.Form["lcid"];
        int r = 0;
        //删除表oa_ydylc  [id]=lcid 的行 返回受影响行数  出问题返回-1
        SqlParameter[] spr = { new SqlParameter("@id", lcid) };
        string sql = "delete from  oa_ydylc where id = @id ";
        r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
        Response.Write(r);
        Response.End();

    }

   private void BulkKaoQing()
    {
        String dates=Request.Form["dates"];
        //dates 格式 2016-12-01,1/2/3｜2016-12-02，1/2/3｜...
        //｜分隔多组数据
        //，左边是日期对应数据据字段day 右边是1 则更改qj_a为4 是2更改qj_p为4  是3两个字段都改成4
        //出错返回-1 否则返回受影响行数
     // string dates = "2016-02-0255345341｜2016-02-05，2sfdsgdfghfh";
        int r1 = 0;
        int r2=0;
        int r3=0;
        int r =0;
        
        string [] date = null;
        string [] datei=null;
        string day =  "";
        string qj="";

        string sql1 = "update oa_kaoqing set qj_a=4 where day=@day";
        string sql2 = "update oa_kaoqing set qj_p=4 where day=@day";
        string sql3 = "update oa_kaoqing set qj_a=4, qj_p=4 where day=@day";

        date = dates.Split(new char[2]{'｜','|'});
        try
       
        {
            for (int i = 0; i < date.Length; i++)
            {
                datei = date[i].Split(new char[2] { ',', '，' });
                day = datei[0];
                qj = datei[1];

                if (qj == "1")
                {
                    SqlParameter[] spr = { new SqlParameter("@day", day) };
                    r1 += SqlHelper.ExcoutSQL(sql1, CommandType.Text, spr);
                }

                else if (qj == "2")
                {
                    SqlParameter[] spr = { new SqlParameter("@day", day) };
                    r2+= SqlHelper.ExcoutSQL(sql2, CommandType.Text, spr);
                }

                else if (qj == "3")
                {
                    SqlParameter[] spr = { new SqlParameter("@day", day) };
                    r3 += SqlHelper.ExcoutSQL(sql3, CommandType.Text, spr);
                }


            }

              r = r1 + r2 + r3;
              Response.Write(r);
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
        catch (Exception)
        {
            Response.Write(-1);
            HttpContext.Current.ApplicationInstance.CompleteRequest();
           
        }  
       
    }

    private void GetName()
    {
        String uname = Request.Form["uname"];

        SqlParameter[] spr = { new SqlParameter("@u_name", uname) };
        String sql = SqlHelper.GetSQLSelect_normal("", "name", "oa_user", spr, "=", "", "id");
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
        Response.Write(dt.Rows[0]["name"].ToString());
        Response.End();
    }

    private void requestimgdata()
    {
        //String uname=Request.Form["u_name"];
        //String img64=Request.Form["img64"];
        String url = "http://apis.baidu.com/idl_baidu/faceverifyservice/face_register";
        String param = Request.Form["param"];
        String result = request(url, param);
        Response.Write(result);
        Response.End();
    }

    private void vdata()
    {
        string url = "http://apis.baidu.com/idl_baidu/faceverifyservice/face_recognition";
        String param = Request.Form["param"];
        String result = request(url, param);
        Response.Write(result);
        Response.End();
    }

    private void dadata()
    {
        string url = "http://apis.baidu.com/idl_baidu/faceverifyservice/face_deleteuser";
        String param = Request.Form["param"];
        String result = request(url, param);
        Response.Write(result);
        Response.End();
    }
    /// <summary>
    /// 发送HTTP请求
    /// </summary>
    /// <param name="url">请求的URL</param>
    /// <param name="param">请求的参数</param>
    /// <returns>请求结果</returns>
    public static string request(string url, string param)
    {
        string strURL = url;
        System.Net.HttpWebRequest request;
        request = (System.Net.HttpWebRequest)WebRequest.Create(strURL);
        request.Method = "POST";
        // 添加header
        request.Headers.Add("apikey", "12f9102cc69e0fc3de871b5473b2949d");
        request.ContentType = "application/x-www-form-urlencoded";
        string paraUrlCoded = param;
        byte[] payload;
        payload = System.Text.Encoding.UTF8.GetBytes(paraUrlCoded);
        request.ContentLength = payload.Length;
        Stream writer = request.GetRequestStream();
        writer.Write(payload, 0, payload.Length);
        writer.Close();
        System.Net.HttpWebResponse response;
        response = (System.Net.HttpWebResponse)request.GetResponse();
        System.IO.Stream s;
        s = response.GetResponseStream();
        string StrDate = "";
        string strValue = "";
        StreamReader Reader = new StreamReader(s, Encoding.UTF8);
        while ((StrDate = Reader.ReadLine()) != null)
        {
            strValue += StrDate + "\r\n";
        }
        return strValue;
    }


    private void HL()
    {
        String kqid=Request.Form["kqid"];
        String aop=Request.Form["aop"];

        SqlParameter[] spr = null;
        SqlParameter[] sprw = {new SqlParameter("@id",kqid) };
        if (aop.Equals("sw"))
        {
            spr = new SqlParameter[] {new SqlParameter("@hl_a",1) };
        }
        else if (aop.Equals("xw"))
        {
            spr = new SqlParameter[] {new SqlParameter("@hl_p",1) };
        }
        String sql = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", spr, sprw, "=", "");
        int r = SqlHelper.ExcoutSQL_2Parmter(sql, CommandType.Text, spr, sprw);
        Response.Write(r);
        Response.End();
    }

    private void AddSPYJ_QJ()
    {
        String lcid = Request.Form["lcid"];
        String contents=Request.Form["contents"];
        String agree=Request.Form["agree"];
        int fr = -1;
        String result = "";


        //up spl
        String userid = Session["user"].ToString().Split('|')[0];
        String spyj =  userid+ "," + contents + "," + DateTime.Now;
        SqlParameter[] spr_s = { new SqlParameter("@spyj_id_contents_times", spyj), new SqlParameter("@finish", 1), new SqlParameter("@agree", agree) };
        SqlParameter[] spr_w = { new SqlParameter("@id", lcid) };
        String sql = SqlHelper.GetSQLUpdate_normal("oa_dq_spl", spr_s, spr_w, "=", "");
        int r = SqlHelper.ExcoutSQL_2Parmter(sql, CommandType.Text, spr_s, spr_w);
        if (r != 1)
        {
            Response.Write("no");
            Response.End();
        }

        if (agree.Equals("1"))
        {
            
            //change kaoqing
            SqlParameter[] spr = { new SqlParameter("@id", lcid) };
            sql = SqlHelper.GetSQLSelect_normal("top 1", "splc_id,spl_type,stars", "oa_dq_spl", spr, "=", "", "id");
            DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
            String kqid = dt.Rows[0]["splc_id"].ToString();
            String qjtype=dt.Rows[0]["spl_type"].ToString();
            String aop = dt.Rows[0]["stars"].ToString();
            SqlParameter[] spr1 = null;
            if (aop.Equals("a"))
            {
                spr1 =new SqlParameter[] { new SqlParameter("@qj_a", qjtype) };
            }
            else if (aop.Equals("p"))
            {
                spr1 =new SqlParameter[] { new SqlParameter("@qj_p", qjtype) };
            }
            SqlParameter[] spr2 = { new SqlParameter("@id", kqid) };
            sql = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", spr1, spr2, "=", "");
            r = SqlHelper.ExcoutSQL_2Parmter(sql, CommandType.Text, spr1, spr2);
            
            if (r==1)
            {
                String sql2 = "insert into oa_ls_spl (sender_id,sender_times,titles,contents,stars,fj_url,splc_id,splc_datas,next_id,spyj_id_contents_times,spl_huizhi,spl_type,finish,agree) select sender_id,sender_times,titles,contents,stars,fj_url,splc_id,splc_datas,next_id,spyj_id_contents_times,spl_huizhi,spl_type,finish,agree from oa_dq_spl where id=" + lcid;
                int r2 = SqlHelper.ExcoutSQL(sql2, CommandType.Text, null);
                if (r2 == 1)
                {
                    String a = "delete from oa_dq_spl where id=" + lcid;
                    fr=SqlHelper.ExcoutSQL(a, CommandType.Text, null);
                }
            }
           
        }
        else {
           
            String sql2 = "insert into oa_ls_spl (sender_id,sender_times,titles,contents,stars,fj_url,splc_id,splc_datas,next_id,spyj_id_contents_times,spl_huizhi,spl_type,finish,agree) select sender_id,sender_times,titles,contents,stars,fj_url,splc_id,splc_datas,next_id,spyj_id_contents_times,spl_huizhi,spl_type,finish,agree from oa_dq_spl where id=" + lcid;
            int r2 = SqlHelper.ExcoutSQL(sql2, CommandType.Text, null);
            if (r2 == 1)
            {
                String a = "delete from oa_dq_spl where id=" + lcid;
                fr=SqlHelper.ExcoutSQL(a, CommandType.Text, null);
            }
        }

        if (fr == 1)
        {
            result = "ok";
        }
        else
        {
            result = "no";
        }

        if (result.Equals("ok"))
        {
            //Change TZ_TXT
            DataTable dt_tzcount = bll.GetNewMessageCount(userid);
            if (dt_tzcount.Rows.Count > 0)
            {
                if (MyHub.UserHandle.Users.ContainsValue(userid))
                {
                    GlobalHost.ConnectionManager.GetHubContext<MyHub>().Clients.Client(MyHub.UserHandle.Users.First(p => p.Value == userid).Key).tz("1");
                }
            }
            else
            {
                if (MyHub.UserHandle.Users.ContainsValue(userid))
                {
                    GlobalHost.ConnectionManager.GetHubContext<MyHub>().Clients.Client(MyHub.UserHandle.Users.First(p => p.Value == userid).Key).tz("0");
                }
            }
            Response.Write(result);
            Response.End();
        }
        else
        {
            Response.Write(result);
            Response.End();
        }
       
    }

    private void QJ()
    {
        String kqid = Request.Form["kqid"];
        String qjtype=Request.Form["qjtype"];
        String ly=Request.Form["ly"];
        String spuserid=Request.Form["spuserid"];
        String spusername=Request.Form["spusername"];
        String senderid=Session["user"].ToString().Split('|')[0];
        String aop=Request.Form["aop"];
        DateTime sendtime=DateTime.Now;
        String title = ""; if (qjtype.Equals("2")) { title = "病假"; } else if (qjtype.Equals("3")) { title = "事假"; } else if (qjtype.Equals("4")) { title = "公假"; }

        //update kaoqing
        SqlParameter[] ar_spr = null;
        if (aop.Equals("a"))
        {
            ar_spr = new SqlParameter[] {new SqlParameter("@ar_qj_a",1) };
        }
        else if (aop.Equals("p"))
        {
            ar_spr = new SqlParameter[] {new SqlParameter("@ar_qj_p",1) };
        }
        SqlParameter[] where_spr={new SqlParameter("@id",kqid)};
        String sql = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", ar_spr, where_spr, "=", "");
        int r = SqlHelper.ExcoutSQL_2Parmter(sql, CommandType.Text, ar_spr, where_spr);
        if (r!=1)
        {
            Response.Write("处理过程出现问题");
            Response.End();
        }

        //insert dq_spl
        SqlParameter[] spr = {new SqlParameter("@sender_id",senderid),
                              new SqlParameter("@sender_time",sendtime),
                              new SqlParameter("@titles",title),
                              new SqlParameter("@contents",ly),
                              new SqlParameter("@splc_id",kqid),
                              new SqlParameter("@splc_datas",spusername+","+spuserid),
                              new SqlParameter("@spl_huizhi",true),
                              new SqlParameter("@spl_type",qjtype),
                              new SqlParameter("@finish",false),
                              new SqlParameter("@agree",false),
                              new SqlParameter("@next_id",spuserid),
                              new SqlParameter("@stars",aop)};
        sql ="INSERT INTO oa_dq_spl (sender_id,sender_times,titles,contents,splc_id,splc_datas,spl_huizhi,spl_type,finish,agree,next_id,stars) VALUES (@sender_id,@sender_time,@titles,@contents,@splc_id,@splc_datas,@spl_huizhi,@spl_type,@finish,@agree,@next_id,@stars)  SELECT @@IDENTITY AS Id";// SqlHelper.GetSQLInsert_normal("oa_dq_spl", spr);
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
        String tzid = dt.Rows[0]["Id"].ToString();
        if (String.IsNullOrEmpty(tzid))
        {
            Response.Write("创建失败");
            Response.End();
        }
        //TZ
        
            if (MyHub.UserHandle.Users.ContainsValue(spuserid))
            {
                GlobalHost.ConnectionManager.GetHubContext<MyHub>().Clients.Client(MyHub.UserHandle.Users.First(p => p.Value == spuserid).Key).tz("你有新消息！！");
            }
    }

    private void LoginOut()
    {
        object os = Session["user"];
        if (os != null)
        {
            String id = os.ToString().Split('|')[0];
            if (MyHub.UserHandle.Users.ContainsValue(id))
            {
                MyHub.UserHandle.Users.Remove(id);
            }
            Session["user"] = null;
        }
        Response.Write("帐户已退出！");
        Response.End();
    }

    private void QT()
    {
        String userid = "";
        DateTime qttime = DateTime.Now;

        try
        {
            userid = Session["user"].ToString().Split('|')[0];
        }
        catch (Exception)
        {
            Response.Write("err");
            Response.End();
        }

        SqlParameter[] spr = { new SqlParameter("@u_id", userid), new SqlParameter("@day", qttime.ToString("yyyy-MM-dd")) };
        String sql = SqlHelper.GetSQLSelect_normal("top 1", "id,a_start_time,a_end_time,p_end_time,p_start_time", "oa_kaoqing", spr, "=,=", "and", "id desc");
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
        if (dt.Rows.Count > 0)
        {
            String a_start_time = dt.Rows[0]["a_start_time"].ToString();
            String p_start_time = dt.Rows[0]["p_start_time"].ToString();
            String a_end_time = dt.Rows[0]["a_end_time"].ToString();
            String p_end_time = dt.Rows[0]["p_end_time"].ToString();
            String id = dt.Rows[0]["id"].ToString();


            if (String.IsNullOrEmpty(a_start_time) && String.IsNullOrEmpty(p_start_time))
            {
                Response.Write("请先签到！");
                Response.End();
            }
            else
            {
                if (!String.IsNullOrEmpty(a_start_time) && !String.IsNullOrEmpty(p_start_time))
                {
                    if (!String.IsNullOrEmpty(a_end_time) && !String.IsNullOrEmpty(p_end_time))
                    {
                        Response.Write("已签退，无需重复此操作！");
                        Response.End();
                    }
                    else
                    {
                        if (String.IsNullOrEmpty(a_end_time) && String.IsNullOrEmpty(p_end_time))
                        {
                            SqlParameter[] spr1 = { new SqlParameter("@a_end_time", qttime.ToString("HH:mm:ss")) };
                            SqlParameter[] spr2 = { new SqlParameter("@id", id) };
                            String sql1 = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", spr1, spr2, "=", "");
                            int r = SqlHelper.ExcoutSQL_2Parmter(sql1, CommandType.Text, spr1, spr2);
                            if (r == 1)
                            {
                                Response.Write("签退完成！ ");
                                Response.End();
                            }
                            else
                            {
                                Response.Write("签退未完成！");
                                Response.End();
                            }
                        }
                        else
                        {
                            if (String.IsNullOrEmpty(a_end_time))
                            {
                                SqlParameter[] spr1 = { new SqlParameter("@a_end_time", qttime.ToString("HH:mm:ss")) };
                                SqlParameter[] spr2 = { new SqlParameter("@id", id) };
                                String sql1 = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", spr1, spr2, "=", "");
                                int r = SqlHelper.ExcoutSQL_2Parmter(sql1, CommandType.Text, spr1, spr2);
                                if (r == 1)
                                {
                                    Response.Write("签退完成！ ");
                                    Response.End();
                                }
                                else
                                {
                                    Response.Write("签退未完成！");
                                    Response.End();
                                }
                            }
                            else
                            {
                                SqlParameter[] spr1 = { new SqlParameter("@p_end_time", qttime.ToString("HH:mm:ss")) };
                                SqlParameter[] spr2 = { new SqlParameter("@id", id) };
                                String sql1 = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", spr1, spr2, "=", "");
                                int r = SqlHelper.ExcoutSQL_2Parmter(sql1, CommandType.Text, spr1, spr2);
                                if (r == 1)
                                {
                                    Response.Write("签退完成！ ");
                                    Response.End();
                                }
                                else
                                {
                                    Response.Write("签退未完成！");
                                    Response.End();
                                }
                            }
                        }
                    }
                }
                else
                {
                    if (!String.IsNullOrEmpty(a_start_time))
                    {
                        if (String.IsNullOrEmpty(a_end_time))
                        {
                            SqlParameter[] spr1 = { new SqlParameter("@a_end_time", qttime.ToString("HH:mm:ss")) };
                            SqlParameter[] spr2 = { new SqlParameter("@id", id) };
                            String sql1 = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", spr1, spr2, "=", "");
                            int r = SqlHelper.ExcoutSQL_2Parmter(sql1, CommandType.Text, spr1, spr2);
                            if (r == 1)
                            {
                                Response.Write("签退完成！ ");
                                Response.End();
                            }
                            else
                            {
                                Response.Write("签退未完成！");
                                Response.End();
                            }
                        }
                        else
                        {
                            Response.Write("已签退，无需重复此操作！");
                            Response.End();
                        }
                       
                    }
                    else
                    {
                        if (String.IsNullOrEmpty(p_end_time))
                        {
                            SqlParameter[] spr1 = { new SqlParameter("@p_end_time", qttime.ToString("HH:mm:ss")) };
                            SqlParameter[] spr2 = { new SqlParameter("@id", id) };
                            String sql1 = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", spr1, spr2, "=", "");
                            int r = SqlHelper.ExcoutSQL_2Parmter(sql1, CommandType.Text, spr1, spr2);
                            if (r == 1)
                            {
                                Response.Write("签退完成！ ");
                                Response.End();
                            }
                            else
                            {
                                Response.Write("签退未完成！");
                                Response.End();
                            }
                        }
                        else
                        {
                            Response.Write("已签退，无需重复此操作！");
                            Response.End();
                        }
                       
                    }

                }
            }
        }
        else
        {
            Response.Write("请先签到！");
            Response.End();
        }
    }
    //    if (!String.IsNullOrEmpty(a_start_time))
    //    {
    //        if (String.IsNullOrEmpty(a_end_time))
    //        {
    //            SqlParameter[] spr1 = { new SqlParameter("@a_end_time",qttime.ToString("HH:mm:ss"))};
    //            SqlParameter[] spr2 = { new SqlParameter("@id",id)};
    //            String sql1 = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", spr1, spr2, "=", "");
    //            int r = SqlHelper.ExcoutSQL_2Parmter(sql1, CommandType.Text, spr1, spr2);
    //            if (r == 1)
    //            {
    //                Response.Write("签退完成！ ");
    //                Response.End();
    //            }
    //            else
    //            {
    //                Response.Write("签退未完成！");
    //                Response.End();
    //            }
    //        }
    //        else
    //        {
    //            Response.Write("已签退，无需重复此操作！");
    //            Response.End();
    //        }
    //    }
    //    else if (!String.IsNullOrEmpty(p_start_time))
    //    {
    //        if (String.IsNullOrEmpty(p_end_time))
    //        {
    //            SqlParameter[] spr1 = { new SqlParameter("@p_end_time", qttime.ToString("HH:mm:ss")) };
    //            SqlParameter[] spr2 = { new SqlParameter("@id", id) };
    //            String sql1 = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", spr1, spr2, "=", "");
    //            int r = SqlHelper.ExcoutSQL_2Parmter(sql1, CommandType.Text, spr1, spr2);
    //            if (r == 1)
    //            {
    //                Response.Write("签退完成！ ");
    //                Response.End();
    //            }
    //            else
    //            {
    //                Response.Write("签退未完成！");
    //                Response.End();
    //            }
    //        }
    //        else
    //        {
    //            Response.Write("已签退，无需重复此操作！");
    //            Response.End();
    //        }
    //    }
    //}
    //else
    //{
    //    Response.Write("请先签到！");
    //    Response.End();

    private void QD()
    {
        String userid = "";
        try
        {
            userid = Session["user"].ToString().Split('|')[0];
        }
        catch (Exception)
        {
            Response.Write("err");
            Response.End();
        }

        int tag = 0;

        DateTime qdtime = DateTime.Now;

        DateTime sys_a_start = Convert.ToDateTime(ConfigurationManager.AppSettings["a_start_time"].ToString());
        DateTime sys_a_end = Convert.ToDateTime(ConfigurationManager.AppSettings["a_end_time"].ToString());
        DateTime sys_p_start = Convert.ToDateTime(ConfigurationManager.AppSettings["p_start_time"].ToString());
        DateTime sys_p_end = Convert.ToDateTime(ConfigurationManager.AppSettings["p_end_time"].ToString());

        int offsettime = Convert.ToInt32(ConfigurationManager.AppSettings["offsettime"].ToString());
        offsettime = -offsettime;

        if (qdtime.CompareTo(sys_a_end) == -1)
        {
            DateTime early_time = sys_a_start.AddMinutes(offsettime);
            if (qdtime.CompareTo(early_time) == -1)
            {
                Response.Write("现在不能签到，上午最早签到时间：" + early_time.ToString());
                Response.End();
            }
            else
            {
                tag = 1;
            }
        }
        else if (qdtime.CompareTo(sys_p_end) == -1)
        {
            DateTime early_time = sys_p_start.AddMinutes(offsettime);
            if (qdtime.CompareTo(early_time) == -1)
            {
                Response.Write("现在不能签到，下午最早签到时间：" + early_time.ToString());
                Response.End();
            }
            else
            {
                tag = 2;
            }
        }
        else
        {
            Response.Write("不能签到！");
            Response.End();
        }

        if (tag == 2)
        {
            String qd_day = qdtime.ToString("yyyy-MM-dd");
            SqlParameter[] spr = { new SqlParameter("@day", qd_day), new SqlParameter("@u_id", userid) };
            String sql = SqlHelper.GetSQLSelect_normal("top 1", "id,p_start_time,a_end_time", "oa_kaoqing", spr, "=,=", "and", "id asc");
            DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
            if (dt.Rows.Count > 0)
            {
                if (String.IsNullOrEmpty(dt.Rows[0]["p_start_time"].ToString()))
                {
                    if (String.IsNullOrEmpty(dt.Rows[0]["a_end_time"].ToString()))
                    {
                        Response.Write("请先签退！");
                        Response.End();
                    }
                    else
                    {
                        String id = dt.Rows[0]["id"].ToString();
                        SqlParameter[] spr1 = { new SqlParameter("@p_start_time", qdtime.ToString("HH:mm:ss")) };
                        SqlParameter[] spr2 = { new SqlParameter("@id", id) };
                        sql = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", spr1, spr2, "=", "");
                        int r = SqlHelper.ExcoutSQL_2Parmter(sql, CommandType.Text, spr1, spr2);
                        if (r == 1)
                        {
                            Response.Write("已签到，下午好！");
                            Response.End();
                        }
                        else
                        {
                            Response.Write("签到未成功！");
                            Response.End();
                        }
                    }
                }
                else
                {
                    Response.Write("已签到，无需重复此操作");
                    Response.End();
                }

            }
            else
            {
                SqlParameter[] spr3 = { new SqlParameter("@u_id", userid), new SqlParameter("@p_start_time", qdtime.ToString("HH:mm:ss")), new SqlParameter("@day", qd_day) };
                sql = SqlHelper.GetSQLInsert_normal("oa_kaoqing", spr3);
                int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr3);
                if (r != 1)
                {
                    Response.Write("签到未成功!");
                    Response.End();
                }
                else
                {
                    Response.Write("已签到，下午好！");
                    Response.End();
                }

            }
        }
        else if (tag == 1)
        {
            String qd_day = qdtime.ToString("yyyy-MM-dd");
            SqlParameter[] spr = { new SqlParameter("@day", qd_day), new SqlParameter("@u_id", userid) };
            String sql = SqlHelper.GetSQLSelect_normal("top 1", "id,a_start_time", "oa_kaoqing", spr, "=,=", "and", "id asc");
            DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
            if (dt.Rows.Count > 0)
            {
                if (String.IsNullOrEmpty(dt.Rows[0]["a_start_time"].ToString()))
                {
                    String id = dt.Rows[0]["id"].ToString();
                    SqlParameter[] spr1 = { new SqlParameter("@a_start_time", qdtime.ToString("HH:mm:ss")) };
                    SqlParameter[] spr2 = { new SqlParameter("@id", id) };
                    sql = SqlHelper.GetSQLUpdate_normal("oa_kaoqing", spr1, spr2, "=", "");
                    int r = SqlHelper.ExcoutSQL_2Parmter(sql, CommandType.Text, spr1, spr2);
                    if (r == 1)
                    {
                        Response.Write("已签到，上午好！");
                        Response.End();
                    }
                    else
                    {
                        Response.Write("签到未成功！");
                        Response.End();
                    }
                }
                else
                {
                    Response.Write("已签到，无需重复此操作");
                    Response.End();
                }

            }
            else
            {
                SqlParameter[] spr3 = { new SqlParameter("@u_id", userid), new SqlParameter("@a_start_time", qdtime.ToString("HH:mm:ss")), new SqlParameter("@day", qd_day) };
                sql = SqlHelper.GetSQLInsert_normal("oa_kaoqing", spr3);
                int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr3);
                if (r != 1)
                {
                    Response.Write("签到未成功!");
                    Response.End();
                }
                else
                {
                    Response.Write("已签到，上午好！");
                    Response.End();
                }

            }
        }

    }

    private void AddSPYJ()
    {
        String userid = "";
        String result = "";

        try { userid = Session["user"].ToString().Split('|')[0]; }
        catch (Exception) { Response.Write("no user"); Response.End(); };

        String lcid = Request.Form["lcid"];
        String contens = Request.Form["contents"];
        //insert yj
        String d = String.Format("{0},{1},{2}|", userid, Tools.encode(contens), DateTime.Now);
        SqlParameter[] spr = { new SqlParameter("@d", d), new SqlParameter("@lcid", lcid) };
        String sql = "update oa_dq_spl set spyj_id_contents_times=isnull(spyj_id_contents_times,'')+@d where id=@lcid";
        int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
        if (r != 1)
        {
            Response.Write("no");
            Response.End();
        }
        //change next_id
        String tzid = StreamManage.SetNextID(lcid,userid);
        if (!String.IsNullOrEmpty(tzid))
        {
            //tz user
            SqlParameter[] spr1 = {new SqlParameter("@id",lcid) };
            sql = SqlHelper.GetSQLSelect_normal("", "spl_type", "oa_dq_spl", spr1, "=", "", "id");
            DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr1);
            String spl_type = dt.Rows[0]["spl_type"].ToString();
            if (spl_type.Equals("1"))
            {
                if (MyHub.UserHandle.Users.ContainsValue(tzid))
                {
                    GlobalHost.ConnectionManager.GetHubContext<MyHub>().Clients.Client(MyHub.UserHandle.Users.First(p => p.Value == tzid).Key).tz("你有新消息！");
                }
                result = "ok1";
            }
            else if (spl_type.Equals("0"))
            {
                result = "ok3";
            }
            else
            {
                result = "err";
            }
           
        }
        else
        {
            String sql2 = "insert into oa_ls_spl (sender_id,sender_times,titles,contents,stars,fj_url,splc_id,splc_datas,next_id,spyj_id_contents_times,spl_huizhi,spl_type) select sender_id,sender_times,titles,contents,stars,fj_url,splc_id,splc_datas,next_id,spyj_id_contents_times,spl_huizhi,spl_type from oa_dq_spl where id=" + lcid;
            int r2 = SqlHelper.ExcoutSQL(sql2, CommandType.Text, null);
            if (r2 == 1)
            {
                String a = "delete from oa_dq_spl where id=" + lcid;
                SqlHelper.ExcoutSQL(a, CommandType.Text, null);
            }
            result = "ok2";
        }

        //Change TZ_TXT
        DataTable dt_tzcount = bll.GetNewMessageCount(userid);
        if (dt_tzcount.Rows.Count > 0)
        {
            if (MyHub.UserHandle.Users.ContainsValue(userid))
            {
                GlobalHost.ConnectionManager.GetHubContext<MyHub>().Clients.Client(MyHub.UserHandle.Users.First(p => p.Value == userid).Key).tz("1");
            }
        }
        else
        {
            if (MyHub.UserHandle.Users.ContainsValue(userid))
            {
                GlobalHost.ConnectionManager.GetHubContext<MyHub>().Clients.Client(MyHub.UserHandle.Users.First(p => p.Value == userid).Key).tz("0");
            }
        }
        Response.Write(result);
        Response.End();
    }

    private void ResetUserPassword()
    {
        String id = Request.Form["id"];
        String newpasseord = "666666";
        String sql = "update oa_user set u_password=" + newpasseord + " where id=" + id;
        int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, null);
        Response.Write(r);
        Response.End();
    }

    private void SaveImgB64()
    {
        String id = Request.Form["id"];
        String data = Request.Form["b64"];
        SqlParameter[] set_spr = { new SqlParameter("@imgbase64", data) };
        SqlParameter[] where_spr = { new SqlParameter("@id", id) };
        String sql = SqlHelper.GetSQLUpdate_normal("oa_user", set_spr, where_spr, "=", "");
        int r = SqlHelper.ExcoutSQL_2Parmter(sql, CommandType.Text, set_spr, where_spr);
        Response.Write(r);
        Response.End();
    }

    private void GetFYYH()
    {
        String partid = Request.Form["partid"];
        String pagesize = Request.Form["pagesize"];
        String pageindex = Request.Form["pageindex"];

        int startindex = 0;
        int endindex = 0;
        try
        {
            startindex = (Convert.ToInt32(pageindex) - 1) * Convert.ToInt32(pagesize);
            endindex = Convert.ToInt32(pageindex) * Convert.ToInt32(pagesize);
        }
        catch (Exception)
        {
            Response.Write("error arg");
            Response.End();
        }

        SqlParameter[] spr ={
                           new SqlParameter("@end",endindex),
                           new SqlParameter("@start",startindex),
                           new SqlParameter("@partid",partid)
                           };
        String sql = "SELECT  w1.id FROM oa_user w1 where u_part=@partid";
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
        int count = dt.Rows.Count;
        sql = "SELECT top (@end) w1.id,w1.name,w1.u_name FROM oa_user w1, ( SELECT TOP (@end) row_number() OVER (ORDER BY ID desc ) n, ID FROM oa_user where u_part=@partid) w2 WHERE w1.ID = w2.ID AND w2.n > @start   ORDER BY w2.n ASC ";
        dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
        String r = Tools.BiuldJson("", dt);
        if (!String.IsNullOrEmpty(r))
        {
            r = r.Insert(1, "{'" + HttpUtility.UrlEncode("count") + "':'" + count + "'},");
        }
        Response.Write(r);
        Response.End();
    }

    private void AddYH()
    {
        String name = Request.Form["yhname"];
        String partid = Request.Form["partid"];
        SqlParameter[] spr = { new SqlParameter("@name", name), new SqlParameter("@u_part", partid) };
        String sql = SqlHelper.GetSQLInsert_normal("oa_user", spr);
        int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
        Response.Write(r);
        Response.End();
    }

    private void DeleteBM()
    {
        String id = Request.Form["id"];
        String sql = "select id from oa_user where u_part=" + id;
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, null);
        if (dt != null)
        {
            if (dt.Rows.Count > 0)
            {
                Response.Write("no:该部门下存在用户信息，如果想删除该部门请先删除相关用户，删除失败!");
                Response.End();
            }
        }
        SqlParameter spr = new SqlParameter("@id", id);
        sql = "delete from oa_part where id=@id";
        int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
        Response.Write(r + ":");
        Response.End();
    }

    private void DeleteYH()
    {
        String id = Request.Form["id"];
        SqlParameter spr = new SqlParameter("@id", id);
        String sql = "delete from oa_user where id=@id";
        int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
        Response.Write(r);
        Response.End();
    }

    private void GetAllBM()
    {
        String sql = SqlHelper.GetSQLSelect_normal("", "id,part", "oa_part", null, "", "", "id desc");
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, null);
        String r = Tools.BiuldJson("", dt);
        Response.Write(r);
        Response.End();
    }

    private void AddM()
    {
        String bmname = Request.Form["bmname"];

        SqlParameter[] spr = { new SqlParameter("@part", bmname) };
        String sql = SqlHelper.GetSQLInsert_normal("oa_part", spr);
        int r = SqlHelper.ExcoutSQL(sql, CommandType.Text, spr);
        Response.Write(r);
        Response.End();
    }

    private void KaoQingPage()
    {
        String year = Request.Form["year"];
        String moth = Request.Form["month"];
        String pagesize = Request.Form["pagesize"];
        String pageindex = Request.Form["pageindex"];

        DateTime stime = Convert.ToDateTime(year + "-" + moth + "-01");
        DateTime etime = stime.AddMonths(1);

        int startindex = 0;
        int endindex = 0;
        try
        {
            startindex = (Convert.ToInt32(pageindex) - 1) * Convert.ToInt32(pagesize);
            endindex = Convert.ToInt32(pageindex) * Convert.ToInt32(pagesize);
        }
        catch (Exception)
        {
            Response.Write("error arg");
            Response.End();
        }

        SqlParameter[] spr ={
                           new SqlParameter("@end",endindex),
                           new SqlParameter("@start",startindex),
                           new SqlParameter("@stime",stime),
                           new SqlParameter("@etime",etime)
                           };
        String sql = "SELECT  w1.id FROM oa_kaoqing w1 where @stime<=day and day<@etime";
        DataTable dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
        int count = dt.Rows.Count;
        sql = "SELECT top (@end) w1.id,w1.a_state,w1.p_state,w1.day FROM oa_kaoqing w1, ( SELECT TOP (@end) row_number() OVER (ORDER BY ID asc ) n, ID FROM oa_kaoqing) w2 WHERE w1.ID = w2.ID AND w2.n > @start and   @stime<=day and day<@etime  ORDER BY w2.n ASC ";
        dt = SqlHelper.GetTable(sql, CommandType.Text, spr);
        String r = Tools.BiuldJson("", dt);
        if (!String.IsNullOrEmpty(r))
        {
            r = r.Insert(1, "{'" + HttpUtility.UrlEncode("count") + "':'" + count + "'},");
        }
        Response.Write(r);
        Response.End();
    }
    //
    public void UserLogin()
    {
        String r = "用户名或密码错误！";
        String UserName = Request.Form["username"];
        String Password = Request.Form["password"];
        if (String.IsNullOrEmpty(UserName) || String.IsNullOrEmpty(Password))
        {
            Response.Write(r);
            Response.End();
        }
        DataTable dt = bll.UserLogin(UserName, Password);
        if (dt != null)
        {
            if (dt.Rows.Count != 0)
            {
                if (MyHub.UserHandle.Users.ContainsValue(dt.Rows[0]["id"].ToString()))
                {
                    r = "当前账号已登录，禁止重复登录!!";
                    Response.Write(r);
                    Response.End();
                }
                Session["user"] = dt.Rows[0]["id"].ToString() + "|" + dt.Rows[0]["name"].ToString();
                r = "ok";
            }

            Response.Write(r);
            Response.End();
        }

    }

    //签到
    // public void QianDao()
    // {
    //     string id = Request.Form["ID"];

    //     DateTime t;
    //     t = DateTime.Now;
    //     string p = t.ToString();

    //     DataTable dt = null;
    //     SqlParameter[] spr = { new SqlParameter("@id", id) };
    //     String sql = SqlHelper.GetSQLSelect_normal("", "day=null,p_start_time=null", "oa_kaoqing", spr, "=", "", "id asc");
    //     dt = SqlHelper.GetTable(sql, CommandType.Text, null);


    //     if (dt.Rows.Count > 0)
    //     {

    //         bll.RegisterA(id, p, null, null);

    //     }

    //     else if (dt.Rows.Count <= 0)
    //     {
    //         bll.RegisterP(id, p, null, null);
    //     }


    // }
    // //结算
    //  public string JieSuan()
    // {
    //     bool r = false;
    //     DataTable dt = null;
    //     string jason = "";

    //      string id = Request.Form["ID"];
    //      string day = Request.Form ["Day"];

    //        r =bll.JieSuan(id, day);

    //      if (r==true)
    //      {
    //          dt = bll.JieSuant(id, day);

    //         jason = Tools.BiuldJson("", dt);

    //      }

    //      return jason;

    //}

    private void Addspl()
    {
        int r = 0;

        string Userid = Request.Form["userid"];
        string Contents = Request.Form["contents"];
        string Splname = Request.Form["splname"];
        string Contents_txt = Request.Form["contents_txt"];
        //insert spl
        r = bll.Addspll(Userid, Contents, Splname, Contents_txt);
        Response.Write(r);
        Response.End();

    }

    /*asycenter 添加对“newstream”的处理  
     *                         (前台发过来的数据)
                               userid:
                               lcid:
                               title:
                               contents:
                               sfhz:
                               jjcd：
                               fjpath:
     * 
     * 通过lcid 查询 表oa_ydylc 的spl_content值
     * 
     * 向表oa_dq_spl插入一条数据
     * userid=sender_id
     * lcid=splc_id
     * title=titles
     * contents=contents
     * sfhz=spl_huizhi
     * jjcd=stars
     * fjpath=fj_url
     * 
     * 通过lcid 查询 表oa_ydylc 的spl_content值=splc_datas
     * 
     * 当前时间=sender_times
     * 
     * 
     */

    public void Newstream()
    {
        string sender_id = Request.Form["userid"];
        string splc_id = Request.Form["lcid"];
        string titles = Request.Form["title"];
        string contents = Request.Form["contents"];
        string spl_huizhi = Request.Form["sfhz"];
        string stars = Request.Form["jjcd"];
        string fj_url = Request.Form["fjpath"];
        String lctype=Request.Form["lctype"];
        DateTime sender_times = DateTime.Now;

        string spl_content = "";// SqlHelper.ExecuteScalar(sql, CommandType.Text, spr).ToString();

        if (lctype.Equals("1"))
        {
            SqlParameter[] spr = { new SqlParameter("@id", splc_id) };
            string sql = SqlHelper.GetSQLSelect_normal("top 1", "spl_content,spl_content_txt", "oa_ydylc", spr, "=", "", "id asc");
            DataTable dtt = SqlHelper.GetTable(sql, CommandType.Text, spr);
            String[] ids = dtt.Rows[0]["spl_content"].ToString().Split(',');
            String[] names = dtt.Rows[0]["spl_content_txt"].ToString().Split(',');
            for (int i = 0; i < ids.Length; i++)
            {
                spl_content = spl_content += names[i] + "," + ids[i] + "|";
            }
            spl_content = spl_content.Substring(0, spl_content.LastIndexOf('|'));
        }
        else if (lctype.Equals("0"))
        {
            spl_content=Request.Form["lc_datas"];
            splc_id = "";
        }
        

        try
        {
            SqlParameter[] sprr ={new SqlParameter("@sender_id",sender_id),
                         new SqlParameter("@splc_id",splc_id),
                         new SqlParameter("@titles", titles ),
                         new SqlParameter("@contents",contents),
                         new SqlParameter("@spl_huizhi", spl_huizhi),                        
                          new SqlParameter("@stars",  stars),
                           new SqlParameter("@fj_url", fj_url),
                            new SqlParameter("@sender_times",sender_times),
                           new SqlParameter("@splc_datas",spl_content),
                           new SqlParameter("@spl_type",lctype)
                                 };

            //string sqll = SqlHelper.GetSQLInsert_normal("oa_dq_spl", sprr);
            String sqll = "INSERT INTO oa_dq_spl (sender_id, splc_id,titles,contents,spl_huizhi,stars,fj_url,sender_times,splc_datas,spl_type) VALUES (@sender_id,@splc_id,@titles,@contents,@spl_huizhi,@stars,@fj_url,@sender_times,@splc_datas,@spl_type)  SELECT @@IDENTITY AS Id";
            DataTable dt = SqlHelper.GetTable(sqll, CommandType.Text, sprr);

            //Init next id
            String lcid = dt.Rows[0]["id"].ToString();
            String tzid = "";
            if (lctype.Equals("1"))
            {
                tzid = StreamManage.InitNextId_Normal(lcid);
                //TZ
                if (MyHub.UserHandle.Users.ContainsValue(tzid))
                {
                    GlobalHost.ConnectionManager.GetHubContext<MyHub>().Clients.Client(MyHub.UserHandle.Users.First(p => p.Value == tzid).Key).tz("1");
                }
            }
            else if (lctype.Equals("0"))
            {
                tzid = StreamManage.InitNextId_all(lcid);
                //TZ
                String[] ids = null;
                if (tzid.Contains(","))
                {
                    ids = tzid.Split(',');
                }
                else
                {
                    ids = new String[] { tzid };
                }
                foreach (String item in ids)
                {
                    if (MyHub.UserHandle.Users.ContainsValue(item))
                    {
                        GlobalHost.ConnectionManager.GetHubContext<MyHub>().Clients.Client(MyHub.UserHandle.Users.First(p => p.Value == item).Key).tz("1");
                    }
                }
            }
           
           
        }
        catch (Exception)
        {
            Response.Write("0");
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
        Response.Write("1");
        Response.End();
    }


     private  void Pagedq()
    
 {

     string pagesize = Request.Form["pagesize"];
     string index = Request.Form["pageindex"];
     String userid = "";
     try
     {
         userid = Session["user"].ToString().Split('|')[0];
     }
     catch (Exception)
     {
         Response.Write("err");
         Response.End();
     }
        
     //string pagesize ="4" ;
     //string index = "1";
     //String userid = "1";

        string json = "";
        DataTable dt = null;
        string sql = "";
        int r = 0;
      
        //SqlParameter[] spr = { 
        //                           new  SqlParameter("@pagesize",pagesize),
        //                           new  SqlParameter("@index ",index),
        //                           new  SqlParameter("@sender_id",userid)
        //                     };

        r = Convert.ToInt32(pagesize) * (Convert.ToInt32(index) - 1);

        if (r == 0)
        {
            sql = "select top " + @pagesize + " * from oa_dq_spl where sender_id=" + userid + " or splc_datas like '%" + userid + "%'" + " order by id desc";
        }
        else
        {
            sql = "select top " + @pagesize + " * from oa_dq_spl where id not in (select top " + @r + " id from oa_dq_spl where sender_id=" + userid + " or splc_datas like '%" + userid + "%'" + " order by id desc) and sender_id=" + userid + " or splc_datas like '%" + userid + "%' order by id desc";
           
        }
        //id,sender_id,sender_times,titles,contents,stars,fj_url,splc_id,splc_datas 


        dt = SqlHelper.GetTable(sql, CommandType.Text,null);
        json = Tools.BiuldJson("",dt);
        Response.Write(json);
        Response.End();
      
    }


    private void Pagels()

      {

          string pagesize = Request.Form["pagesize"];
          string index = Request.Form["pageindex"];
          String userid = "";
          try
          {
              userid = Session["user"].ToString().Split('|')[0];
          }
          catch (Exception)
          {
              Response.Write("err");
              Response.End();
          }
          string json = "";
          DataTable dt = null;
          string sql = "";
          int r = 0;


          //SqlParameter[] spr = { 
          //                         new  SqlParameter("@pagesize",pagesize),
          //                         new  SqlParameter("@index ",index),
          //                         new  SqlParameter("@sender_id",userid)
          //                   };

          r = Convert.ToInt32(pagesize) * (Convert.ToInt32(index) - 1);

          if (r == 0)
          {
              sql = "select top " + @pagesize + " * from oa_ls_spl where sender_id="+userid+" or splc_datas like '%" + userid + "%'" + " order by id desc";
          }
          else
          {
              sql = "select top " + @pagesize + " * from oa_ls_spl where id not in (select top " + @r + " id from oa_ls_spl where sender_id=" + userid + " or splc_datas like '%" + userid + "%'" + " order by id desc) and sender_id=" + userid + " or splc_datas like '%" + userid + "%' order by id desc";
          }
          // and sender_id=@sender_id or splc_datas like '%" + userid + "%'
          dt = SqlHelper.GetTable(sql, CommandType.Text, null);
          json = Tools.BiuldJson("", dt);
          Response.Write(json);
          Response.End();

      }
   

}


    

