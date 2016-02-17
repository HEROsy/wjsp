using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_ydylcfb : System.Web.UI.Page
{
    _BLL b = null;
    //json_lc   表 oa_ydylc  返回值 id,spl_name,spl_content_txt   where  u_id=1   id desc


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
     * 向表oa_dq_spl插入一条数据
     * userid=sender_id
     * lcid=splc_id
     * title=titles
     * contents=contents
     * sfhz=spl_huizhi
     * jjcd=stars
     * fjpath=fj_url
     * 通过lcid 查询 表oa_ydylc 的spl_content值=splc_datas
     * 当前时间=sender_times
     * 
     * 
     */
    public string json_lc = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        b = new _BLL();
        json_lc = jsonlc("1");
        
    }


    private string jsonlc(String u_id)
    
    
    {
       
        string jason = "";

        DataTable dt = b.Jsonlcc(u_id);
        jason = Tools.BiuldJson("", dt);
        return jason;


    }



}