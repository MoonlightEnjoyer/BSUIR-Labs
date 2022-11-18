using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ServerApp.CommandHandlers
{
    public class CloseCommandHandler : CommandHandlerBase
    {
        public override bool CanHandle(string commandName)
        {
            return commandName == "CLOSE";
        }

        public override void Handle(Client client)
        {
            if (CanHandle(client.Context.parameters.CommandName))
            {
                Close(client.Context.parameters);
                client.Context.command = null;
                client.Context.parameters = null;
            }
            else
            {
                base.Handle(client);
            }
        }

        private void Close(CommandParameters parameters)
        {
            parameters.Socket.Shutdown(SocketShutdown.Both);
            parameters.Socket.Close();
        }
    }
}
