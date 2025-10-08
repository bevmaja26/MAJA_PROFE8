import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Activity 1-10: Comprehensive Form with all input types
class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({super.key});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  String _selectedRole = 'student';
  String _selectedGrade = '9th Grade';
  bool _agreeToTerms = false;
  bool _subscribeNewsletter = false;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  double _budgetRange = 50.0;
  bool _notificationsEnabled = true;
  String? _uploadedFileName;

  final List<String> _selectedInterests = [];
  final List<String> _availableInterests = [
    'Mathematics',
    'Science',
    'Art',
    'Sports',
    'Music',
    'Technology'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _simulateFileUpload() {
    setState(() {
      _uploadedFileName = 'student_id_card.pdf';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('File uploaded successfully')),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please agree to terms and conditions')),
        );
        return;
      }

      _formKey.currentState!.save();

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Successful'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${_nameController.text}'),
              Text('Email: ${_emailController.text}'),
              Text('Role: $_selectedRole'),
              Text('Grade: $_selectedGrade'),
              if (_selectedDate != null)
                Text(
                    'Birth Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'),
              Text('Budget Range: \$${_budgetRange.toStringAsFixed(0)}'),
              Text('Interests: ${_selectedInterests.join(", ")}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Activity 1: TextFormField with validation
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter your full name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                if (value.length < 3) {
                  return 'Name must be at least 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Activity 1: Email validation
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'your.email@example.com',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Activity 1: Phone validation
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: '+1 (555) 123-4567',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Activity 2: Radio Buttons
            const Text(
              'Select Your Role',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text('Student'),
              value: 'student',
              groupValue: _selectedRole,
              onChanged: (value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Teacher'),
              value: 'teacher',
              groupValue: _selectedRole,
              onChanged: (value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Parent'),
              value: 'parent',
              groupValue: _selectedRole,
              onChanged: (value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Activity 3: Checkboxes
            const Text(
              'Select Your Interests',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ..._availableInterests.map((interest) {
              return CheckboxListTile(
                title: Text(interest),
                value: _selectedInterests.contains(interest),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedInterests.add(interest);
                    } else {
                      _selectedInterests.remove(interest);
                    }
                  });
                },
              );
            }),
            const SizedBox(height: 16),

            // Activity 4: Dropdown
            DropdownButtonFormField<String>(
              value: _selectedGrade,
              decoration: const InputDecoration(
                labelText: 'Grade Level',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.school),
              ),
              items: [
                '6th Grade',
                '7th Grade',
                '8th Grade',
                '9th Grade',
                '10th Grade',
                '11th Grade',
                '12th Grade',
              ].map((grade) {
                return DropdownMenuItem(
                  value: grade,
                  child: Text(grade),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGrade = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Activity 5: Date Picker
            ListTile(
              title: const Text('Birth Date'),
              subtitle: Text(
                _selectedDate != null
                    ? DateFormat('MMMM dd, yyyy').format(_selectedDate!)
                    : 'Select your birth date',
              ),
              leading: const Icon(Icons.calendar_today),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _selectDate,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(height: 16),

            // Activity 6: Time Picker
            ListTile(
              title: const Text('Preferred Contact Time'),
              subtitle: Text(
                _selectedTime != null
                    ? _selectedTime!.format(context)
                    : 'Select preferred time',
              ),
              leading: const Icon(Icons.access_time),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _selectTime,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(height: 16),

            // Activity 7: Slider
            const Text(
              'Monthly Budget for Supplies',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _budgetRange,
              min: 0,
              max: 200,
              divisions: 20,
              label: '\$${_budgetRange.toStringAsFixed(0)}',
              onChanged: (value) {
                setState(() {
                  _budgetRange = value;
                });
              },
            ),
            Text(
              '\$${_budgetRange.toStringAsFixed(0)} per month',
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 16),

            // Activity 8: Switch
            SwitchListTile(
              title: const Text('Enable Notifications'),
              subtitle:
                  const Text('Receive updates about new products and offers'),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Activity 9: File Upload Simulation
            const Text(
              'Upload Student ID',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _simulateFileUpload,
              icon: const Icon(Icons.upload_file),
              label: Text(_uploadedFileName ?? 'Choose File'),
            ),
            if (_uploadedFileName != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Uploaded: $_uploadedFileName',
                  style: TextStyle(color: Colors.green.shade700),
                ),
              ),
            const SizedBox(height: 16),

            // Address field
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                hintText: 'Enter your full address',
                prefixIcon: Icon(Icons.home),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Terms checkbox
            CheckboxListTile(
              title: const Text('I agree to the terms and conditions'),
              value: _agreeToTerms,
              onChanged: (value) {
                setState(() {
                  _agreeToTerms = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),

            // Newsletter checkbox
            CheckboxListTile(
              title: const Text('Subscribe to newsletter'),
              value: _subscribeNewsletter,
              onChanged: (value) {
                setState(() {
                  _subscribeNewsletter = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 24),

            // Activity 10: Form Submission
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Submit Registration',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
