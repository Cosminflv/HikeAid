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
[**apiUserIdFriendsNumberGet**](UserApi.md#apiuseridfriendsnumberget) | **GET** /api/User/{id}/friendsNumber | 
[**apiUserIdGetProfilePictureGet**](UserApi.md#apiuseridgetprofilepictureget) | **GET** /api/User/{id}/getProfilePicture | 
[**apiUserIdGetUserGet**](UserApi.md#apiuseridgetuserget) | **GET** /api/User/{id}/getUser | 
[**apiUserIdPut**](UserApi.md#apiuseridput) | **PUT** /api/User/{id} | 
[**apiUserIdUploadProfilePictureBase64Post**](UserApi.md#apiuseriduploadprofilepicturebase64post) | **POST** /api/User/{id}/uploadProfilePictureBase64 | 
[**apiUserSearchUserGet**](UserApi.md#apiusersearchuserget) | **GET** /api/User/searchUser | 
[**apiUserSendFriendRequestPost**](UserApi.md#apiusersendfriendrequestpost) | **POST** /api/User/sendFriendRequest | 
[**getDefaultProfilePictureGet**](UserApi.md#getdefaultprofilepictureget) | **GET** /getDefaultProfilePicture | 


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

[Bearer](../README.md#Bearer)

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

[Bearer](../README.md#Bearer)

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

[Bearer](../README.md#Bearer)

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

[Bearer](../README.md#Bearer)

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

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserIdFriendsNumberGet**
> int apiUserIdFriendsNumberGet(id, userId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final String id = id_example; // String | 
final int userId = 56; // int | 

try {
    final response = api.apiUserIdFriendsNumberGet(id, userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserIdFriendsNumberGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **userId** | **int**|  | [optional] 

### Return type

**int**

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

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

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserIdGetUserGet**
> apiUserIdGetUserGet(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final int id = 56; // int | 

try {
    api.apiUserIdGetUserGet(id);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserIdGetUserGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserIdPut**
> apiUserIdPut(id, updateUserDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final String id = id_example; // String | 
final UpdateUserDto updateUserDto = ; // UpdateUserDto | 

try {
    api.apiUserIdPut(id, updateUserDto);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateUserDto** | [**UpdateUserDto**](UpdateUserDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

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

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserSearchUserGet**
> BuiltList<SearchUserDto> apiUserSearchUserGet(querry, userSearchingId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final String querry = querry_example; // String | 
final int userSearchingId = 56; // int | 

try {
    final response = api.apiUserSearchUserGet(querry, userSearchingId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserSearchUserGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **querry** | **String**|  | [optional] 
 **userSearchingId** | **int**|  | [optional] 

### Return type

[**BuiltList&lt;SearchUserDto&gt;**](SearchUserDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

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

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDefaultProfilePictureGet**
> getDefaultProfilePictureGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();

try {
    api.getDefaultProfilePictureGet();
} catch on DioException (e) {
    print('Exception when calling UserApi->getDefaultProfilePictureGet: $e\n');
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

