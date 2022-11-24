using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ServerApp.CommandHandlers
{
    public abstract class CommandHandlerBase : ICommandHandler
    {
        private ICommandHandler nextHandler;

        public abstract bool CanHandle(string commandName);

        public virtual object Handle(Client client)
        {
            if (nextHandler != null)
            {
                return nextHandler.Handle(client);
            }

            return null;
        }

        public void SetNext(ICommandHandler handler)
        {
            nextHandler = handler;
        }
    }
}
