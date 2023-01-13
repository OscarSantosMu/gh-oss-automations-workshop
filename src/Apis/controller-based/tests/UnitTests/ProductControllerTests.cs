using System;
using System.Net.Http.Json;
using Xunit;
using web.Controllers;
using Data;
using UnitTests.ControllerTestData;
using Moq;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Http.HttpResults;

namespace Controller.Tests
{
    public class ControllerTests
    {
    
        [Fact]
        public void GetProducts_ShouldReturnAllProducts()
        {
            // Arrange
            var mockProductData = new Mock<IProductData>();
            mockProductData.Setup(x => x.GetProducts()).Returns(ControllerFixture.GetData()); // setup the mock to return the desired data
            var logger = new NullLogger<ProductsController>();
            var controller = new ProductsController(mockProductData.Object, logger);

            // Act
            var result = controller.GetProducts();

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result.Result);
            var products = Assert.IsAssignableFrom<IEnumerable<Product>>(okResult.Value);
            Assert.Equal(ControllerFixture.GetData().Count(), products.Count());
            
        }

        [Fact]
        public async Task AddProduct_ShouldAddProduct()
        {
            // Arrange
            var product = new Product { Id = 40, Name = "Test Product", Description = "Test Description", Quantity = 1 };
            var productData = new Mock<IProductData>();
            productData.Setup(x => x.AddProduct(product)).Returns(product);
            var logger = new Mock<ILogger<ProductsController>>();
            var controller = new ProductsController(productData.Object, logger.Object);

            // Act
            var result = controller.AddProduct(product);
            // var returnedProduct = result.Value as Product;

            // Assert
            var createdResult = Assert.IsType<CreatedAtActionResult>(result.Result);
            var returnedProduct = Assert.IsType<Product>(createdResult.Value);
            Assert.Equal(product.Id, returnedProduct.Id);
            Assert.Equal(product.Name, returnedProduct.Name);
            Assert.Equal(product.Description, returnedProduct.Description);
            Assert.Equal(product.Quantity, returnedProduct.Quantity);
            productData.Verify(p => p.AddProduct(It.IsAny<Product>()), Times.Once());
        }

        [Fact]
        public async Task UpdateProduct_ShouldUpdateProduct()
        {
            // Arrange
            var product = new Product { Id = 30, Name = "Test Product", Description = "Test Description", Quantity = 1 };
            var productData = new Mock<IProductData>();
            productData.Setup(x => x.UpdateProduct(product)).Returns(product);
            var logger = new Mock<ILogger<ProductsController>>();
            var controller = new ProductsController(productData.Object, logger.Object);

            // Act
            var result = controller.UpdateProduct((short)product.Id, product);

            // Assert
            var okObjectResult = Assert.IsType<OkObjectResult>(result.Result);
            productData.Verify(x => x.UpdateProduct(It.Is<Product>(p => p.Id == 30 && p.Name == "Test Product" && p.Description == "Test Description" && p.Quantity == 1)));

        }

        [Fact]
        public async Task DeleteProduct_DeletesProduct()
        {
            // Arrange
            var product = new Product { Id = 30, Name = "Apples", Description = "Bag of 7 fresh McIntosh apples", Quantity = 1 };
            var mockProductData = new Mock<IProductData>();
            mockProductData.Setup(data => data.DeleteProduct(product.Id))
                .Returns(true)
                .Verifiable();
            var logger = new NullLogger<ProductsController>();
            var controller = new ProductsController(mockProductData.Object, logger);

            // Act
            var result = controller.DeleteProduct(product.Id);

            // Assert
            var noContentResult = Assert.IsType<NoContentResult>(result.Result);
            mockProductData.Verify();
        }

        [Fact]
        public void DeleteProduct_ProductNotFound_ShouldReturnNotFound()
        {
            // Arrange
            var mockProductData = new Mock<IProductData>();
            mockProductData.Setup(x => x.DeleteProduct(It.IsAny<int>()))
                          .Returns(false); // setup the mock to return false for a non-existent product
            var logger = new NullLogger<ProductsController>();
            var controller = new ProductsController(mockProductData.Object, logger);
            int id = -1;

            // Act
            var result = controller.DeleteProduct(id);

            // Assert
            Assert.IsType<NotFoundResult>(result.Result);
        }

    }
}