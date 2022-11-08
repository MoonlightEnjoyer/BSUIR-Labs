using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ClientApp.CommandHandlers
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
            byte[] bytes = new byte[1024];
            while (!parameters.Socket.Poll(1, SelectMode.SelectRead))
            {
            }
            int recBytes = parameters.Socket.Receive(bytes, bytes.Length, SocketFlags.None);
            var res = AckSystem.ResendAck(bytes[..recBytes], parameters.Socket);
            if (res is null)
            {
                return;
            }

            DateTime time = new DateTime(BitConverter.ToInt64(res, 0), DateTimeKind.Utc);
            while (!parameters.Socket.Poll(1, SelectMode.SelectWrite))
            {
            }
            parameters.Socket.Send(Encoding.UTF8.GetBytes("ACKTIME"));
            Console.WriteLine(time.ToLocalTime());
        }   
    }
}
