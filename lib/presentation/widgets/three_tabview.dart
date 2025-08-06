import 'package:flutter/material.dart';
import 'package:keyboard_demo/domain/entities/key_button.dart';
import 'package:keyboard_demo/presentation/providers/keyboard_provider.dart';
import 'package:provider/provider.dart';

class ThreeTabView extends StatelessWidget {
  final KeyType typeMode;
  const ThreeTabView({super.key, required this.typeMode});

  Widget _translateContent(BuildContext context) {
    final languages = [
      ['English', Icons.flag],
      ['Spanish', Icons.flag],
      ['Chinese', Icons.flag],
      ['Turkish', Icons.flag],
      ['French', Icons.flag],
      ['Italian', Icons.flag],
      ['Portuguese', Icons.flag],
      ['Hindi', Icons.flag],
      ['Japanese', Icons.flag],
      ['Korean', Icons.flag],
      ['Thai', Icons.flag],
      ['Arabic', Icons.flag],
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: languages.map((l) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.grey[800],
                  child: Icon(
                    l[1] as IconData,
                    size: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  l[0] as String,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _paraphraseContent(BuildContext context) {
    final tones = [
      'Formal',
      'Assertive',
      'Cooperative',
      'Encouraging',
      'Optimistic',
      'Surprised',
      'Worried',
      'Informal',
      'Friendly',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: tones.map((t) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF2B2B2B),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(t, style: const TextStyle(color: Colors.white70)),
          );
        }).toList(),
      ),
    );
  }

  Widget _grammarContent(BuildContext context) {
    final provider = Provider.of<KeyboardProvider>(context, listen: false);

    // Example layout similar to screenshot 3
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Oops, No Text Found',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Please type in some text so the AI can tune it for you.',
            style: TextStyle(color: Colors.white54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              provider.onKeyPressed(
                KeyButton(label: 'openKeyboard', type: KeyType.charMode),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Open Keyboard'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KeyboardProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // chips row
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        //   child: Row(
        //     children: [
        //       _pill(
        //         ctx: context,
        //         label: 'Grammar',
        //         tab: KeyType.grammarMode,
        //         icon: Icons.abc,
        //       ),
        //       _pill(
        //         ctx: context,
        //         label: 'Translate',
        //         tab: KeyType.translateMode,
        //         icon: Icons.translate,
        //       ),
        //       _pill(
        //         ctx: context,
        //         label: 'Paraphrasing',
        //         tab: KeyType.paraphrasingMode,
        //         icon: Icons.sync_alt,
        //       ),
        //       const Spacer(),
        //       // small keyboard icon button on right like screenshot
        //       GestureDetector(
        //         onTap: () {
        //           // optional: toggle keyboard view mode
        //         },
        //         child: Container(
        //           padding: const EdgeInsets.all(8),
        //           decoration: BoxDecoration(
        //             color: const Color(0xFF2A2A2A),
        //             borderRadius: BorderRadius.circular(12),
        //           ),
        //           child: const Icon(
        //             Icons.keyboard,
        //             color: Colors.white70,
        //             size: 18,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        // content area (animated)
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: Builder(
            builder: (ctx) {
              switch (provider.typeMode) {
                case KeyType.translateMode:
                  return _translateContent(ctx);
                case KeyType.paraphrasingMode:
                  return _paraphraseContent(ctx);
                case KeyType.grammarMode:
                  return _grammarContent(ctx);
                default:
                  return const SizedBox.shrink(); // default case if needed
              }
            },
          ),
        ),
      ],
    );
  }
}
