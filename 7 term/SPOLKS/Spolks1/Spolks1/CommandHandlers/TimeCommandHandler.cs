using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spolks1.CommandHandlers
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
            parameters.Socket.Send(Encoding.ASCII.GetBytes(DateTime.UtcNow.ToString()));
        }
    }
}
