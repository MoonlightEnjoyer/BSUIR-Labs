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

        public virtual void Handle(Client client)
        {
            if (nextHandler != null)
            {
                nextHandler.Handle(client);
            }
        }

        public void SetNext(ICommandHandler handler)
        {
            nextHandler = handler;
        }
    }
}
