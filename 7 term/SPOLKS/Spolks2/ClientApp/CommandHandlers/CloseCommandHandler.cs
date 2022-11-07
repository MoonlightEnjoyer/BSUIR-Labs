using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ClientApp.CommandHandlers
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
            byte[] bytes = new byte[1024];
            parameters.Socket.ReceiveTimeout = 100;
            try
            {
                int recBytes = parameters.Socket.Receive(bytes, bytes.Length, SocketFlags.None);
                var res = AckSystem.ResendAck(bytes[..recBytes], parameters.Socket);
                if (res is null)
                {
                    return;
                }
            }
            catch (SocketException)
            {
                parameters.Socket.Shutdown(SocketShutdown.Both);
                parameters.Socket.Close();
            }
        }
    }
}
