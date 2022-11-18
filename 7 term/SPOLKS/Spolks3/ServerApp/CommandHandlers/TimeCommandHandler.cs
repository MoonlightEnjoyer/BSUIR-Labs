﻿using System;
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
            if (CanHandle(client.Context.Parameters.CommandName))
            {
                Time(client.Context.Parameters);
                client.Context.Parameters.CommandName = null;
                client.Context.Parameters = null;
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
