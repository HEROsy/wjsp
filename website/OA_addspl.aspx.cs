﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_addspl : System.Web.UI.Page
{


    _BLL b = null;
     
    
    public String json_bm = ""; //表 oa_part 的所有行  包装成json字符串
    public String json_user = ""; //表 oa_user 的所有行 返回字段：id,name,u_part 包装成json
    public String userid = "";

    //在AsyCenter.aspx 里添加 type='addspl'  时的处理   接收userid，contents，splname, contents_txt这几个数据  在表oa_ydylc 里添加一条项目 u_id=userid ,spl_name=splname,spl_content=contents, spl_content_txt=contents_txt 返回值为 ‘受影响的行数’  

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            userid = Session["user"].ToString().Split('|')[0];
        }
        catch (Exception)
        {
            Response.Redirect("OA_login.aspx");
        }
        b = new _BLL();
        json_bm = jason_b();
        json_user = jason_u(userid);
       
    }

  
    public  string jason_b()
    
    {
        string jason = "";

        DataTable dt = b.Json_bm();

        jason = Tools.BiuldJson("", dt);
        return jason;
    }

   
    public  string  jason_u(string userid)//选择自己以外的所有用户
    {

        string json = "";

        DataTable dt = b.Json_user(userid);

        json = Tools.BiuldJson("", dt);
       
        return json;
    }

  


}