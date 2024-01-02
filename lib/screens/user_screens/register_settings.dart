import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsPage(),

    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _ipAddressController = TextEditingController();
  final TextEditingController _portNumberController = TextEditingController();
  final TextEditingController _timeoutController = TextEditingController();
  final TextEditingController _interRequestDelayController = TextEditingController();
  final TextEditingController _holdingRegisterBlockSizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        title:const Text('Bağlantı Ayarları'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('Ip Adresi'),
            subtitle: TextFormField(
              controller: _ipAddressController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                suffixText: '',
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
              ),
            ),
          ),
          ListTile(
            title:const Text('Port Numarası'),
            subtitle: TextFormField(
              controller: _portNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(suffixText: ''),
            ),
          ),
          ListTile(
            title: const Text('Timeout'),
            subtitle: TextFormField(
              controller: _timeoutController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(suffixText: ' milliseconds'),
            ),
          ),
          ListTile(
            title: const Text('Inter Request Delay'),
            subtitle: TextFormField(
              controller: _interRequestDelayController,
              keyboardType: TextInputType.number,
              decoration:const InputDecoration(suffixText: ' milliseconds'),

            ),
          ),
          ListTile(
            title:const Text('Holding Register Block Size'),
            subtitle: TextFormField(
              controller: _holdingRegisterBlockSizeController,
              keyboardType: TextInputType.number,
              decoration:const InputDecoration(suffixText: ''),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print('IP Adresi: ${_ipAddressController.text}');
              print('Port Numarası: ${_portNumberController.text}');
              print('Timeout: ${_timeoutController.text} milliseconds');
              print('Inter Request Delay: ${_interRequestDelayController.text} milliseconds');
              print('Holding Register Block Size: ${_holdingRegisterBlockSizeController.text}');
            },
            child:const Text('Kaydet'),
          ),
          const SizedBox(height: 8.0),
          const Row(
            children: [
              Icon(Icons.warning, color: Colors.yellow),
              SizedBox(width: 8.0),
              Flexible(
                child: Text(
                  'Ayarlardaki değişiklikler uygulamanın optimizasyonunu bozabilir',
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}