using ExecutableCommands.CommandHandlers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ExecutableCommands
{
    public class Client
    {
        public Socket Socket { get; set; }

        public string Username { get; set; }

        public string LastReceivedMessage { get; set; }

        public Context Context { get; set; } = new Context();
    }

    public class Context
    {
        public CommandParameters Parameters { get; set; }

        public object CommandExecutionData { get; set; }
    }
}
