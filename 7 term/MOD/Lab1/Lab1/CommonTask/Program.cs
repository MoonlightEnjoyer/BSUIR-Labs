int r0, r1, number;
Console.WriteLine("Enter first number:");
string input= Console.ReadLine();
int.TryParse(input, out r0);
Console.WriteLine("Enter second number:");
input = Console.ReadLine();
int.TryParse(input, out r1);
Console.WriteLine("Count of numbers to generate:");
input = Console.ReadLine();
int.TryParse(input, out number);
int[] numbers = new int[number + 2];
numbers[0] = r0;
numbers[1] = r1;
string sn;
int tempInt;
for (int i = 2; i < numbers.Length; i++)
{
    tempInt = numbers[i - 2] * numbers[i - 1];
    sn = tempInt.ToString();
    numbers[i] = int.Parse(sn[(sn.Length / 4)..^(sn.Length / 4)]);
    Console.WriteLine(numbers[i]);
}

