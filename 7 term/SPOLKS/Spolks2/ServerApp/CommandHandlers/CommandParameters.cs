using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ServerApp.CommandHandlers
{
    public class CommandParameters
    {
        public string CommandName { get; set; }

        public string Parameters { get; set; }

        public MySocket Socket { get; set; }


        public EndPoint DestinationIp { get; set; }

        public CommandParameters(string commandName, string commandParameters, MySocket socket, EndPoint destinationIp)
        {
            CommandName = commandName;
            Parameters = commandParameters;
            DestinationIp = destinationIp;
            Socket = socket;
        }
    }
}
