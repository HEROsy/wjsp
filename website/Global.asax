﻿<%@ Application Language="C#" %>

<script runat="server">
    int v = 0;
    void Application_Start(object sender, EventArgs e) 
    {
        // 在应用程序启动时运行的代码
        System.Timers.Timer timer = new System.Timers.Timer(5000);
        timer.Elapsed+=new System.Timers.ElapsedEventHandler(a);
        timer.Enabled = true;
        timer.Start();
    }

    protected void a(object sender,System.Timers.ElapsedEventArgs e)
    {
        
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  在应用程序关闭时运行的代码

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // 在出现未处理的错误时运行的代码

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // 在新会话启动时运行的代码

    }

    void Session_End(object sender, EventArgs e) 
    {
        // 在会话结束时运行的代码。  
        // 注意: 只有在 Web.config 文件中的 sessionstate 模式设置为
        // InProc 时，才会引发 Session_End 事件。如果会话模式设置为 StateServer
        // 或 SQLServer，则不引发该事件。

    }
       
</script>
