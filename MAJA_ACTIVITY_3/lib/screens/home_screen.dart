import 'package:flutter/material.dart';
import 'simple_username_form.dart';
import 'login_form_screen.dart';
import 'validated_form_screen.dart';
import 'mixed_input_form_screen.dart';
import 'registration_form_screen.dart';
import 'dropdown_form_screen.dart';
import 'datetime_form_screen.dart';
import 'controller_demo_screen.dart';
import 'data_persistence_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edu School Supplies'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMenuCard(
            context,
            '1. Simple Username Form',
            'Basic TextFormField example',
            Icons.person,
            const SimpleUsernameForm(),
          ),
          _buildMenuCard(
            context,
            '2. Login Form',
            'Email and password login',
            Icons.login,
            const LoginFormScreen(),
          ),
          _buildMenuCard(
            context,
            '3. Validated Form',
            'Form with validation rules',
            Icons.verified_user,
            const ValidatedFormScreen(),
          ),
          _buildMenuCard(
            context,
            '4. GlobalKey Form',
            'Using GlobalKey<FormState>',
            Icons.key,
            const ValidatedFormScreen(),
          ),
          _buildMenuCard(
            context,
            '5. Mixed Input Types',
            'TextField, Checkbox, Switch',
            Icons.input,
            const MixedInputFormScreen(),
          ),
          _buildMenuCard(
            context,
            '6. Registration Form',
            'Complete registration with validation',
            Icons.app_registration,
            const RegistrationFormScreen(),
          ),
          _buildMenuCard(
            context,
            '7. Dropdown Form',
            'Select user role from dropdown',
            Icons.arrow_drop_down_circle,
            const DropdownFormScreen(),
          ),
          _buildMenuCard(
            context,
            '8. Date & Time Picker',
            'Pick date and time inputs',
            Icons.calendar_today,
            const DateTimeFormScreen(),
          ),
          _buildMenuCard(
            context,
            '9. Controller Demo',
            'Capture and display text',
            Icons.control_camera,
            const ControllerDemoScreen(),
          ),
          _buildMenuCard(
            context,
            '10. Data Persistence',
            'Save and display form data',
            Icons.save,
            const DataPersistenceFormScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget destination,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 32),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
      ),
    );
  }
}
