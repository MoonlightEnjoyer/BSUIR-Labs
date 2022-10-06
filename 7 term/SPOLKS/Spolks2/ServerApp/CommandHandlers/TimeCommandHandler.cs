using Microsoft.Extensions.Configuration;
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

        public override void Handle(CommandParameters commandParameters)
        {
            if (CanHandle(commandParameters.CommandName))
            {
                Time(commandParameters);
            }
            else
            {
                base.Handle(commandParameters);
            }
        }

        private void Time(CommandParameters parameters)
        {
            parameters.Socket.Send(BitConverter.GetBytes(DateTime.UtcNow.Ticks));
        }
    }
}
