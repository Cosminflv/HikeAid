# running_app

SwiftStride is the go-to app for runners of all levels, offering powerful tools to enhance your running experience. Key features include:

Localization and Geographic Search: Quickly find running routes and trails nearby, no matter where you are. Discover new paths tailored to your preferences with detailed maps and terrain insights.

Route Calculation and Navigation: Plan your ideal run with optimized route suggestions based on distance, elevation, and surface type. Real-time navigation ensures you stay on track, even in unfamiliar areas.

Run Recording and Analytics: Track every step with precision. Record metrics like distance, pace, elevation, and calories burned. Analyze your performance with comprehensive stats and visualizations.

Whether you're training for a marathon, exploring scenic trails, or just enjoying a jog, SwiftStride combines smart technology and seamless navigation to make every run a rewarding journey.

### Installation guide

1. Make sure flutter framework is installed on your machine. Follow [instructions](https://docs.flutter.dev/get-started/install)

2. Configure Maps & Navigation SDK by following downloading [GemKit SDK for flutter](https://developer.magiclane.com/api/sdk/) and adding it to plugins directory.

3. Authorize Map & Navigation SDK by [getting a key](https://developer.magiclane.com/documentation/Flutter/guide_getting_started.php) and passing it to the environment variable ``GEM_API_TOKEN`` inside a ``launch.json``.

4. Make sure server is running on current IPv4 Address. Also fill the ``IPV4_ADDRESS`` field in launch.json. Make sure the server and client are running on the name port, eg. "7011"

```dart
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Debug",
            "type": "dart",
            "request": "launch",
            "flutterMode": "debug",
            "program": "lib/main.dart",
            "args": [
                "--dart-define",
                "GEM_API_TOKEN=YOUR_API_KEY",
                "--dart-define",
                "IPV4_ADDRESS=YOUR_IPV4_ADDRESS"
            ]
        },
        {
            "name": "Release",
            "type": "dart",
            "request": "launch",
            "flutterMode": "release",
            "program": "lib/main.dart",
            "args": [
                "--dart-define",
                "IPV4_ADDRESS=YOUR_IPV4_ADDRESS",
                "--dart-define",
                "GEM_API_TOKEN=YOUR_API_KEY"
            ]
        }
    ]
}
```

### OpenAPI Generator:

1. **Generate the Dart API client code using OpenAPI Generator**  
   Run the following command to generate the Dart client from your `api.json` definition:
   
   java -jar openapi-generator-cli-7.8.0.jar generate -i api.json -g dart-dio -o api

2. **Change directory to**
    
    cd api

3. **Run the build_runner**

    flutter pub run build_runner build --delete-conflicting-outputs

### Bibliography

[MagicLane SDK](https://developer.magiclane.com/documentation/Flutter/index.php)
[OpenAPI Generator](https://github.com/OpenAPITools/openapi-generator)
[Flutter Framework](https://docs.flutter.dev/get-started/install)
[BLoC](https://pub.dev/packages/flutter_bloc)