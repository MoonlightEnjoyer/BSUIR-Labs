using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ClientApp.CommandHandlers
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
            byte[] bytes = new byte[1024];
            var recBytes = parameters.Socket.Receive(bytes, bytes.Length, SocketFlags.None);
            var res = AckSystem.ResendAck(bytes[..recBytes], parameters.Socket);
            if (res is null)
            {
                return;
            }

            parameters.Socket.Send(Encoding.UTF8.GetBytes("ACKECHO"));
            Console.WriteLine(Encoding.UTF8.GetString(res));
        }
    }
}
