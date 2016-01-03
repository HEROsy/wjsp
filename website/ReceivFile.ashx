<%@ WebHandler Language="C#" Class="ReceivFile" %>

using System;
using System.Web;

public class ReceivFile : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

        try
        {
            HttpPostedFile files = context.Request.Files["upfile"];

            if (files!=null&&files.ContentLength>0)
            {
                String picpath = System.Configuration.ConfigurationManager.AppSettings["UserUpFilePath"].ToString();
                
                    String pic;
                    String str = files.FileName;
                    String hdm = str.Substring(str.LastIndexOf('.'));
                    Random rd = new Random();
                    pic = picpath + DateTime.Now.ToString("yyyyMMddhhmmss") + rd.Next(0, 9).ToString() + rd.Next(0, 9).ToString() + hdm;

                    files.SaveAs(context.Server.MapPath(pic));
                    String r = "{\"state\":\"ok\",\"filename\":\"" + str + "\",\"filepath\":\""+pic+"\"}";
                    context.Response.Write(r);
                    //Response.End();
                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                
            }
        }
        catch (Exception)
        {
            context.Response.Write("{\"state\":\"no\",\"filename\":\"\",\"filepath\":\"\"}");
            context.Response.End();
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}