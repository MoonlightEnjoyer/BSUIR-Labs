using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace Spolks1.CommandHandlers
{
    public class CommandParameters
    {
        public string CommandName { get; set; }

        public string[] Parameters { get; set; }

        public Socket Socket { get; set; }

        public CommandParameters(string commandName, string[] commandParameters, Socket socket)
        {
            CommandName = commandName;
            Parameters = new string[commandParameters.Length];
            Array.Copy(commandParameters, Parameters, commandParameters.Length);
            Socket = socket;
        }
    }
}
