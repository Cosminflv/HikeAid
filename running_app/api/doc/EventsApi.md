# openapi.api.EventsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**eventsStreamGet**](EventsApi.md#eventsstreamget) | **GET** /Events/stream | 


# **eventsStreamGet**
> eventsStreamGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getEventsApi();

try {
    api.eventsStreamGet();
} catch on DioException (e) {
    print('Exception when calling EventsApi->eventsStreamGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

