import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/key_button.dart';
import '../providers/keyboard_provider.dart';
import '../../core/style.dart';
import 'key_title.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({Key? key}) : super(key: key);

  Widget _topChips(BuildContext context) {
    final provider = Provider.of<KeyboardProvider>(context, listen: false);
    final chips = ['Grammar', 'Translate', 'Paraphrasing'];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemCount: chips.length,
        itemBuilder: (context, index) {
          final label = chips[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => provider.onKeyPressed(
                KeyButton(label: label, type: KeyType.mode),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: KeyboardStyles.topChipDeco,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(label, style: KeyboardStyles.topChipStyle),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _qwertyFirstRow(BuildContext context, List<String> letters) {
    final provider = Provider.of<KeyboardProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // mainAxisSize: MainAxisSize.min,
      children: letters.map((l) {
        return KeyTile(
          onTap: () =>
              provider.onKeyPressed(KeyButton(label: l, type: KeyType.char)),
          child: Text(l),
        );
      }).toList(),
    );
  }

  Widget _qwertySecondRow(BuildContext context, List<String> letters) {
    final provider = Provider.of<KeyboardProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: letters.map((l) {
        return KeyTile(
          onTap: () =>
              provider.onKeyPressed(KeyButton(label: l, type: KeyType.char)),
          child: Text(l),
        );
      }).toList(),
    );
  }

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
          _qwertyFirstRow(context, r1),
          _qwertySecondRow(context, r2),
          _buildShift(provider, r3),
          _buildBottomRow(provider),
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
            KeyButton(label: 'shift', type: KeyType.special),
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
                KeyButton(label: '123', type: KeyType.special),
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
                KeyButton(label: '@', type: KeyType.special),
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
}
