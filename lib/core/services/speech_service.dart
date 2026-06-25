import 'package:speech_to_text/speech_to_text.dart' as stt;

/// Singleton that owns the single [SpeechToText] instance for the entire app.
///
/// [SpeechToText] uses a platform-channel singleton on Android — re-creating
/// it inside a widget causes stale native listeners that never fire [onStatus],
/// leaving animations stuck. Keeping one instance here fixes that.
///
/// [initialize] is called ONCE at app startup. [onStatus] / [onError] are
/// registered once and delegate to [_onStopCallback] so the widget callback
/// stays current without re-initializing the platform channel.
class SpeechService {
  SpeechService._();

  static final SpeechService _instance = SpeechService._();
  factory SpeechService() => _instance;

  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _available = false;

  // Current stop callback — updated on every startListening call
  void Function()? _onStopCallback;

  /// Must be called once during app startup (inside [setupGetIt]).
  Future<void> initialize() async {
    _available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          _onStopCallback?.call();
        }
      },
      onError: (error) {
        _onStopCallback?.call();
      },
    );
  }

  bool get isAvailable => _available;

  bool get isListening => _speech.isListening;

  /// Starts listening.
  ///
  /// [onResult] — called with every partial / final recognized word.
  /// [onStop]   — called when the engine stops on its own (silence / error).
  Future<void> startListening({
    required void Function(String words) onResult,
    required void Function() onStop,
  }) async {
    if (!_available || _speech.isListening) return;

    // Register the current widget's callback before starting
    _onStopCallback = onStop;

    await _speech.listen(
      localeId: 'ar_EG',
      onResult: (result) => onResult(result.recognizedWords),
      listenOptions: stt.SpeechListenOptions(
        partialResults: true,
        cancelOnError: true,
      ),
    );
  }

  /// Stops listening immediately (called when the user taps the mic button).
  Future<void> stopListening() async {
    _onStopCallback = null;
    await _speech.stop();
  }
}