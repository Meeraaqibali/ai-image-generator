import 'package:flutter/material.dart';

void main() => runApp(const AIImageApp());

class AIImageApp extends StatelessWidget {
  const AIImageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Image Generator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8A2BE2),
          surface: Color(0xFF151515),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _promptController = TextEditingController();
  String? _imageUrl;
  bool _isLoading = false;

  Future<void> _generateImages() async {
    if (_promptController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _imageUrl = null;
    });

    // Dart equivalent of our C++ prompt enhancement
    final enhancedPrompt = "${_promptController.text}, highly detailed, 8k resolution, cinematic lighting";
    final encodedPrompt = Uri.encodeComponent(enhancedPrompt);
    
    // Direct URL to the free AI API
    final url = "https://image.pollinations.ai/prompt/$encodedPrompt?width=512&height=512&nologo=true";

    // Simulate a slight delay so the UI shows the loader nicely
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _imageUrl = url;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CodeWithAaqib AI", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "AI Image Generator",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "Convert your text into stunning visuals.",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _promptController,
              decoration: InputDecoration(
                hintText: "Describe your image...",
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xFF8A2BE2), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _generateImages,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8A2BE2),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: _isLoading 
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Generate Image", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 30),
            if (_imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  _imageUrl!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 300,
                      color: const Color(0xFF1E1E1E),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Text("Failed to load image. Check your internet.");
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
