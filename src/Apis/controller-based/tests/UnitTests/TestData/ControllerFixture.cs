using Data;

namespace UnitTests.ControllerTestData
{
    public class ControllerFixture
    {
        public static List<Product> GetData()
        {
            return new List<Product>
            {
                new Product
                {
                    Id = 10,
                    Name = "Strawberries",
                    Description = "16oz package of fresh organic strawberries",
                    Quantity = 1
                },
                new Product
                {
                    Id = 20,
                    Name = "Sliced bread",
                    Description = "Loaf of fresh sliced wheat bread",
                    Quantity = 1
                },
                new Product
                {
                    Id = 30,
                    Name = "Apples",
                    Description = "Bag of 7 fresh McIntosh apples",
                    Quantity = 1
                }
            };
        }
    }
}