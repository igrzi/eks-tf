# Use the official .NET SDK image to build the app
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copy everything and build
COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

RUN mkdir empty datadog

# Download the DataDog APM tarball
RUN curl -LO "https://github.com/DataDog/dd-trace-dotnet/releases/download/v2.56.0/datadog-dotnet-apm-2.56.0.tar.gz"
RUN tar -C datadog/ -xzf datadog-dotnet-apm-2.56.0.tar.gz

# ======== STEP 2 ======== #

# Use the official ASP.NET Core Runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0

# Install curl
RUN apt-get update && apt-get install -y curl

WORKDIR /app
COPY --from=build-env /app/out .

COPY --from=build-env /app/datadog /opt/datadog/
COPY --chown=$APP_UID --from=build-env /app/empty /var/log/datadog/dotnet/

EXPOSE 80

ENTRYPOINT ["dotnet", "/app/MeuSite.dll"]
