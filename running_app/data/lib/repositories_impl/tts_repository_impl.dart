import 'package:data/services/tts_engine.dart';
import 'package:domain/repositories/tts_repository.dart';

class TTSRepositoryImpl extends TTSRepository {
  final TTSEngine _tts;
  final List<String> _textQueue = [];
  bool _isSpeaking = false;

  TTSRepositoryImpl() : _tts = TTSEngine() {
    _initializeTTS();
  }

  void _initializeTTS() {
    _tts.init();
    _tts.flutterTts.setCompletionHandler(() {
      _isSpeaking = false;
      _processQueue();
    });
  }

  @override
  Future<void> speakText(String text) async {
    _textQueue.add(text);

    if (!_isSpeaking) {
      _processQueue();
    }
  }

  void _processQueue() async {
    if (_textQueue.isEmpty) {
      _isSpeaking = false;
      return;
    }

    _isSpeaking = true;
    String textToSpeak = _textQueue.removeAt(0);

    await _tts.speakText(textToSpeak);
  }

  @override
  Future<void> setVolume(double volume) async => await _tts.setVolume(volume);
}
