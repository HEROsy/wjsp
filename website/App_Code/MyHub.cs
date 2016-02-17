using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using System.Data;

public class MyHub : Hub
{

    //public static IHubContext hc = null;

    //public MyHub()
    //{
    //    hc = GlobalHost.ConnectionManager.GetHubContext<MyHub>();
    //}

    public static class UserHandle
    {
        public static Dictionary<String, String> Users = new Dictionary<string, string>();
    }

    public void userconnection(String userid_name)
    {
        String id = userid_name.Split('|')[0];
        String name = userid_name.Split('|')[1];

        if (UserHandle.Users.ContainsValue(id))
        {
            repeatlogin();
        }
        else
        {
            UserHandle.Users.Add(Context.ConnectionId, id);
            //tz(name + "　已上线!  现在用户个数：" + UserHandle.Users.Count);

            if (StreamManage.TryGetTZIDs(id))
            {
                Clients.Client(UserHandle.Users.First(p => p.Value == id).Key).tz("1");
            }
        }
    }

    public override System.Threading.Tasks.Task OnConnected()
    {
        return base.OnConnected();
    }

    public override System.Threading.Tasks.Task OnDisconnected(bool stopCalled)
    {
        UserHandle.Users.Remove(Context.ConnectionId);
        return base.OnDisconnected(stopCalled);
    }

    public override System.Threading.Tasks.Task OnReconnected()
    {
        return base.OnReconnected();
    }

    public  void tz(String msg)
    {
        Clients.All.tz(msg);
    }

    public void repeatlogin()
    {
        Clients.Caller.repeatlogin();
    }
}
