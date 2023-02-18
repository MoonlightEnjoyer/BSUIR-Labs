using MatrixGenerator;

var matrix1 = Matrix.CreateMatrix(10, 10);
var matrix2 = Matrix.CreateMatrix(10, 10);

Matrix.WriteToFile("source_matrix1.txt", matrix1);

Matrix.WriteToFile("source_matrix2.txt", matrix2);

var result = Matrix.MultiplyMatrices(matrix1, matrix2);

Matrix.WriteToFile("reference_matrix.txt", result);