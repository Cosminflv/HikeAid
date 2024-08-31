# openapi.api.SocialPostApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiSocialPostCommentsIdDelete**](SocialPostApi.md#apisocialpostcommentsiddelete) | **DELETE** /api/SocialPost/comments/{id} | 
[**apiSocialPostGet**](SocialPostApi.md#apisocialpostget) | **GET** /api/SocialPost | 
[**apiSocialPostIdDelete**](SocialPostApi.md#apisocialpostiddelete) | **DELETE** /api/SocialPost/{id} | 
[**apiSocialPostIdGet**](SocialPostApi.md#apisocialpostidget) | **GET** /api/SocialPost/{id} | 
[**apiSocialPostIdPut**](SocialPostApi.md#apisocialpostidput) | **PUT** /api/SocialPost/{id} | 
[**apiSocialPostLikesIdDelete**](SocialPostApi.md#apisocialpostlikesiddelete) | **DELETE** /api/SocialPost/likes/{id} | 
[**apiSocialPostPost**](SocialPostApi.md#apisocialpostpost) | **POST** /api/SocialPost | 
[**apiSocialPostPostIdCommentPost**](SocialPostApi.md#apisocialpostpostidcommentpost) | **POST** /api/SocialPost/{postId}/comment | 
[**apiSocialPostPostIdCommentsGet**](SocialPostApi.md#apisocialpostpostidcommentsget) | **GET** /api/SocialPost/{postId}/comments | 
[**apiSocialPostPostIdLikePost**](SocialPostApi.md#apisocialpostpostidlikepost) | **POST** /api/SocialPost/{postId}/like | 
[**apiSocialPostUserUserIdGet**](SocialPostApi.md#apisocialpostuseruseridget) | **GET** /api/SocialPost/user/{userId} | 


# **apiSocialPostCommentsIdDelete**
> apiSocialPostCommentsIdDelete(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSocialPostApi();
final int id = 56; // int | 

try {
    api.apiSocialPostCommentsIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling SocialPostApi->apiSocialPostCommentsIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSocialPostGet**
> apiSocialPostGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSocialPostApi();

try {
    api.apiSocialPostGet();
} catch on DioException (e) {
    print('Exception when calling SocialPostApi->apiSocialPostGet: $e\n');
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

# **apiSocialPostIdDelete**
> apiSocialPostIdDelete(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSocialPostApi();
final int id = 56; // int | 

try {
    api.apiSocialPostIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling SocialPostApi->apiSocialPostIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSocialPostIdGet**
> apiSocialPostIdGet(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSocialPostApi();
final int id = 56; // int | 

try {
    api.apiSocialPostIdGet(id);
} catch on DioException (e) {
    print('Exception when calling SocialPostApi->apiSocialPostIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSocialPostIdPut**
> apiSocialPostIdPut(id, socialPostDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSocialPostApi();
final String id = id_example; // String | 
final SocialPostDto socialPostDto = ; // SocialPostDto | 

try {
    api.apiSocialPostIdPut(id, socialPostDto);
} catch on DioException (e) {
    print('Exception when calling SocialPostApi->apiSocialPostIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **socialPostDto** | [**SocialPostDto**](SocialPostDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/*+json, application/json, text/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSocialPostLikesIdDelete**
> apiSocialPostLikesIdDelete(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSocialPostApi();
final int id = 56; // int | 

try {
    api.apiSocialPostLikesIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling SocialPostApi->apiSocialPostLikesIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSocialPostPost**
> apiSocialPostPost(socialPostModel)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSocialPostApi();
final SocialPostModel socialPostModel = ; // SocialPostModel | 

try {
    api.apiSocialPostPost(socialPostModel);
} catch on DioException (e) {
    print('Exception when calling SocialPostApi->apiSocialPostPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **socialPostModel** | [**SocialPostModel**](SocialPostModel.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/*+json, application/json, text/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSocialPostPostIdCommentPost**
> apiSocialPostPostIdCommentPost(postId, commentDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSocialPostApi();
final int postId = 56; // int | 
final CommentDto commentDto = ; // CommentDto | 

try {
    api.apiSocialPostPostIdCommentPost(postId, commentDto);
} catch on DioException (e) {
    print('Exception when calling SocialPostApi->apiSocialPostPostIdCommentPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | **int**|  | 
 **commentDto** | [**CommentDto**](CommentDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/*+json, application/json, text/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSocialPostPostIdCommentsGet**
> apiSocialPostPostIdCommentsGet(postId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSocialPostApi();
final int postId = 56; // int | 

try {
    api.apiSocialPostPostIdCommentsGet(postId);
} catch on DioException (e) {
    print('Exception when calling SocialPostApi->apiSocialPostPostIdCommentsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSocialPostPostIdLikePost**
> apiSocialPostPostIdLikePost(postId, likeDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSocialPostApi();
final int postId = 56; // int | 
final LikeDto likeDto = ; // LikeDto | 

try {
    api.apiSocialPostPostIdLikePost(postId, likeDto);
} catch on DioException (e) {
    print('Exception when calling SocialPostApi->apiSocialPostPostIdLikePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postId** | **int**|  | 
 **likeDto** | [**LikeDto**](LikeDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/*+json, application/json, text/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSocialPostUserUserIdGet**
> apiSocialPostUserUserIdGet(userId)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getSocialPostApi();
final int userId = 56; // int | 

try {
    api.apiSocialPostUserUserIdGet(userId);
} catch on DioException (e) {
    print('Exception when calling SocialPostApi->apiSocialPostUserUserIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

