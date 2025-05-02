# openapi.api.TourApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiTourIdUploadTourPost**](TourApi.md#apitouriduploadtourpost) | **POST** /api/Tour/{id}/uploadTour | 
[**apiTourIdUserToursGet**](TourApi.md#apitouridusertoursget) | **GET** /api/Tour/{id}/userTours | 


# **apiTourIdUploadTourPost**
> apiTourIdUploadTourPost(id, tourDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTourApi();
final String id = id_example; // String | 
final TourDto tourDto = ; // TourDto | 

try {
    api.apiTourIdUploadTourPost(id, tourDto);
} catch on DioException (e) {
    print('Exception when calling TourApi->apiTourIdUploadTourPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **tourDto** | [**TourDto**](TourDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTourIdUserToursGet**
> BuiltList<TourDto> apiTourIdUserToursGet(id, userId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTourApi();
final String id = id_example; // String | 
final int userId = 56; // int | 

try {
    final response = api.apiTourIdUserToursGet(id, userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TourApi->apiTourIdUserToursGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **userId** | **int**|  | [optional] 

### Return type

[**BuiltList&lt;TourDto&gt;**](TourDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

