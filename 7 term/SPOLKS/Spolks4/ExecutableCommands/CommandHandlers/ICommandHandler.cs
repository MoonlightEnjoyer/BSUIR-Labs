using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExecutableCommands.CommandHandlers
{
    public interface ICommandHandler
    {
        public void SetNext(ICommandHandler handler);

        public void Handle(CommandParameters commandParameters);

        public bool CanHandle(string commandName);
    }
}
