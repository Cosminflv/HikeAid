# openapi.api.UserApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiUserAcceptFriendRequestPost**](UserApi.md#apiuseracceptfriendrequestpost) | **POST** /api/User/acceptFriendRequest | 
[**apiUserConfirmHikePost**](UserApi.md#apiuserconfirmhikepost) | **POST** /api/User/confirmHike | 
[**apiUserDeclineFriendRequestPost**](UserApi.md#apiuserdeclinefriendrequestpost) | **POST** /api/User/declineFriendRequest | 
[**apiUserDeleteProfilePicturePost**](UserApi.md#apiuserdeleteprofilepicturepost) | **POST** /api/User/deleteProfilePicture | 
[**apiUserGet**](UserApi.md#apiuserget) | **GET** /api/User | 
[**apiUserGetFriendRequestsGet**](UserApi.md#apiusergetfriendrequestsget) | **GET** /api/User/getFriendRequests | 
[**apiUserIdFriendsNumberGet**](UserApi.md#apiuseridfriendsnumberget) | **GET** /api/User/{id}/friendsNumber | 
[**apiUserIdGetUserGet**](UserApi.md#apiuseridgetuserget) | **GET** /api/User/{id}/getUser | 
[**apiUserPredictDistancePost**](UserApi.md#apiuserpredictdistancepost) | **POST** /api/User/predictDistance | 
[**apiUserSearchUserGet**](UserApi.md#apiusersearchuserget) | **GET** /api/User/searchUser | 
[**apiUserSendFriendRequestPost**](UserApi.md#apiusersendfriendrequestpost) | **POST** /api/User/sendFriendRequest | 
[**apiUserUpdateUserPut**](UserApi.md#apiuserupdateuserput) | **PUT** /api/User/updateUser | 
[**apiUserUploadProfilePictureBase64Post**](UserApi.md#apiuseruploadprofilepicturebase64post) | **POST** /api/User/uploadProfilePictureBase64 | 
[**apiUserUserIdGetProfilePictureGet**](UserApi.md#apiuseruseridgetprofilepictureget) | **GET** /api/User/{userId}/getProfilePicture | 


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

# **apiUserConfirmHikePost**
> apiUserConfirmHikePost(coordinatesDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final BuiltList<CoordinatesDto> coordinatesDto = ; // BuiltList<CoordinatesDto> | 

try {
    api.apiUserConfirmHikePost(coordinatesDto);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserConfirmHikePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **coordinatesDto** | [**BuiltList&lt;CoordinatesDto&gt;**](CoordinatesDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
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

# **apiUserDeleteProfilePicturePost**
> apiUserDeleteProfilePicturePost()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();

try {
    api.apiUserDeleteProfilePicturePost();
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserDeleteProfilePicturePost: $e\n');
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
> BuiltList<FriendshipDto> apiUserGetFriendRequestsGet()



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

[**BuiltList&lt;FriendshipDto&gt;**](FriendshipDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

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

# **apiUserPredictDistancePost**
> apiUserPredictDistancePost(trackPointDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final BuiltList<TrackPointDto> trackPointDto = ; // BuiltList<TrackPointDto> | 

try {
    api.apiUserPredictDistancePost(trackPointDto);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserPredictDistancePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **trackPointDto** | [**BuiltList&lt;TrackPointDto&gt;**](TrackPointDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserSearchUserGet**
> BuiltList<SearchUserDto> apiUserSearchUserGet(query)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final String query = query_example; // String | 

try {
    final response = api.apiUserSearchUserGet(query);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserSearchUserGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **query** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;SearchUserDto&gt;**](SearchUserDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserSendFriendRequestPost**
> apiUserSendFriendRequestPost(recivId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final int recivId = 56; // int | 

try {
    api.apiUserSendFriendRequestPost(recivId);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserSendFriendRequestPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recivId** | **int**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserUpdateUserPut**
> apiUserUpdateUserPut(updateUserDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final UpdateUserDto updateUserDto = ; // UpdateUserDto | 

try {
    api.apiUserUpdateUserPut(updateUserDto);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserUpdateUserPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateUserDto** | [**UpdateUserDto**](UpdateUserDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserUploadProfilePictureBase64Post**
> apiUserUploadProfilePictureBase64Post(body)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final String body = BYTE_ARRAY_DATA_HERE; // String | 

try {
    api.apiUserUploadProfilePictureBase64Post(body);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserUploadProfilePictureBase64Post: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserUserIdGetProfilePictureGet**
> apiUserUserIdGetProfilePictureGet(userId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final int userId = 56; // int | 

try {
    api.apiUserUserIdGetProfilePictureGet(userId);
} catch on DioException (e) {
    print('Exception when calling UserApi->apiUserUserIdGetProfilePictureGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

