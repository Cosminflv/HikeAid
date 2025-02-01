# openapi.api.AlertApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAlertAddAlertPost**](AlertApi.md#apialertaddalertpost) | **POST** /api/Alert/addAlert | 
[**apiAlertAlertIdImageGet**](AlertApi.md#apialertalertidimageget) | **GET** /api/Alert/{alertId}/image | 
[**apiAlertGetAllAlertsGet**](AlertApi.md#apialertgetallalertsget) | **GET** /api/Alert/GetAllAlerts | 


# **apiAlertAddAlertPost**
> apiAlertAddAlertPost(createdAt, expiresAt, title, description, alertType, isActive, latitude, longitude, imageFile)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAlertApi();
final DateTime createdAt = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime expiresAt = 2013-10-20T19:20:30+01:00; // DateTime | 
final String title = title_example; // String | 
final String description = description_example; // String | 
final String alertType = alertType_example; // String | 
final bool isActive = true; // bool | 
final double latitude = 1.2; // double | 
final double longitude = 1.2; // double | 
final MultipartFile imageFile = BINARY_DATA_HERE; // MultipartFile | 

try {
    api.apiAlertAddAlertPost(createdAt, expiresAt, title, description, alertType, isActive, latitude, longitude, imageFile);
} catch on DioException (e) {
    print('Exception when calling AlertApi->apiAlertAddAlertPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createdAt** | **DateTime**|  | 
 **expiresAt** | **DateTime**|  | 
 **title** | **String**|  | 
 **description** | **String**|  | 
 **alertType** | **String**|  | 
 **isActive** | **bool**|  | 
 **latitude** | **double**|  | 
 **longitude** | **double**|  | 
 **imageFile** | **MultipartFile**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAlertAlertIdImageGet**
> apiAlertAlertIdImageGet(alertId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAlertApi();
final int alertId = 56; // int | 

try {
    api.apiAlertAlertIdImageGet(alertId);
} catch on DioException (e) {
    print('Exception when calling AlertApi->apiAlertAlertIdImageGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **alertId** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAlertGetAllAlertsGet**
> apiAlertGetAllAlertsGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAlertApi();

try {
    api.apiAlertGetAllAlertsGet();
} catch on DioException (e) {
    print('Exception when calling AlertApi->apiAlertGetAllAlertsGet: $e\n');
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

