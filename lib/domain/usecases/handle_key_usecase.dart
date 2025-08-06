import '../entities/key_button.dart';

class HandleKeyUsecase {
  String call({
    required String currentText,
    required int cursorPosition,
    required KeyButton key,
  }) {
    final sb = StringBuffer();
    sb.write(currentText.substring(0, cursorPosition));
    switch (key.type) {
      case KeyType.char:
        sb.write(key.label);
        break;

      case KeyType.backspace:
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
      case KeyType.numberMode:
      case KeyType.charMode:
      case KeyType.emoji:
      case KeyType.mic:
      case KeyType.mode:
      case KeyType.upper:
      case KeyType.grammarMode:
      case KeyType.translateMode:
      case KeyType.paraphrasingMode:
        break;
    }
    sb.write(currentText.substring(cursorPosition));
    return sb.toString();
  }
}
