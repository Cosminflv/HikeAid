# running_app

A new Flutter project.

### Steps to follow:

1. **Generate the Dart API client code using OpenAPI Generator**  
   Run the following command to generate the Dart client from your `api.json` definition:
   
   java -jar openapi-generator-cli-7.8.0.jar generate -i api.json -g dart-dio -o api

2. **Change directory to**
    
    cd api

3. **Run the build_runner**

    flutter pub run build_runner build --delete-conflicting-outputs