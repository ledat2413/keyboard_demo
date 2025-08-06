import 'dart:math';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';

class EmojiKeyboard extends StatelessWidget {
  final Function(String) onEmojiSelected;
  final Function() onBackspacePressed;
  final Function() onReturnCharKeyboard;
  EmojiKeyboard({
    super.key,
    required this.onEmojiSelected,
    required this.onBackspacePressed,
    required this.onReturnCharKeyboard,
  });

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) => onEmojiSelected(emoji.emoji),
      onBackspacePressed: () => onBackspacePressed.call(),

      config: Config(
        height: 256,
        checkPlatformCompatibility: true,
        viewOrderConfig: const ViewOrderConfig(),
        emojiViewConfig: EmojiViewConfig(
          emojiSizeMax:
              28 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.2
                  : 1.0),
        ),
        skinToneConfig: const SkinToneConfig(),
        categoryViewConfig: const CategoryViewConfig(),
        bottomActionBarConfig: BottomActionBarConfig(
          customBottomActionBar: (config, state, emoji) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.keyboard_alt_outlined),
                  onPressed: () => onReturnCharKeyboard.call(),
                ),
                IconButton(
                  icon: const Icon(Icons.backspace),
                  onPressed: () => onBackspacePressed.call(),
                ),
              ],
            );
          },
        ),
        searchViewConfig: const SearchViewConfig(),
      ),
    );
  }
}
