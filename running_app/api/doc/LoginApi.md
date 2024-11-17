# openapi.api.LoginApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiLoginLoginPost**](LoginApi.md#apiloginloginpost) | **POST** /api/Login/login | 
[**apiLoginRegisterPost**](LoginApi.md#apiloginregisterpost) | **POST** /api/Login/register | 


# **apiLoginLoginPost**
> apiLoginLoginPost(loginDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getLoginApi();
final LoginDto loginDto = ; // LoginDto | 

try {
    api.apiLoginLoginPost(loginDto);
} catch on DioException (e) {
    print('Exception when calling LoginApi->apiLoginLoginPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginDto** | [**LoginDto**](LoginDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiLoginRegisterPost**
> apiLoginRegisterPost(userDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getLoginApi();
final UserDto userDto = ; // UserDto | 

try {
    api.apiLoginRegisterPost(userDto);
} catch on DioException (e) {
    print('Exception when calling LoginApi->apiLoginRegisterPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userDto** | [**UserDto**](UserDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

