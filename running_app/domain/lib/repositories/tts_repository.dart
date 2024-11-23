abstract class TTSRepository {
  Future<void> speakText(String text);

  Future<void> setVolume(double volume);
}
