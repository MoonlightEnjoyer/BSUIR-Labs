namespace MatrixGenerator
{
    public static class Matrix
    {
        public static int[,] CreateMatrix(int m, int n)
        {
            int[,] matrix = new int[m, n];
            Random rand = new Random();
            for (int i = 0; i < m; i++)
            {
                for (int j = 0; j < n; j++)
                {
                    matrix[i, j] = rand.Next(-20, 20);
                }
            }

            return matrix;
        }

        public static int[,] MultiplyMatrices(int[,] m1, int[,] m2)
        {
            int[,] result = new int[m1.GetLength(0), m2.GetLength(1)];

            for (int i = 0; i < m1.GetLength(0); i++)
            {
                for (int j = 0; j < m2.GetLength(1); j++)
                {
                    for (int r = 0; r < m1.GetLength(1); r++)
                    {
                        result[i, j] += m1[i, r] * m2[r, j];
                    }
                }
            }

            return result;
        }

        public static bool CompareMatrices(int[,] m1, int[,] m2)
        {
            for (int i = 0; i < m1.GetLength(0); i++)
            {
                for (int j = 0; j < m1.GetLength(1); j++)
                {
                    if (m1[i, j] != m2[i, j])
                    {
                        return false;
                    }
                }
            }

            return true;
        }

        public static void WriteToFile(string filename, int[,] matrix)
        {
            using FileStream file = new FileStream(filename, FileMode.Create);
            using StreamWriter streamWriter= new StreamWriter(file);

            for (int i = 0; i < matrix.GetLength(0); i++)
            {
                for (int j = 0; j < matrix.GetLength(1); j++)
                {
                    streamWriter.Write(string.Format("{0,6}", matrix[i, j]));
                    streamWriter.Write(' ');
                }

                streamWriter.WriteLine();
            }
        }
    }
}