echo This script is meant to be run from src/scripts folder
:: Navigate back to the root folder.
cd ../..

:: Create solution and navigate to src folder.
dotnet new sln -o src
cd src

:: Create data project which store Models for the api and the client.
dotnet new classlib -f net6.0 -o Data
cd Data
mkdir Models
:: Replace files from mslearn project
cd ..
dotnet sln add ./Data/Data.csproj

:: Create a client blazor wasm project and add a reference to data project.
dotnet new blazorwasm -f net6.0 -o Client
dotnet add Client/Client.csproj reference Data/Data.csproj
dotnet sln add ./Client/Client.csproj

:: Create Web API project and add a reference to data project.
dotnet new webapi -f net6.0 -o Apis/controller-based/web
cd Apis/controller-based/web
move WeatherForecast.cs ../../../Data/Models
cd ../../..
dotnet add Apis/controller-based/web/web.csproj reference Data/Data.csproj
dotnet sln add ./Apis/controller-based/web/web.csproj

:: Creates azure function API
dotnet new classlib -f net6.0 -o Apis/azfunc-based/trigger
cd Apis/azfunc-based/trigger
mkdir Properties
cd ../../..
dotnet add Apis/azfunc-based/trigger/trigger.csproj reference Data/Data.csproj
dotnet sln add ./Apis/azfunc-based/trigger/trigger.csproj

:: Create Unit tests for the Web API.
dotnet new xunit -o Apis/controller-based/tests/UnitTests -f net6.0
cd Apis/controller-based
dotnet add ./tests/UnitTests/UnitTests.csproj reference ./web/web.csproj
cd tests/UnitTests
del UnitTest1.cs
mkdir ControllerTests
mkdir TestData
cd ../../../..
dotnet sln add ./Apis/controller-based/tests/UnitTests/UnitTests.csproj

:: Create Unit tests for the Azure Functions API.
dotnet new xunit -o Apis/azfunc-based/tests/UnitTests
cd Apis/azfunc-based
dotnet add ./tests/UnitTests/UnitTests.csproj reference ./trigger/trigger.csproj
cd tests/UnitTests
dotnet add package Microsoft.AspNetCore.Mvc
dotnet add package Microsoft.Extensions.Logging.Abstractions --version 6.0.0
mkdir TestData
ren UnitTest1.cs FunctionsTests.cs
cd ../../../..
dotnet sln add ./Apis/azfunc-based/tests/UnitTests/UnitTests.csproj

:: Create Integration tests for the Web API.
dotnet new xunit -o Apis/controller-based/tests/IntegrationTests
cd Apis/controller-based
dotnet add ./tests/IntegrationTests/IntegrationTests.csproj reference ./web/web.csproj
cd ../..
dotnet sln add ./Apis/controller-based/tests/IntegrationTests/IntegrationTests.csproj

mkdir IaC
cd IaC
mkdir bicep
mkdir terraform
cd ..

mkdir .github
mkdir .devcontainer
cd .devcontainer
curl https://raw.githubusercontent.com/microsoft/dotnetconf-studentzone/main/.devcontainer/post-create.sh > post-create.sh
curl https://raw.githubusercontent.com/microsoft/dotnetconf-studentzone/main/.devcontainer/devcontainer.json > devcontainer.json
curl https://raw.githubusercontent.com/microsoft/dotnetconf-studentzone/main/.devcontainer/Dockerfile > Dockerfile
cd ../..
curl https://raw.githubusercontent.com/github/gitignore/main/VisualStudio.gitignore > .gitignore
cd src
