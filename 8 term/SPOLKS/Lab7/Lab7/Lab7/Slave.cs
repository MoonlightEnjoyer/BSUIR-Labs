using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace Lab7
{
    public class Slave
    {
        public int Rank { get; set; }

        public IPEndPoint SlaveEP { get; set; }

        public int Row { get; set; }

        public int Column { get; set; }

        public bool Free { get; set; }
    }
}
