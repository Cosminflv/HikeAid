# running_app

A new Flutter project.

java -jar openapi-generator-cli-7.8.0.jar generate -i api.json -g dart-dio -o api
cd api
flutter pub run build_runner build --delete-conflicting-outputs