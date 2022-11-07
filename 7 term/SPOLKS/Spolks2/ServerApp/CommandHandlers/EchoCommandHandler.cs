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
            parameters.Socket.SendTo(Encoding.UTF8.GetBytes(String.Join(" ", parameters.Parameters)), parameters.DestinationIp);
            var buf = new byte[parameters.Socket.ReceiveBufferSize];
            var remoteIp = parameters.DestinationIp;
            int recBytes;
            while ((recBytes = parameters.Socket.ReceiveFrom(buf, ref remoteIp)) > 0)
            {
                if (Encoding.UTF8.GetString(buf[0..recBytes]) == "ACKECHO")
                {
                    return;
                }
                else
                {
                    parameters.Socket.SendTo(Encoding.UTF8.GetBytes("RACKECHO"), remoteIp);
                }
            }
        }
    }
}
