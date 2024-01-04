import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_project/provider/register_provider.dart';
import 'package:mobile_project/utils/constants.dart';
import 'package:mobile_project/utils/custom_progress_dialog.dart';

class ConnectionSettingsPage extends ConsumerStatefulWidget {
  const ConnectionSettingsPage({super.key});

  @override
  ConnectionSettingsPageState createState() => ConnectionSettingsPageState();
}

class ConnectionSettingsPageState extends ConsumerState<ConnectionSettingsPage> {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portNumberController = TextEditingController();
  final TextEditingController _timeoutController = TextEditingController();
  final TextEditingController _interRequestDelayController = TextEditingController();
  final TextEditingController _holdingRegisterBlockSizeController = TextEditingController();

  Future<void> writeIp(TextEditingController ipController, TextEditingController portController, TextEditingController timeoutController,
      TextEditingController interRequestDelayController, TextEditingController holdingRegisterBlockSizeController) async {
    await secureStorage.write(key: Constants.connectionIpAddress, value: ipController.text);
    await secureStorage.write(key: Constants.connectionPortNumber, value: portController.text);
    await secureStorage.write(key: Constants.connectionTimeout, value: timeoutController.text);
    await secureStorage.write(key: Constants.connectionInterRequestDelay, value: interRequestDelayController.text);
    await secureStorage.write(key: Constants.connectionHoldingRegisterBlockSize, value: holdingRegisterBlockSizeController.text);
    setState(() {});

    //Navigator.of(context).pop();
    print('Yeni ip değeri yazıldı');
  }

  Future<void> getIp() async {
    _ipController.text = await secureStorage.read(key: Constants.connectionIpAddress) ?? "";
    _portNumberController.text = await secureStorage.read(key: Constants.connectionPortNumber) ?? "";
    _timeoutController.text = await secureStorage.read(key: Constants.connectionTimeout) ?? "";
    _interRequestDelayController.text = await secureStorage.read(key: Constants.connectionInterRequestDelay) ?? "";
    _holdingRegisterBlockSizeController.text = await secureStorage.read(key: Constants.connectionHoldingRegisterBlockSize) ?? "";
    print('Yeni ip değeri alındı');
    setState(() {});
  }

  @override
  void initState() {
    getIp();
    super.initState();
  }

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
        title: const Text('Bağlantı Ayarları'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('Ip Adresi'),
            subtitle: TextFormField(
              controller: _ipController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                suffixText: '',
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
              ),
            ),
          ),
          ListTile(
            title: const Text('Port Numarası'),
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
              decoration: const InputDecoration(suffixText: ' milliseconds'),
            ),
          ),
          ListTile(
            title: const Text('Holding Register Block Size'),
            subtitle: TextFormField(
              controller: _holdingRegisterBlockSizeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(suffixText: ''),
            ),
          ),
          ElevatedButton(
            // onPressed: () {
            //   print('IP Adresi: ${_ipAddressController.text}');
            //   print('Port Numarası: ${_portNumberController.text}');
            //   print('Timeout: ${_timeoutController.text} milliseconds');
            //   print('Inter Request Delay: ${_interRequestDelayController.text} milliseconds');
            //   print('Holding Register Block Size: ${_holdingRegisterBlockSizeController.text}');
            // },
            onPressed: () {
              writeIp(
                _ipController,
                _portNumberController,
                _timeoutController,
                _interRequestDelayController,
                _holdingRegisterBlockSizeController,
              );
              ref.read(registerProvider.notifier).closeClientConnection();
              ref.read(registerProvider.notifier).createClient();
              ref.read(registerProvider.notifier).readData();
              CustomProgressDialog(
                title: "Yeniden Bağlanılıyor",
                content: "Lütfen Bekleyiniz..",
                secondsToWait: 3,
                titleFontSize: 16,
              ).show(context);
            },
            child: const Text('Kaydet'),
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
