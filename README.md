# Automatiza la revisión de código y el despliegue en Azure con GitHub Actions

> Conferencia en evento presencial [GitHub Open Source CDMX](https://www.meetup.com/es/githublatam/events/289607041)  
> [🎥 Revive la conferencia en línea](https://www.twitch.tv/videos/1706631883?t=00h57m49s)


Evento             |  Presentación
:-------------------------:|:-------------------------:
![](static/img/foto-grupal.jpg)       |   ![](static/img/atras.jpg)


# Tabla de Contenido

1. [Contexto](#contexto)
2. [Ramas](#ramas)
    - [az-swa-accidentalbug](#az-swa-accidentalbug)
    - [webapi-deployment](#webapi-deployment)
    - [az-swa-deployment](#az-swa-deployment)
    - [feature/az-swa-deployment](#featureaz-swa-deployment)
3. [Enlaces](#enlaces)
    - [GitHub Codespaces](#github-codespaces)
    - [GitHub Actions](#github-actions)
    - [Unit Testing](#unit-testing)
    - [Azure Static Web Apps](#azure-static-web-apps)
    - [Azure Functions](#azure-functions)
    - [Visual Studio Code](#visual-studio-code)
    - [Debugging Resources](#debugging-resources)

## Contexto

Este proyecto es un [sample de Microsot Learn](https://github.com/MicrosoftDocs/mslearn-staticwebapp-dotnet) cuyo objetivo es enseñar a publicar una aplicación de Blazor WebAssembly y una API de .NET con Azure Static Web Apps.

Por otro lado, el devcontainer que se utilizó para crear el GitHub Codespace, proviene de la [.NET Conf Stundent Zone](https://github.com/microsoft/dotnetconf-studentzone).

## Ramas

A lo largo de los demos se utilizaron varias ramas para demostrar el potencial de las GitHub Actions.

Las cuales están enlistadas a continuación, en orden de aparición en la presentación:

- az-swa-accidentalbug
- webapi-deployment
- az-swa-deployment
- feature/az-swa-deployment

### az-swa-accidentalbug

Fue utilizada para demostrar que las pruebas arrojan un error al introducir un error en el proyecto.

### webapi-deployment

Solo fue mencionada cuando se despliega a través del App Deployment Center de Azure en la Web App.

### az-swa-deployment

Es utilizada para crear la SPA de Blazor WebAssembly con Azure Static Web Apps, la cual busca en la solución un proyecto de Azure Functions, de ser el caso, también publica esta API serverless en Azure.

### feature/az-swa-deployment

Fue utilizada para demostrar que la GitHub Action ejecuta operaciones distintas cuando se hace un pull request en vez de un push en la rama az-swa-deployment. Para esta situación, se despliega en un slot (para preview), que tendrá una URL distinta a la que está en producción.

## Enlaces

### GitHub Codespaces

- [GitHub Codespaces overview](https://github.com/features/codespaces)
- [GitHub Codespaces docs](https://docs.github.com/es/codespaces/overview)

### GitHub Actions

- [GitHub Actions overview](https://github.com/features/actions)
- [GitHub Codespaces docs](https://docs.github.com/es/actions)

### Unit Testing

- [Testing in .NET](https://learn.microsoft.com/en-us/dotnet/core/testing/?wt.mc_id=studentamb_118941)
- [Unit testing C# in .NET Core using dotnet test and xUnit](https://learn.microsoft.com/en-us/dotnet/core/testing/unit-testing-with-dotnet-test?wt.mc_id=studentamb_118941)

### Azure Static Web Apps

- Learn how to [Publish an Angular, React, Svelte, or Vue JavaScript app and API with Azure Static Web Apps](https://docs.microsoft.com/learn/modules/publish-app-service-static-web-app-api-dotnet?wt.mc_id=studentamb_118941)
- [API support in Azure Static Web Apps](https://docs.microsoft.com/azure/static-web-apps/apis?wt.mc_id=studentamb_118941)
- [Add an API to Azure Static Web Apps](https://docs.microsoft.com/azure/static-web-apps/add-api?wt.mc_id=studentamb_118941)
- [Authentication and authorization](https://docs.microsoft.com/azure/static-web-apps/authentication-authorization?wt.mc_id=studentamb_118941)
- [Routes](https://docs.microsoft.com/azure/static-web-apps/routes?wt.mc_id=studentamb_118941)
- [Review pre-production environments](https://docs.microsoft.com/azure/static-web-apps/review-publish-pull-requests?wt.mc_id=studentamb_118941)

### Azure Functions

- Learn about the Azure Functions [local.settings.json](https://docs.microsoft.com/azure/azure-functions/functions-run-local#local-settings-file?wt.mc_id=studentamb_118941) file
- Learn how to [Deploy to Azure Using Azure Functions](https://code.visualstudio.com/tutorials/functions-extension/getting-started?wt.mc_id=studentamb_118941)
- Sign up for a [Free Trial of Azure](https://azure.microsoft.com/free/?wt.mc_id=studentamb_118941)

### Visual Studio Code

- [Azure Free Trial](https://azure.microsoft.com/free/?wt.mc_id=studentamb_118941)
- [VS Code](https://code.visualstudio.com?wt.mc_id=studentamb_118941)
- [VS Code Extension for Node on Azure](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-node-azure-pack&WT.mc_id=mslearn_staticwebapp-github-aapowell)
- Azure Functions [local.settings.json](https://docs.microsoft.com/azure/azure-functions/functions-run-local#local-settings-file?WT.mc_id=mslearn_staticwebapp-github-aapowell) file

### Debugging Resources

- [Debugging Blazor WebAssembly](https://docs.microsoft.com/aspnet/core/blazor/debug?wt.mc_id=studentamb_118941)