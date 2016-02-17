using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_splxq : System.Web.UI.Page
{
    _BLL b = null;
    /* 目标表  if  type =ing   table=oa_dq_spl     if  type=ed  table=oa_ls_spl
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

        json_yj= spyj_id_contents_times  (25,意见内容,2015-01-01|26,意见内容,2015-01-03)  包含与此流程相关所有审批意见 json 字段名：id,yj,times   
     */
     public string  json_lc_datas ="";
     public string  json_fj  = "";
     public string  json_yj="";
     
     public string  bh = "";
     public string  title = "";
     public string  biuldtime = "";
     public string  contents = "";
     public string  ishz = "";
     public String weboffice = "";


     public String spyj = "";

    protected void Page_Load(object sender, EventArgs e)
      {
          string splcdatas="";
          string fjurl = "";
          string spyjidcontentstimes = "";

          b = new _BLL();
         
        String lcid =  Request.QueryString["lcid"];
        String type =  Request.QueryString["type"];

        String nextid = "";
        String spl_type = "";

          bh = lcid;
         
          DataTable dt = ReturnDt(lcid, type);

          for (int i = 0; i < dt.Rows.Count; i++)
          {             
              title = dt.Rows[i]["titles"].ToString();
              biuldtime = dt.Rows[i]["sender_times"].ToString();
              contents = dt.Rows[i]["contents"].ToString();
              ishz = dt.Rows[i]["spl_huizhi"].ToString();
              splcdatas = dt.Rows[i]["splc_datas"].ToString();
              fjurl = dt.Rows[i]["fj_url"].ToString();
              spyjidcontentstimes = dt.Rows[i]["spyj_id_contents_times"].ToString();
              nextid = dt.Rows[0]["next_id"].ToString();
              spl_type = dt.Rows[0]["spl_type"].ToString();
          }

          if (ishz.Equals("1"))
          {
              ishz = "是";
          }
          else if (ishz.Equals("0"))
          {
              ishz = "否";
          }
          else
          {
              ishz = "未获取";
          }


          json_lc_datas = Json_lc_datas(splcdatas);
          json_fj = Json_fj(fjurl);
          json_yj = Json_yj(spyjidcontentstimes);

          if (type.Equals("ing"))
          {
              weboffice = "<div style='width: 702px; height: 220px; border: 1px solid #cdcdcd; border-top: none;'>"+
                            "<script src='WebOffice/loadweboffice.js'></script>"+
                           "</div>";

              //next_id
              String userid = "";
              try { userid = Session["user"].ToString(); }
              catch (Exception) { Response.Redirect("oa_login.aspx"); };
              if (spl_type.Equals("1"))
              {
                  if (userid.Split('|')[0].Equals(nextid))
                  {
                      spyj = "<div>" +
                                "<div style='background-color:#08c;height:20px;'><span>审批意见</span></div>" +
                                "<textarea id='spyj' style='height:150px;'></textarea>" +
                            "</div>" +
                            "<div><input id='send' type='button' value='确认审批'/></div>";
                  }
              }
              else if (spl_type.Equals("0"))
              {
                  Boolean c = false;
                  String[] ids = null;
                  String uid = userid.Split('|')[0];

                  if (nextid.Contains(","))
                  {
                      ids = nextid.Split(',');
                  }
                  else
                  {
                      ids = new String[] { nextid };
                  }
                  foreach (String item in ids)
                  {
                      if (item.Equals(uid))
                      {
                          c = true;
                          break;
                      }
                  }

                  if (c)
                  {
                      spyj = "<div>" +
                                "<div style='background-color:#08c;height:20px;'><span>审批意见</span></div>" +
                                "<textarea id='spyj' style='height:150px;'></textarea>" +
                            "</div>" +
                            "<div><input id='send' type='button' value='确认审批'/></div>";
                  }
              }
              else if (spl_type.Equals("2") || spl_type.Equals("3"))
              {
                  if (Session["user"].ToString().Split('|')[0].Equals(nextid))
                  {
                      spyj = " <div>" +
                                    "<div style='background-color: #08c; height: 20px;'><span>审批意见</span></div>" +
                                    "<textarea id='spyj' style='height: 150px;'></textarea>" +
                                "</div>" +
                         "<div>" +
                            "<span>是否同意：</span>" +
                            "<span>是</span>" +
                            "<input type='radio' name='agree' checked='checked' value='1' />" +
                            "<span>否</span>" +
                            "<input type='radio' name='agree' value='0' />" +
                        "</div>" +
                        "<div>" +
                            "<input id='send_qj' type='button' value='确认审批' />" +
                        "</div>";
                  }
              }

          }
    }

    public DataTable ReturnDt(string lcid, string type)
    {

        DataTable dt = null;

        if (type =="ing")
        {
          dt= b.Oa_dq_spl(lcid);
        }      

        else if (type =="ed")
	   {
           dt = b.Oa_ls_spl(lcid);
        }
            
        return dt;

     }

   // json_lc_datas ＝splc_datas的数据（长成这样：高阳，25｜姜凯源，26） 包装成json  字段为 name  和 id   
    //{"firstName":"Brett","lastName":"McLaughlin","email":"aaaa"}
    public string  Json_lc_datas( string jsonlcdata)
    {
         string j ="";
         string s = "";
         string[] st = null;
         string[] str = null;
         string r = "[";
         try
         {
             st = jsonlcdata.Split(new char[2] { '|', '｜' });

             for (int i = 0; i < st.Length; i++)
             {
                 s = st[i];
                 str = s.Split(new char[2] { ',', '，' });
                 j = "{\"name\":\"" + str[0] + "\"," + "\"id\":\"" + str[1] + "\"},";
                 r += j;
             }


             r = r.Substring(0, r.Length - 1);
             r += "]";


             return r;
         }
         catch (Exception)
         {
             return  "数据有误";
         }

      

    }

   //json_fj  =fj_url的数据  （文件一，/UpFile/2016010510145533.doc|文件二,/UpFile/2016010302530843.doc）  json  字段 filename  filepath
    public string Json_fj(string jsonf)
    {
        string j = "";
        string s = "";
        string[] st = null;
        string[] str = null;
        string r = "[";

        try
        {
            st = jsonf.Split(new char[2] { '|', '｜' });

            for (int i = 0; i < st.Length; i++)
            {
                s = st[i];
                str = s.Split(new char[2] { ',', '，' });
                j = "{\"filename\":\"" + str[0] + "\"," + "\"filepath\":\"" + str[1] + "\"},";
                r += j;
            }

            r = r.Substring(0, r.Length - 1);
            r += "]";


            return r;
        }
        catch (Exception)
        {
            
            return "数据有误";
        }
    
    }

  //json_yj= spyj_id_contents_times  (25,意见内容,2015-01-01|26,意见内容,2015-01-03)  包含与此流程相关所有审批意见 json 字段名：id,yj,times   
    public string Json_yj(string jsony)
    {
        string j = "";
        string s = "";
        string[] st = null;
        string[] str = null;
        string r = "[";

        try
        {
            st = jsony.Split(new char[2] { '|', '｜' });

            for (int i = 0; i < st.Length; i++)
            {
                s = st[i];
                if (String.IsNullOrEmpty(s)) { continue; }
                str = s.Split(new char[2] { ',', '，' });

                j = "{\"id\":\"" + str[0] + "\"," + "\"yj\":\"" + str[1] + "\"," + "\"times\":\"" + str[2] + "\"},";

                r += j;
            }

            r = r.Substring(0, r.Length - 1);
            r += "]";


            return r;
        }
        catch (Exception)
        {
            
           return "数据有误";
        }
      

    }
}