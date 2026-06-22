import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar>
    with TickerProviderStateMixin {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _speechAvailable = false;

  // Ripple animation
  late AnimationController _rippleController;
  late Animation<double> _rippleAnimation1;
  late Animation<double> _rippleAnimation2;

  // Waveform animation
  late AnimationController _waveController;

  String _textBeforeListening = '';

  static const _activeColor = AppColors.secondaryColor;
  static const _activeBgColor = AppColors.lightSecondaryColor;
  static const _activeBorderColor = AppColors.lightPrimaryColor;

  static const List<double> _barHeights = [10, 20, 30, 20, 10];
  static const List<double> _barDelays = [0, 0.15, 0.3, 0.15, 0.0];

  @override
  void initState() {
    super.initState();

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _rippleAnimation1 = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );
    _rippleAnimation2 = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _rippleController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechAvailable = await _speech.initialize(
      onStatus: (status) {
        // When speech engine stops on its own (e.g. silence timeout)
        if (status == 'done' || status == 'notListening') {
          if (_isListening) _stopListening();
        }
      },
      onError: (error) {
        if (_isListening) _stopListening();
      },
    );
    setState(() {});
  }

  Future<void> _startListening() async {
    if (!_speechAvailable) return;
    _textBeforeListening = widget.controller.text; // save before listening
    setState(() => _isListening = true);
    _rippleController.repeat();
    _waveController.repeat(reverse: true);

    await _speech.listen(
      localeId: 'ar_EG',
      onResult: (result) {
        final newText = _textBeforeListening.isEmpty
            ? result.recognizedWords
            : '${_textBeforeListening} ${result.recognizedWords}';
        widget.controller.text = newText;
        widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: widget.controller.text.length),
        );
      },
      listenOptions: stt.SpeechListenOptions(
        partialResults: true,
        cancelOnError: true,
      ),
    );
  }

  void _stopListening() {
    _speech.stop();
    _rippleController.stop();
    _rippleController.reset();
    _waveController.stop();
    _waveController.reset();
    setState(() => _isListening = false);
  }

  void _toggleMic() {
    if (_isListening) {
      _stopListening();
    } else {
      _startListening();
    }
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _waveController.dispose();
    _speech.stop();
    super.dispose();
  }

  Widget _buildWaveform() {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(_barHeights.length, (i) {
            final phase = (_waveController.value + _barDelays[i]) % 1.0;
            final h =
                _barHeights[i] *
                (0.2 + 0.8 * (1 - (phase - 0.5).abs() * 2).clamp(0.0, 1.0));
            return Container(
              width: 3,
              height: h.clamp(4.0, 30.0),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Text field
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _isListening
                      ? _activeBorderColor.withOpacity(0.5)
                      : AppColors.borderColor,
                  width: _isListening ? 1.5 : 1.0,
                ),
                color: _isListening ? _activeBgColor : const Color(0xFFF9FAFB),
              ),
              child: TextField(
                maxLines: null,
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: _isListening
                      ? 'جاري الاستماع...'
                      : 'اكتب رسالتك هنا...',
                  hintStyle: TextStyles.regular14.copyWith(
                    color: _isListening
                        ? _activeBorderColor
                        : AppColors.subtitleColor.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Mic button with ripple + breathing + waveform
          SizedBox(
            width: 56,
            height: 56,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Ripple ring 1
                if (_isListening)
                  AnimatedBuilder(
                    animation: _rippleAnimation1,
                    builder: (context, child) {
                      return Opacity(
                        opacity: (1.0 - (_rippleAnimation1.value - 1.0)).clamp(
                          0.0,
                          0.3,
                        ),
                        child: Container(
                          width: 44 * _rippleAnimation1.value,
                          height: 44 * _rippleAnimation1.value,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              14 * _rippleAnimation1.value,
                            ),
                            color: _activeColor,
                          ),
                        ),
                      );
                    },
                  ),

                // Ripple ring 2
                if (_isListening)
                  AnimatedBuilder(
                    animation: _rippleAnimation2,
                    builder: (context, child) {
                      return Opacity(
                        opacity: (1.0 - (_rippleAnimation2.value - 1.0)).clamp(
                          0.0,
                          0.2,
                        ),
                        child: Container(
                          width: 44 * _rippleAnimation2.value,
                          height: 44 * _rippleAnimation2.value,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              14 * _rippleAnimation2.value,
                            ),
                            color: _activeColor,
                          ),
                        ),
                      );
                    },
                  ),

                // mic button
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _isListening ? _activeColor : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _isListening
                          ? _activeColor
                          : AppColors.borderColor,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: _speechAvailable ? _toggleMic : null,
                      // Waveform inside button when listening, mic icon when idle
                      child: _isListening
                          ? Center(child: _buildWaveform())
                          : const Icon(
                              Icons.mic_none_rounded,
                              color: AppColors.primaryColor,
                              size: 22,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Send button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                overlayColor: WidgetStatePropertyAll(
                  AppColors.primaryColor.withOpacity(0.06),
                ),
                onTap: widget.onSend,
                child: Ink(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
