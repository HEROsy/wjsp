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
      string  json_lc_datas ="";
      string  json_fj  = "";
      string  json_yj="";
     
      string  bh = "";
      string  title = "";
      string  biuldtime = "";
      string  contents = "";
      string  ishz = "";

    protected void Page_Load(object sender, EventArgs e)
      {
          string splcdatas="";
          string fjurl = "";
          string spyjidcontentstimes = "";

          b = new _BLL();
         
        String lcid = "1";// Request.QueryString["lcid"];
        String type = "ing";// Request.QueryString["type"];

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
          }

          if (ishz == "true")
          {
              ishz = "是";
          }
          else
          {
              ishz = "否";
          }


          json_lc_datas = Json_lc_datas(splcdatas);
          json_fj = Json_fj(fjurl);
          json_yj = Json_yj(spyjidcontentstimes);



         
        
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