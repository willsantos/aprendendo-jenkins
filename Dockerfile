FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app
COPY . ./
RUN dotnet restore
COPY . ./
RUN dotnet publish -c Release -o out 
ENTRYPOINT [ "dotnet", "/app/jenkins-teste.dll" ]
FROM mcr.microsoft.com/dotnet/runtime:6.0
ENV TZ="America/Sao_Paulo"
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "jenkins-teste.dll"] 