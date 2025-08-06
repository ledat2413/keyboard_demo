import '../entities/key_button.dart';

class HandleKeyUsecase {
  /// Returns a resulting text after applying [key] to [currentText] and
  /// [cursorPosition]. This is deliberately small (pure logic) so it sits in domain.
  String call({
    required String currentText,
    required int cursorPosition,
    required KeyButton key,
  }) {
    // basic handling: insert char or handle special keys
    final sb = StringBuffer();
    sb.write(currentText.substring(0, cursorPosition));
    switch (key.type) {
      case KeyType.char:
        sb.write(key.label);
        break;
      case KeyType.backspace:
        // handle backspace
        if (cursorPosition > 0) {
          final before = currentText.substring(0, cursorPosition - 1);
          final after = currentText.substring(cursorPosition);
          return before + after;
        }
        return currentText;
      case KeyType.space:
        sb.write(' ');
        break;
      case KeyType.enter:
        sb.write('\n');
        break;
      case KeyType.emoji:
      case KeyType.mic:
      case KeyType.mode:
      case KeyType.special:
        // these might be handled elsewhere (UI actions)
        return currentText;
    }
    sb.write(currentText.substring(cursorPosition));
    return sb.toString();
  }
}
