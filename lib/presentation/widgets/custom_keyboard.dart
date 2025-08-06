import 'dart:math';

import 'package:flutter/material.dart';
import 'package:keyboard_demo/presentation/widgets/custom_number_keyboard.dart';
import 'package:keyboard_demo/presentation/widgets/emoji_keyboard.dart';
import 'package:keyboard_demo/presentation/widgets/three_tabview.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/key_button.dart';
import '../providers/keyboard_provider.dart';
import '../../core/style.dart';
import 'key_title.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KeyboardProvider>(context);
    final r1 = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'];
    final r2 = ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'];
    final r3 = ['z', 'x', 'c', 'v', 'b', 'n', 'm'];

    return Material(
      color: Colors.black87,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          _topChips(context),
          const SizedBox(height: 10),
          if (provider.typeMode == KeyType.numberMode)
            CustomNumberKeyboard(
              onDone: () => provider.onKeyPressed(
                KeyButton(label: 'done', type: KeyType.charMode),
              ),
            )
          else if (provider.typeMode == KeyType.emoji) ...[
            EmojiKeyboard(
              onEmojiSelected: (emoji) {
                provider.onKeyPressed(
                  KeyButton(label: emoji, type: KeyType.char),
                );
              },
              onBackspacePressed: () => provider.onKeyPressed(
                KeyButton(label: 'back', type: KeyType.backspace),
              ),
              onReturnCharKeyboard: () => provider.onKeyPressed(
                KeyButton(label: 'return', type: KeyType.charMode),
              ),
            ),
          ] else if (provider.typeMode == KeyType.grammarMode) ...[
            ThreeTabView(typeMode: KeyType.grammarMode),
          ] else if (provider.typeMode == KeyType.translateMode) ...[
            ThreeTabView(typeMode: KeyType.translateMode),
          ] else if (provider.typeMode == KeyType.paraphrasingMode) ...[
            ThreeTabView(typeMode: KeyType.paraphrasingMode),
          ] else ...[
            _qwertyFirstRow(context, r1),
            _qwertySecondRow(context, r2),
            _buildShift(provider, r3),
            _buildBottomRow(provider),
          ],

          const SizedBox(height: 8),
          _buildEmojiAndMicRow(provider),
        ],
      ),
    );
  }

  Widget _buildShift(KeyboardProvider provider, List<String> r3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        KeyTile(
          onTap: () => provider.onKeyPressed(
            KeyButton(label: 'shift', type: KeyType.upper),
          ),
          height: 38,
          width: 38,
          isSpecial: true,
          child: const Icon(Icons.arrow_upward, color: Colors.white),
        ),
        const SizedBox(width: 4),
        ...r3.map(
          (l) => KeyTile(
            onTap: () =>
                provider.onKeyPressed(KeyButton(label: l, type: KeyType.char)),
            child: Text(l),
          ),
        ),
        const SizedBox(width: 4),

        KeyTile(
          onTap: () => provider.onKeyPressed(
            KeyButton(label: 'back', type: KeyType.backspace),
          ),
          height: 38,
          width: 38,
          isSpecial: true,
          child: const Icon(Icons.backspace_outlined, color: Colors.white),
        ),
      ],
    );
  }

  Padding _buildEmojiAndMicRow(KeyboardProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => provider.onKeyPressed(
              KeyButton(label: 'emoji', type: KeyType.emoji),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.tag_faces_outlined, color: Colors.white),
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => provider.onKeyPressed(
              KeyButton(label: 'mic', type: KeyType.mic),
            ),
            child: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.mic, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildBottomRow(KeyboardProvider provider) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: KeyTile(
              onTap: () => provider.onKeyPressed(
                KeyButton(label: '123', type: KeyType.numberMode),
              ),
              isSpecial: true,
              child: const Text('123'),
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: KeyTile(
              onTap: () => provider.onKeyPressed(
                KeyButton(label: ' ', type: KeyType.space),
              ),
              isSpecial: true,
              child: const Align(
                alignment: Alignment.center,
                child: Text('space'),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: KeyTile(
              onTap: () => provider.onKeyPressed(
                KeyButton(label: '@', type: KeyType.char),
              ),
              isSpecial: true,
              child: const Text('@'),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: KeyTile(
              onTap: () => provider.onKeyPressed(
                KeyButton(label: 'go', type: KeyType.enter),
              ),
              isSpecial: true,
              child: const Text(
                'go',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _topChips(BuildContext context) {
    final chips = ['Grammar', 'Translate', 'Paraphrasing'];
    final keyTabs = [
      KeyType.grammarMode,
      KeyType.translateMode,
      KeyType.paraphrasingMode,
    ];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        itemCount: chips.length,
        itemBuilder: (context, index) {
          final label = chips[index];
          final tab = keyTabs[index];
          return _pill(
            ctx: context,
            label: label,
            tab: tab,
            icon: Icons.language_outlined,
          );
        },
      ),
    );
  }

  Widget _pill({
    required BuildContext ctx,
    required String label,
    required KeyType tab,
    required IconData? icon,
  }) {
    final provider = Provider.of<KeyboardProvider>(ctx);
    final bool selected = provider.typeMode == tab;
    return GestureDetector(
      onTap: () => provider.selectTab(tab),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF00D08A) : const Color(0xFF2F2F2F),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: selected ? Colors.black : Colors.white70,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.black : Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qwertyFirstRow(BuildContext context, List<String> letters) {
    final provider = Provider.of<KeyboardProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: letters.map((l) {
        return Expanded(
          child: KeyTile(
            onTap: () =>
                provider.onKeyPressed(KeyButton(label: l, type: KeyType.char)),
            child: Text(l),
          ),
        );
      }).toList(),
    );
  }

  Widget _qwertySecondRow(BuildContext context, List<String> letters) {
    final provider = Provider.of<KeyboardProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: letters.map((l) {
          return Expanded(
            child: KeyTile(
              onTap: () => provider.onKeyPressed(
                KeyButton(label: l, type: KeyType.char),
              ),
              child: Text(l),
            ),
          );
        }).toList(),
      ),
    );
  }
}
