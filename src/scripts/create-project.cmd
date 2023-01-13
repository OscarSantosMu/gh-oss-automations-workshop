:: Navigate back to the root folder.
cd ../..

:: Create solution and navigate to src folder.
dotnet new sln -o src
cd src

:: Create data project which store Models for the api and the client.
dotnet new classlib -f net6.0 -o Data
cd Data
del Class1.cs
mkdir Models
:: Replace files from mslearn project
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Data/Product.cs > Models/Product.cs
cd ..
dotnet sln add ./Data/Data.csproj
cd Apis/controller-based
dotnet sln add ../../Data/Data.csproj
cd ../..

:: Create a client blazor wasm project and add a reference to data project.
dotnet new blazorwasm -f net6.0 -o Client
:: Replace files from mslearn project
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/_Imports.razor > Client/_Imports.razor
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/Program.cs > Client/Program.cs
:: Shared
mkdir "Client/Shared/Products"
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/Shared/Products/ProductList.razor > Client/Shared/Products/ProductList.razor
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/Shared/ButtonFooter.razor > Client/Shared/ButtonFooter.razor
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/Shared/CardContent.razor > Client/Shared/CardContent.razor
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/Shared/HeaderBar.razor > Client/Shared/HeaderBar.razor
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/Shared/InputDetail.razor > Client/Shared/InputDetail.razor
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/Shared/ListHeader.razor > Client/Shared/ListHeader.razor
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/Shared/MainLayout.razor > Client/Shared/MainLayout.razor
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/Shared/ModalYesNo.razor > Client/Shared/ModalYesNo.razor
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/Shared/NavMenu.razor > Client/Shared/NavMenu.razor
timeout 5
:: Pages
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/Pages/Products.razor > Client/Pages/Products.razor
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/Pages/ProductDetails.razor > Client/Pages/ProductDetails.razor
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/Pages/Index.razor > Client/Pages/Index.razor
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/Pages/About.razor > Client/Pages/About.razor
timeout 5
:: wwwroot
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/wwwroot/css/app.css > Client/wwwroot/css/app.css
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/wwwroot/index.html > Client/wwwroot/index.html
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Client/wwwroot/appsettings.Development.json > Client/wwwroot/appsettings.Development.json
:: 
dotnet add Client/Client.csproj reference Data/Data.csproj
dotnet sln add ./Client/Client.csproj

:: Create Web API project and add a reference to data project.
dotnet new webapi -f net6.0 -o Apis/controller-based/web
cd Apis/controller-based/web
move WeatherForecast.cs ../../../Data/Models
cd ..
dotnet new sln
dotnet sln add ./web/web.csproj
cd ../..
dotnet add Apis/controller-based/web/web.csproj reference Data/Data.csproj


:: Creates azure function API
dotnet new classlib -f net6.0 -o Apis/azfunc-based/trigger
cd Apis/azfunc-based/trigger
:: Replace files from mslearn project.
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Api/Startup.cs > Startup.cs
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Api/Api.csproj > trigger.csproj
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Api/host.json > host.json
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Api/local.settings.example.json > local.settings.example.json
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Api/local.settings.example.json > local.settings.json
timeout 5
::
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Api/ProductData.cs > ProductData.cs
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Api/ProductsDelete.cs > ProductsDelete.cs
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Api/ProductsPost.cs > ProductsPost.cs
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Api/ProductsPut.cs > ProductsPut.cs
timeout 5
::
mkdir Properties
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/solution/Api/Properties/launchSettings.json > Properties/launchSettings.json
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Api/Properties/serviceDependencies.json > Properties/serviceDependencies.json 
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/main/Api/Properties/serviceDependencies.local.json > Properties/serviceDependencies.local.json 
curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-staticwebapp-dotnet/solution/Api/ProductsGet.cs > ProductsGet.cs
del Class1.cs
cd ../../..
echo Remplaza el path por ..\..\..\Data\Data.csproj
Pause
dotnet add Apis/azfunc-based/trigger/trigger.csproj reference Data/Data.csproj
dotnet sln add ./Apis/azfunc-based/trigger/trigger.csproj

:: Create Unit tests for the Web API.
dotnet new xunit -f net6.0 -o Apis/controller-based/tests/UnitTests
cd Apis/controller-based
dotnet add ./tests/UnitTests/UnitTests.csproj reference ./web/web.csproj
cd tests/UnitTests
dotnet add package Moq --version 4.18.4
del UnitTest1.cs
mkdir ControllerTests
mkdir TestData
cd ../..
dotnet sln add ./tests/UnitTests/UnitTests.csproj
cd ../..


:: Create Unit tests for the Azure Functions API.
dotnet new xunit -f net6.0 -o Apis/azfunc-based/tests/UnitTests
cd Apis/azfunc-based
dotnet add ./tests/UnitTests/UnitTests.csproj reference ./trigger/trigger.csproj
cd tests/UnitTests
dotnet add package Microsoft.AspNetCore.Mvc
dotnet add package Microsoft.Extensions.Logging.Abstractions --version 6.0.0
curl https://raw.githubusercontent.com/Azure-Samples/azure-functions-tests/master/csharp-visualstudio/Functions.Tests/LoggerTypes.cs > LoggerTypes.cs
curl https://raw.githubusercontent.com/Azure-Samples/azure-functions-tests/master/csharp-visualstudio/Functions.Tests/ListLogger.cs > ListLogger.cs
curl https://raw.githubusercontent.com/Azure-Samples/azure-functions-tests/master/csharp-visualstudio/Functions.Tests/TestFactory.cs > TestFactory.cs
curl https://raw.githubusercontent.com/madebygps/cgc-azure-resume/main/backend/tests/NullScope.cs > NullScope.cs
mkdir TestData
echo Remplace namespace name in NullScope with Functions.Tests
Pause
ren UnitTest1.cs FunctionsTests.cs
cd ../../../..
dotnet sln add ./Apis/azfunc-based/tests/UnitTests/UnitTests.csproj

:: Create Integration tests for the Web API.
dotnet new xunit -f net6.0 -o Apis/controller-based/tests/IntegrationTests
cd Apis/controller-based
cd tests/IntegrationTests
dotnet add package Moq --version 4.18.4
cd ../..
dotnet add ./tests/IntegrationTests/IntegrationTests.csproj reference ./web/web.csproj
dotnet sln add ./tests/IntegrationTests/IntegrationTests.csproj
cd ../..

mkdir .devcontainer
cd .devcontainer
curl https://raw.githubusercontent.com/microsoft/dotnetconf-studentzone/main/.devcontainer/post-create.sh > post-create.sh
curl https://raw.githubusercontent.com/microsoft/dotnetconf-studentzone/main/.devcontainer/devcontainer.json > devcontainer.json
curl https://raw.githubusercontent.com/microsoft/dotnetconf-studentzone/main/.devcontainer/Dockerfile > Dockerfile
cd ../..
curl https://raw.githubusercontent.com/github/gitignore/main/VisualStudio.gitignore > .gitignore
cd src