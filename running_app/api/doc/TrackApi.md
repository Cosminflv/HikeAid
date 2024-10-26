# openapi.api.TrackApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiTrackIdUploadTrackPost**](TrackApi.md#apitrackiduploadtrackpost) | **POST** /api/Track/{id}/uploadTrack | 
[**apiTrackIdUserTracksGet**](TrackApi.md#apitrackidusertracksget) | **GET** /api/Track/{id}/userTracks | 


# **apiTrackIdUploadTrackPost**
> apiTrackIdUploadTrackPost(id, trackDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTrackApi();
final String id = id_example; // String | 
final TrackDto trackDto = ; // TrackDto | 

try {
    api.apiTrackIdUploadTrackPost(id, trackDto);
} catch on DioException (e) {
    print('Exception when calling TrackApi->apiTrackIdUploadTrackPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **trackDto** | [**TrackDto**](TrackDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTrackIdUserTracksGet**
> BuiltList<TrackDto> apiTrackIdUserTracksGet(id, userId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTrackApi();
final String id = id_example; // String | 
final int userId = 56; // int | 

try {
    final response = api.apiTrackIdUserTracksGet(id, userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TrackApi->apiTrackIdUserTracksGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **userId** | **int**|  | [optional] 

### Return type

[**BuiltList&lt;TrackDto&gt;**](TrackDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

