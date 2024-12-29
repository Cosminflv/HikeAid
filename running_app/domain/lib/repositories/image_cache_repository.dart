import 'dart:typed_data';

/// A repository interface for managing and caching navigation instruction images.
///
/// The [ImageCacheRepository] provides methods to cache, retrieve, and clear images related to
/// navigation instructions based on unique identifiers (UIDs).
abstract class ImageCacheRepository {
  /// Caches a navigation instruction image associated with a specific [imageUid].
  ///
  /// This method allows storing a navigation instruction image in the cache, which can be
  /// retrieved later using the same UID. If the image is already in the cache, it will be
  /// updated with the new [image].
  ///
  /// - Parameters:
  ///   - [imageUid]: A unique identifier for the image to be cached.
  ///   - [image]: The [Uint8List] containing the image data. If `null`, the image will not be cached.
  void setNavigationInstructionImage(int imageUid, Uint8List? image);

  /// Retrieves a cached navigation instruction image by its unique [imageUid].
  ///
  /// This method returns the cached image associated with the provided [imageUid], or `null`
  /// if the image is not found in the cache.
  ///
  /// - Parameters:
  ///   - [imageUid]: The unique identifier of the cached image to retrieve.
  ///
  /// - Returns: A [Uint8List]? representing the image data if found, or `null` if the image is
  ///   not available in the cache.
  Uint8List? getNavigationInstructionImageByUid(int imageUid);

  /// Clears all cached navigation instruction images.
  ///
  /// This method removes all cached images, freeing up memory and ensuring that no outdated
  /// images remain in the cache.
  ///
  /// - Returns: None.
  void clearNavigationInstructionImageCache();
}
