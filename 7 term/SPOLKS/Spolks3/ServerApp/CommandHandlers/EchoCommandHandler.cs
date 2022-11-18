using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ServerApp.CommandHandlers
{
    public class EchoCommandHandler : CommandHandlerBase
    {
        public override bool CanHandle(string commandName)
        {
            return commandName == "ECHO";
        }

        public override void Handle(Client client)
        {
            if (CanHandle(client.Context.Parameters.CommandName))
            {
                Echo(client.Context.Parameters);
                client.Context.Parameters.CommandName = null;
                client.Context.Parameters = null;
            }
            else
            {
                base.Handle(client);
            }
        }

        private void Echo(CommandParameters parameters)
        {
            parameters.Socket.Send(Encoding.UTF8.GetBytes(String.Join(" ", parameters.Parameters)));
        }
    }
}
