# Use the official .NET SDK image to build and publish the app
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /source

COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app --no-restore

# Use the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app .

EXPOSE 80
ENTRYPOINT ["dotnet", "LoginApp.dll"]
