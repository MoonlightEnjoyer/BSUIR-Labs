using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ExecutableCommands.CommandHandlers
{
    public class CloseCommandHandler : CommandHandlerBase
    {
        public override bool CanHandle(string commandName)
        {
            return commandName == "CLOSE";
        }

        public override void Handle(CommandParameters commandParameters)
        {
            if (CanHandle(commandParameters.CommandName))
            {
                Close(commandParameters);
            }
            else
            {
                base.Handle(commandParameters);
            }
        }

        private void Close(CommandParameters parameters)
        {
            parameters.Socket.Shutdown(SocketShutdown.Both);
            parameters.Socket.Close();
        }
    }
}
