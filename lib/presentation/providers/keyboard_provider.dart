import 'package:flutter/material.dart';
import '../../domain/entities/key_button.dart';
import '../../domain/usecases/handle_key_usecase.dart';
import '../../data/repositories/keyboard_repository_impl.dart';

class KeyboardProvider extends ChangeNotifier {
  final HandleKeyUsecase _usecase;
  final KeyboardRepositoryImpl _repo;

  String _text = '';
  int _cursor = 0;
  KeyType typeMode = KeyType.charMode;

  KeyboardProvider(this._usecase, this._repo);

  String get text => _text;
  int get cursor => _cursor;

  void selectTab(KeyType tab) {
    onKeyPressed(KeyButton(label: '', type: tab));
    if (typeMode == tab) return;
    typeMode = tab;
    notifyListeners();
  }

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

    if (key.type == KeyType.backspace) {
      if (_cursor > 0) {
        final chars = _text.characters;
        final before = chars.take(_cursor - 1).toString();
        final after = chars.skip(_cursor).toString();
        _text = before + after;
        _cursor = before.characters.length;
      }
      notifyListeners();
      return;
    }

    if (key.type == KeyType.numberMode) {
      typeMode = KeyType.numberMode;
      notifyListeners();
      return;
    }
    if (key.type == KeyType.charMode) {
      typeMode = KeyType.charMode;
      notifyListeners();
      return;
    }

    if (key.type == KeyType.grammarMode) {
      typeMode = KeyType.grammarMode;
      notifyListeners();
      return;
    }

    if (key.type == KeyType.translateMode) {
      typeMode = KeyType.translateMode;
      notifyListeners();
      return;
    }
    if (key.type == KeyType.paraphrasingMode) {
      typeMode = KeyType.paraphrasingMode;
      notifyListeners();
      return;
    }

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

  void _handleMic() {
    // ignore: avoid_print
    debugPrint('Mic action');
  }

  void _toggleEmojiPicker() {
    typeMode = KeyType.emoji;
    // ignore: avoid_print
    debugPrint('Toggle emoji');
    notifyListeners();
  }
}
