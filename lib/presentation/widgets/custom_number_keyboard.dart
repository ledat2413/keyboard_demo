import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/key_button.dart';
import '../providers/keyboard_provider.dart';

// Map for number to letters
const Map<String, String> numberLetters = {
  '1': '',
  '2': 'ABC',
  '3': 'DEF',
  '4': 'GHI',
  '5': 'JKL',
  '6': 'MNO',
  '7': 'PQRS',
  '8': 'TUV',
  '9': 'WXYZ',
  '0': '',
};

class CustomNumberKeyboard extends StatelessWidget {
  final VoidCallback? onDone;

  const CustomNumberKeyboard({super.key, this.onDone});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _numKey(context, '1'),
                _numKey(context, '2'),
                _numKey(context, '3'),
              ],
            ),
            Row(
              children: [
                _numKey(context, '4'),
                _numKey(context, '5'),
                _numKey(context, '6'),
              ],
            ),
            Row(
              children: [
                _numKey(context, '7'),
                _numKey(context, '8'),
                _numKey(context, '9'),
              ],
            ),
            Row(
              children: [
                _returnCharKeyboard(context),
                _numKey(context, '0'),
                _backspaceKey(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _numKey(BuildContext context, String label) {
    final provider = Provider.of<KeyboardProvider>(context, listen: false);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => provider.onKeyPressed(
              KeyButton(label: label, type: KeyType.char),
            ),
            child: SizedBox(
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (numberLetters[label]!.isNotEmpty)
                    Text(
                      numberLetters[label]!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        letterSpacing: 1.2,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _returnCharKeyboard(BuildContext context) {
    final provider = Provider.of<KeyboardProvider>(context, listen: false);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Material(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => provider.onKeyPressed(
              KeyButton(label: 'chartMode', type: KeyType.charMode),
            ),
            child: const SizedBox(
              height: 64,
              child: Center(
                child: Icon(
                  Icons.keyboard_alt_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _backspaceKey(BuildContext context) {
    final provider = Provider.of<KeyboardProvider>(context, listen: false);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Material(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => provider.onKeyPressed(
              KeyButton(label: 'back', type: KeyType.backspace),
            ),
            child: const SizedBox(
              height: 64,
              child: Center(
                child: Icon(
                  Icons.backspace_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
