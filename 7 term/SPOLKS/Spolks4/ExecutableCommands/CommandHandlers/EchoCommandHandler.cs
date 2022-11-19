using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ExecutableCommands.CommandHandlers
{
    public class EchoCommandHandler : CommandHandlerBase
    {
        public override bool CanHandle(string commandName)
        {
            return commandName == "ECHO";
        }

        public override void Handle(CommandParameters commandParameters)
        {
            if (CanHandle(commandParameters.CommandName))
            {
                Echo(commandParameters);
            }
            else
            {
                base.Handle(commandParameters);
            }
        }

        private void Echo(CommandParameters parameters)
        {
            parameters.Socket.Send(Encoding.UTF8.GetBytes(String.Join(" ", parameters.Parameters)));
        }
    }
}
