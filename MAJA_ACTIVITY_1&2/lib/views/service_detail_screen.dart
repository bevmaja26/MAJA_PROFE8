import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../widgets/custom_button.dart';

class ServiceDetailScreen extends StatelessWidget {
  final EventService service;

  const ServiceDetailScreen({Key? key, required this.service})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.title),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    service.icon,
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              service.title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 16),
            Text(
              service.detailedDescription,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'What\'s Included:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 12),
            ...service.features
                .map((feature) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            SizedBox(height: 32),
            CustomButton(
              text: 'Book This Service',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Service Booking'),
                      content: Text(
                          'Thank you for your interest in ${service.title}! We\'ll contact you soon to discuss your requirements.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(height: 16),
            CustomButton(
              text: 'Contact Us',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Call us at +1 (555) 123-4567 or email info@beverlysevents.com'),
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              backgroundColor: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}
