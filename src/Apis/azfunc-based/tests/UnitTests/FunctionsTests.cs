using Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.Net.Http.Json;
using Xunit;
using UnitTests.TestData;
using Api;
using Moq;
using Microsoft.AspNetCore.Routing;

namespace Functions.Tests
{
    public class FunctionsTests
    {
        // private readonly IProductData productData;
        private readonly ILogger logger = TestFactory.CreateLogger();
        protected List<Product> expectedProducts = AZFUNCFixture.GetData();

        // public FunctionsTests(IProductData productData)
        // {
        //     TestData = AZFUNCFixture.GetData();
        //     this.productData = productData;
        // }

        // [Fact]
        // public async void Http_trigger_return_all_items()
        // {
        //     //arrange
        //     var request = TestFactory.CreateHttpRequest();

        //     //act
        //     var azurefunction = new ProductsGet(productData);
        //     var response = (HttpResponseMessage)await azurefunction.Run(request, logger);
        //     var responseTask = response.Content.ReadFromJsonAsync<List<Product>>();

        //     //assert
        //     Assert.True(true, "true will always be true");
        //     //Assert.Equal(TestData.Length, responseTask.Result?.Count);


        // }

        [Fact]
        public async Task TestProductsGet()
        {
            // Arrange
            var request = TestFactory.CreateHttpRequest();
            var mockProductData = new Mock<IProductData>();
            mockProductData.Setup(x => x.GetProducts()).ReturnsAsync(expectedProducts);

            var function = new ProductsGet(mockProductData.Object);

            // Act
            var result = await function.Run(request, logger);

            // Assert
            var okResult = result as OkObjectResult;
            Assert.NotNull(okResult);

            var products = okResult.Value as IEnumerable<Product>;
            Assert.Equal(expectedProducts.Count(), products.Count());
        }


        [Fact]
        public async Task ProductsDelete_ShouldReturnBadRequestResult()
        {
            // Arrange
            var request = TestFactory.CreateHttpRequest();
            int unexistingProductId = -1;
            var routeData = new RouteData();
            routeData.Values.Add("productId", unexistingProductId);
            request.HttpContext.Items["MS_HttpRouteData"] = routeData;

            var mockProductData = new Mock<IProductData>();
            mockProductData.Setup(x => x.DeleteProduct(unexistingProductId)).ReturnsAsync(false); // return false for delete operation

            var function = new ProductsDelete(mockProductData.Object);

            // Act
            var result = await function.Run(request, unexistingProductId, logger);

            // Assert
            var badRequestResult = result as BadRequestResult;
            Assert.NotNull(badRequestResult);
        }

        [Fact]
        public async Task ProductsDelete_ShouldReturnOkResult()
        {
            var request = TestFactory.CreateHttpRequest();
            int existingProductId = 10;
            var routeData = new RouteData();
            routeData.Values.Add("productId", existingProductId);
            request.HttpContext.Items["MS_HttpRouteData"] = routeData;

            var mockProductData = new Mock<IProductData>();
            mockProductData.Setup(x => x.DeleteProduct(existingProductId)).ReturnsAsync(true);
            var function = new ProductsDelete(mockProductData.Object);

            // Act
            var result = await function.Run(request, existingProductId, logger);

            // Assert
            Assert.IsType<OkResult>(result);
            mockProductData.Verify(x => x.DeleteProduct(existingProductId), Times.Once);
        }
    }
}