import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to the Help Page!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'This application facilitates communication with Modbus devices. Below is a comprehensive guide to help you make the most of its features:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '1. Getting Started:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '   a. Navigate to "Connection Settings" to configure Modbus connection settings.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '   b. Provide details such as IP address and port.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '   c. Tap "Save" to establish a connection with the Modbus device.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '2. Reading Modbus Registers:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '   a. Once connected, explore the "Home Page" section to access Modbus registers.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '   b. View all available registers on the home page.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '   c. To add a new value to the device, click on "New Value", enter the value, and click "Add".',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '3. Register Details and Charts:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '   a. On the "Home Page", click on a register to view its details and chart.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '   b. Additionally, visit the "Chart" to view charts for all registers.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '4. Password and Account Operations:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '   a. Manage your password and account settings on the "Profile" page.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '5. Troubleshooting:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '   a. If connection fails, verify the entered connection details.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '   b. Check the device status and network connectivity.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '   c. Ensure that the Modbus device supports the specified register address.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '6. Frequently Asked Questions (FAQ):',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '   a. Q: How can I add multiple Modbus devices?',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '      A: Go to "Connection Settings" and tap "Add Device" to configure additional connections.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '   b. Q: Is there a way to export data?',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '      A: Currently, data export features are not available, but it is planned for future updates.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '7. Contact Information:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '   For further assistance or inquiries, feel free to contact our support team:',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '   - Email: support@example.com',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '   - Phone: +1 (123) 456-7890',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
