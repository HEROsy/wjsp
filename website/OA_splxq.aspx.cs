using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_splxq : System.Web.UI.Page
{
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

        json_yj=spyj_id_contents_times  (25,意见内容,2015-01-01|26,意见内容,2015-01-03)  包含与此流程相关所有审批意见 json 字段名：id,yj,times   
     */

    protected void Page_Load(object sender, EventArgs e)
    {
        String lcid = "1";// Request.QueryString["lcid"];
        String type = "ing";// Request.QueryString["type"];


        
    }
}