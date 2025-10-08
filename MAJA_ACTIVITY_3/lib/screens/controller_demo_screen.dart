import 'package:flutter/material.dart';

class ControllerDemoScreen extends StatefulWidget {
  const ControllerDemoScreen({Key? key}) : super(key: key);

  @override
  State<ControllerDemoScreen> createState() => _ControllerDemoScreenState();
}

class _ControllerDemoScreenState extends State<ControllerDemoScreen> {
  final _textController = TextEditingController();
  String _displayedText = '';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _captureText() {
    setState(() {
      _displayedText = _textController.text;
    });
  }

  void _clearText() {
    setState(() {
      _textController.clear();
      _displayedText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controller Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Text Controller Example',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Enter some text',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.text_fields),
                hintText: 'Type something...',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _captureText,
                    icon: const Icon(Icons.check),
                    label: const Text('Capture Text'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 50),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _clearText,
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 50),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            if (_displayedText.isNotEmpty)
              Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 10),
                          Text(
                            'Captured Text:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _displayedText,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Character count: ${_displayedText.length}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
