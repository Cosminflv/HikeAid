# openapi.api.EventsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**eventsStreamChannelGet**](EventsApi.md#eventsstreamchannelget) | **GET** /Events/stream/{channel} | 


# **eventsStreamChannelGet**
> eventsStreamChannelGet(channel, userId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getEventsApi();
final String channel = channel_example; // String | 
final String userId = userId_example; // String | 

try {
    api.eventsStreamChannelGet(channel, userId);
} catch on DioException (e) {
    print('Exception when calling EventsApi->eventsStreamChannelGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channel** | **String**|  | 
 **userId** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

