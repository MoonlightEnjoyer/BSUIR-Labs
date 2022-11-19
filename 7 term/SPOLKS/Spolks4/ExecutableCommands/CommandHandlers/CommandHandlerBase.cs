using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExecutableCommands.CommandHandlers
{
    public abstract class CommandHandlerBase : ICommandHandler
    {
        private ICommandHandler nextHandler;

        public abstract bool CanHandle(string commandName);

        public virtual void Handle(CommandParameters commandParameters)
        {
            if (nextHandler != null)
            {
                nextHandler.Handle(commandParameters);
            }
        }

        public void SetNext(ICommandHandler handler)
        {
            nextHandler = handler;
        }
    }
}
