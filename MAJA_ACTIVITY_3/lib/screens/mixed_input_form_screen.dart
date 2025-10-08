import 'package:flutter/material.dart';

class MixedInputFormScreen extends StatefulWidget {
  const MixedInputFormScreen({Key? key}) : super(key: key);

  @override
  State<MixedInputFormScreen> createState() => _MixedInputFormScreenState();
}

class _MixedInputFormScreenState extends State<MixedInputFormScreen> {
  final _textController = TextEditingController();
  bool _checkboxValue = false;
  bool _switchValue = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mixed Input Types'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Text Input',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.text_fields),
              ),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('Accept Terms and Conditions'),
              value: _checkboxValue,
              onChanged: (value) {
                setState(() {
                  _checkboxValue = value ?? false;
                });
              },
              secondary: const Icon(Icons.check_box),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
              secondary: const Icon(Icons.notifications),
            ),
            const SizedBox(height: 30),
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Values:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Text: ${_textController.text}'),
                    Text('Checkbox: $_checkboxValue'),
                    Text('Switch: $_switchValue'),
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
