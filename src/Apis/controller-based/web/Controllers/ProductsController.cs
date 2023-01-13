using Data;
using Microsoft.AspNetCore.Mvc;

namespace web.Controllers;

[ApiController]
[Route("api/products")]
public class ProductsController : ControllerBase
{
    private readonly IProductData _productsService;
    private readonly ILogger<ProductsController> _logger;

    public ProductsController(IProductData productsService, ILogger<ProductsController> logger)
    {
        _productsService = productsService;
        _logger = logger;
    }

    [HttpGet]
    public ActionResult<IEnumerable<Product>> GetProducts()
    {
        var products = _productsService.GetProducts();
        return Ok(products);
    }

    [HttpGet("{id}")]
    public ActionResult<Product> GetProduct(int id)
    {
        var products = _productsService.GetProducts();
        var product = products.FirstOrDefault(product => product.Id == id);
        if (product == null)
        {
            return NotFound();
        }
        return Ok(product);
    }

    [HttpPost]
    public ActionResult<Product> AddProduct([FromBody] Product product)
    {
        var addedProduct = _productsService.AddProduct(product);
        return CreatedAtAction("AddProduct", new { id = addedProduct.Id }, addedProduct);
    }

    [HttpPut("{id}")]
    public ActionResult<Product> UpdateProduct(short id, [FromBody] Product product)
    {
        if (id != product.Id)
        {
            return BadRequest();
        }
        var updatedProduct = _productsService.UpdateProduct(product);
        return Ok(updatedProduct);
    }

    [HttpDelete("{id}")]
    public ActionResult<bool> DeleteProduct(int id)
    {
        var isDeleted = _productsService.DeleteProduct(id);
        if (isDeleted)
        {
            return NoContent();
        }
        else
        {
            return NotFound();
        }
    }

}
