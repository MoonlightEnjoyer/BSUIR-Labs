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
            if (CanHandle(client.Context.Parameters.CommandName))
            {
                Close(client.Context.Parameters);
                client.Context.Parameters.CommandName = null;
                client.Context.Parameters = null;
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
