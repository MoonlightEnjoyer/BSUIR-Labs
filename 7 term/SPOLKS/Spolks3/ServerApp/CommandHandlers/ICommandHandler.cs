using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ServerApp.CommandHandlers
{
    public interface ICommandHandler
    {
        public void SetNext(ICommandHandler handler);

        public object Handle(Client client);

        public bool CanHandle(string commandName);
    }
}
