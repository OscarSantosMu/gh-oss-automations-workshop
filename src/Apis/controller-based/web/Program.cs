using Data;
using web.Controllers;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddCors(p => p.AddPolicy("corsapp", builder =>
   {
       builder.WithOrigins("https://localhost:7199").AllowAnyMethod().AllowAnyHeader();
   }));
builder.Services.AddScoped<IProductData, ProductData>();
builder.Services.AddSingleton<List<Product>>(new List<Product>
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
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("corsapp");
app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
