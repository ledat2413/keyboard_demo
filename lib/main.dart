import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/keyboard_provider.dart';
import 'presentation/widgets/custom_keyboard.dart';
import 'data/repositories/keyboard_repository_impl.dart';
import 'domain/usecases/handle_key_usecase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final usecase = HandleKeyUsecase();
    final repo = KeyboardRepositoryImpl();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KeyboardProvider(usecase, repo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const KeyboardDemoPage(),
      ),
    );
  }
}

class KeyboardDemoPage extends StatefulWidget {
  const KeyboardDemoPage({Key? key}) : super(key: key);

  @override
  State<KeyboardDemoPage> createState() => _KeyboardDemoPageState();
}

class _KeyboardDemoPageState extends State<KeyboardDemoPage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // prevent default system keyboard from popping by not focusing a real TextField
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KeyboardProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(title: const Text('Custom Keyboard Demo')),
      body: SafeArea(
        child: Column(
          children: [
            // Display area for result text that the custom keyboard edits
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    provider.text.isEmpty ? 'Tap keys below...' : provider.text,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            const Spacer(),
            // attach keyboard at bottom
            const Divider(color: Colors.white24),
            const CustomKeyboard(),
          ],
        ),
      ),
    );
  }
}
