using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Lehmer
{

    public class Lehmer
    {
        private const int a = 11817;
        private const int m = 36471;
        private int seed;
        public static int e = 20;

        public Lehmer(int seed)
        {
            if (seed <= 0 || seed == int.MaxValue)
                throw new Exception("Bad seed");
            this.seed = seed;


        }

        public int Next2()
        {
            int z1 = ((a * Program.ri) % m);

            return z1;
        }


        class Program
        {

            public static int ri = 7;
            static void Main(string[] args)
            {

                int[] counts = new int[20];

                Lehmer lehmer = new Lehmer(1);
                for (int i = 0; i < 10000; ++i)
                {
                    ri = lehmer.Next2();
                    int z1 = ri % Lehmer.e;
                    ++counts[z1];
                }
                for (int i = 0; i < counts.Length; ++i)
                {
                    Console.WriteLine("" + counts[i]);
                }
                Console.ReadLine();
            }
        }
    }
}
