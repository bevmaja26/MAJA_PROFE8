import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormScreen extends StatefulWidget {
  const DateTimeFormScreen({Key? key}) : super(key: key);

  @override
  State<DateTimeFormScreen> createState() => _DateTimeFormScreenState();
}

class _DateTimeFormScreenState extends State<DateTimeFormScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date & Time Picker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select Date and Time',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.calendar_today, color: Colors.blue),
                title: const Text('Select Date'),
                subtitle: Text(
                  _selectedDate != null
                      ? DateFormat('MMMM dd, yyyy').format(_selectedDate!)
                      : 'No date selected',
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _selectDate(context),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.access_time, color: Colors.blue),
                title: const Text('Select Time'),
                subtitle: Text(
                  _selectedTime != null
                      ? _selectedTime!.format(context)
                      : 'No time selected',
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _selectTime(context),
              ),
            ),
            const SizedBox(height: 30),
            if (_selectedDate != null || _selectedTime != null)
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selected Values:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (_selectedDate != null)
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 20),
                            const SizedBox(width: 10),
                            Text(
                              DateFormat('EEEE, MMMM dd, yyyy')
                                  .format(_selectedDate!),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      if (_selectedTime != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 20),
                            const SizedBox(width: 10),
                            Text(
                              _selectedTime!.format(context),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
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
