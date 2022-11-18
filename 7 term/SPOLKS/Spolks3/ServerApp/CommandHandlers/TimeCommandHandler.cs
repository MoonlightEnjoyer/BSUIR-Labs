using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ServerApp.CommandHandlers
{
    public class TimeCommandHandler : CommandHandlerBase
    {
        public override bool CanHandle(string commandName)
        {
            return commandName == "TIME";
        }

        public override void Handle(Client client)
        {
            if (CanHandle(client.Context.parameters.CommandName))
            {
                Time(client.Context.parameters);
                client.Context.command = null;
                client.Context.parameters = null;
            }
            else
            {
                base.Handle(client);
            }
        }

        private void Time(CommandParameters parameters)
        {
            parameters.Socket.Send(BitConverter.GetBytes(DateTime.UtcNow.Ticks));

        }
    }
}
