import 'package:flutter/material.dart';
import '../../domain/entities/key_button.dart';
import '../../domain/usecases/handle_key_usecase.dart';
import '../../data/repositories/keyboard_repository_impl.dart';

class KeyboardProvider extends ChangeNotifier {
  final HandleKeyUsecase _usecase;
  final KeyboardRepositoryImpl _repo;

  String _text = '';
  int _cursor = 0;

  KeyboardProvider(this._usecase, this._repo);

  String get text => _text;
  int get cursor => _cursor;

  void setCursor(int pos) {
    _cursor = pos.clamp(0, _text.length);
    notifyListeners();
  }

  void setText(String value) {
    _text = value;
    _cursor = _text.length;
    notifyListeners();
  }

  void onKeyPressed(KeyButton key) {
    _repo.logKeyPress(key.label);
    if (key.type == KeyType.mic) {
      _handleMic();
      return;
    }
    if (key.type == KeyType.emoji) {
      _toggleEmojiPicker();
      return;
    }
    if (key.type == KeyType.mode) {
      _toggleTopMode(key.label);
      return;
    }

    if (key.type == KeyType.backspace) {
      if (_cursor > 0) {
        _text = _text.substring(0, _cursor - 1) + _text.substring(_cursor);
        _cursor--;
      }
      notifyListeners();
      return;
    }

    // default insertion via usecase
    _text = _usecase.call(
      currentText: _text,
      cursorPosition: _cursor,
      key: key,
    );
    _cursor =
        _cursor +
        (key.type == KeyType.char
            ? key.label.length
            : (key.type == KeyType.space ? 1 : 0));
    notifyListeners();
  }

  // stubs - expand these
  void _handleMic() {
    // simulate toggling voice recording
    // ignore: avoid_print
    print('Mic action');
  }

  void _toggleEmojiPicker() {
    // show emoji picker...
    // ignore: avoid_print
    print('Toggle emoji');
  }

  void _toggleTopMode(String label) {
    // handle grammar/translate/paraphrasing chips tap
    // ignore: avoid_print
    print('Top mode tapped: $label');
  }
}
