using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Data;

namespace web.Controllers;

public interface IProductData
{
    Product AddProduct(Product product);
    bool DeleteProduct(int id);
    IEnumerable<Product> GetProducts();
    Product UpdateProduct(Product product);
}

public class ProductData : IProductData
{
    private readonly List<Product> _products;

    public ProductData(List<Product> products)
    {
        _products = products;
    }

    private int GetRandomInt()
    {
        var random = new Random();
        return random.Next(100, 1000);
    }

    public Product AddProduct(Product product)
    {
        product.Id = GetRandomInt();
        _products.Add(product);
        return product;
    }

    public Product UpdateProduct(Product product)
    {
        var index = _products.FindIndex(p => p.Id == product.Id);
        _products[index] = product;
        return product;
    }

    public bool DeleteProduct(int id)
    {
        var index = _products.FindIndex(p => p.Id == id);
        _products.RemoveAt(index);
        return true;
    }

    public IEnumerable<Product> GetProducts()
    {
        return _products.AsEnumerable();
    }
}
