# openapi.api.UserApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiUserAcceptFriendRequestPost**](UserApi.md#apiuseracceptfriendrequestpost) | **POST** /api/User/acceptFriendRequest | 
[**apiUserDeclineFriendRequestPost**](UserApi.md#apiuserdeclinefriendrequestpost) | **POST** /api/User/declineFriendRequest | 
[**apiUserGet**](UserApi.md#apiuserget) | **GET** /api/User | 
[**apiUserGetFriendRequestsGet**](UserApi.md#apiusergetfriendrequestsget) | **GET** /api/User/getFriendRequests | 
[**apiUserIdDeleteProfilePicturePost**](UserApi.md#apiuseriddeleteprofilepicturepost) | **POST** /api/User/{id}/deleteProfilePicture | 
[**apiUserIdGetProfilePictureGet**](UserApi.md#apiuseridgetprofilepictureget) | **GET** /api/User/{id}/getProfilePicture | 
[**apiUserIdUploadProfilePictureBase64Post**](UserApi.md#apiuseriduploadprofilepicturebase64post) | **POST** /api/User/{id}/uploadProfilePictureBase64 | 
[**apiUserLoginPost**](UserApi.md#apiuserloginpost) | **POST** /api/User/login | 
[**apiUserPost**](UserApi.md#apiuserpost) | **POST** /api/User | 
[**apiUserSendFriendRequestPost**](UserApi.md#apiusersendfriendrequestpost) | **POST** /api/User/sendFriendRequest | 


# **apiUserAcceptFriendRequestPost**
> apiUserAcceptFriendRequestPost(requestId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final int requestId = 56; // int | 

try {
    api.apiUserAcceptFriendRequestPost(requestId);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserAcceptFriendRequestPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestId** | **int**|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserDeclineFriendRequestPost**
> apiUserDeclineFriendRequestPost(requestId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final int requestId = 56; // int | 

try {
    api.apiUserDeclineFriendRequestPost(requestId);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserDeclineFriendRequestPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestId** | **int**|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserGet**
> apiUserGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();

try {
    api.apiUserGet();
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserGetFriendRequestsGet**
> BuiltList<FriendshipModel> apiUserGetFriendRequestsGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();

try {
    final response = api.apiUserGetFriendRequestsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserGetFriendRequestsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;FriendshipModel&gt;**](FriendshipModel.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserIdDeleteProfilePicturePost**
> apiUserIdDeleteProfilePicturePost(id, userId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final String id = id_example; // String | 
final int userId = 56; // int | 

try {
    api.apiUserIdDeleteProfilePicturePost(id, userId);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserIdDeleteProfilePicturePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **userId** | **int**|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserIdGetProfilePictureGet**
> String apiUserIdGetProfilePictureGet(id, userId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final String id = id_example; // String | 
final int userId = 56; // int | 

try {
    final response = api.apiUserIdGetProfilePictureGet(id, userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserIdGetProfilePictureGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **userId** | **int**|  | [optional] 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserIdUploadProfilePictureBase64Post**
> apiUserIdUploadProfilePictureBase64Post(id, userId, body)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final String id = id_example; // String | 
final int userId = 56; // int | 
final String body = BYTE_ARRAY_DATA_HERE; // String | 

try {
    api.apiUserIdUploadProfilePictureBase64Post(id, userId, body);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserIdUploadProfilePictureBase64Post: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **userId** | **int**|  | [optional] 
 **body** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserLoginPost**
> apiUserLoginPost(loginDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final LoginDto loginDto = ; // LoginDto | 

try {
    api.apiUserLoginPost(loginDto);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserLoginPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginDto** | [**LoginDto**](LoginDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserPost**
> apiUserPost(userDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final UserDto userDto = ; // UserDto | 

try {
    api.apiUserPost(userDto);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userDto** | [**UserDto**](UserDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserSendFriendRequestPost**
> apiUserSendFriendRequestPost(requesterId, receiverId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final int requesterId = 56; // int | 
final int receiverId = 56; // int | 

try {
    api.apiUserSendFriendRequestPost(requesterId, receiverId);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserSendFriendRequestPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requesterId** | **int**|  | [optional] 
 **receiverId** | **int**|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

