using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OA_addspl : System.Web.UI.Page
{
    public String json_bm = ""; //表 oa_part 的所有行  包装成json字符串
    public String json_user = ""; //表 oa_user 的所有行 返回字段：id,name,u_part 包装成json


    //在AsyCenter.aspx 里添加 type='addspl'  时的处理   接收userid，contents，splname 这三个数据  在表oa_ydylc 里添加一条项目 u_id=userid ,spl_name=splname,spl_content=contents 返回值为 ‘受影响的行数’  

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}