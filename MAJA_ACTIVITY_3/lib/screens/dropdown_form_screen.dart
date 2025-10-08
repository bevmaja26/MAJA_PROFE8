import 'package:flutter/material.dart';

class DropdownFormScreen extends StatefulWidget {
  const DropdownFormScreen({Key? key}) : super(key: key);

  @override
  State<DropdownFormScreen> createState() => _DropdownFormScreenState();
}

class _DropdownFormScreenState extends State<DropdownFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedRole;
  final List<String> _roles = ['Admin', 'User', 'Manager', 'Guest'];

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected Role: $_selectedRole'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Select User Role',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(
                  labelText: 'User Role',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                items: _roles.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a role';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Submit', style: TextStyle(fontSize: 16)),
              ),
              if (_selectedRole != null) ...[
                const SizedBox(height: 20),
                Card(
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(
                          _getIconForRole(_selectedRole!),
                          size: 50,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Selected: $_selectedRole',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForRole(String role) {
    switch (role) {
      case 'Admin':
        return Icons.admin_panel_settings;
      case 'Manager':
        return Icons.manage_accounts;
      case 'User':
        return Icons.person;
      case 'Guest':
        return Icons.person_outline;
      default:
        return Icons.person;
    }
  }
}
