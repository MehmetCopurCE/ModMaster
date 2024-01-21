import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_project/provider/register_provider.dart';
import 'package:mobile_project/utils/constants.dart';
import 'package:mobile_project/utils/custom_progress_dialog.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectionSettingsPage extends ConsumerStatefulWidget {
  const ConnectionSettingsPage({super.key});

  @override
  ConnectionSettingsPageState createState() => ConnectionSettingsPageState();
}

class ConnectionSettingsPageState
    extends ConsumerState<ConnectionSettingsPage> {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portNumberController = TextEditingController();
  final TextEditingController _timeoutController = TextEditingController();
  final TextEditingController _interRequestDelayController =
      TextEditingController();
  final TextEditingController _holdingRegisterBlockSizeController =
      TextEditingController();

  Future<void> writeIp(
      TextEditingController ipController,
      TextEditingController portController,
      TextEditingController timeoutController,
      TextEditingController interRequestDelayController,
      TextEditingController holdingRegisterBlockSizeController) async {
    await secureStorage.write(
        key: Constants.connectionIpAddress, value: ipController.text);
    await secureStorage.write(
        key: Constants.connectionPortNumber, value: portController.text);
    await secureStorage.write(
        key: Constants.connectionTimeout, value: timeoutController.text);
    await secureStorage.write(
        key: Constants.connectionInterRequestDelay,
        value: interRequestDelayController.text);
    await secureStorage.write(
        key: Constants.connectionHoldingRegisterBlockSize,
        value: holdingRegisterBlockSizeController.text);
    setState(() {});

    //Navigator.of(context).pop();
    print('Yeni ip değeri yazıldı');
  }

  Future<void> getIp() async {
    _ipController.text =
        await secureStorage.read(key: Constants.connectionIpAddress) ?? "";
    _portNumberController.text =
        await secureStorage.read(key: Constants.connectionPortNumber) ?? "";
    _timeoutController.text =
        await secureStorage.read(key: Constants.connectionTimeout) ?? "";
    _interRequestDelayController.text =
        await secureStorage.read(key: Constants.connectionInterRequestDelay) ??
            "";
    _holdingRegisterBlockSizeController.text = await secureStorage.read(
            key: Constants.connectionHoldingRegisterBlockSize) ??
        "";
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

        //localization try
        //title: const Text('Bağlantı Ayarları'),
        //  title: Text(AppLocalizations.of(context)!.helloWorld),
        title: Text(AppLocalizations.of(context)?.connectionSettings ?? ''),

        //this way, it shows an empty string instead of giving null error.
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: const BorderSide(
                  color: Colors.black,
                ),
              ),
              child: ListTile(
                title: Text(AppLocalizations.of(context)?.ipAddress ?? ''),
                subtitle: TextFormField(
                  controller: _ipController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      // hintText: 'Ip adresinizi giriniz',
                      // contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: const BorderSide(
                  color: Colors.black,
                ),
              ),
              child: ListTile(
                title: Text(
                    AppLocalizations.of(context)?.portNumber ?? ''),
                subtitle: TextFormField(
                  controller: _portNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixText: AppLocalizations.of(context)?.portNumber ?? '',
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: const BorderSide(
                  color: Colors.black,
                ),
              ),
              child: ListTile(
                title: Text(AppLocalizations.of(context)?.timeout ?? ''),
                subtitle: TextFormField(
                  controller: _timeoutController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixText: AppLocalizations.of(context)?.miliSec ?? '',
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: const BorderSide(
                  color: Colors.black,
                ),
              ),
              child: ListTile(
                title:
                    Text(AppLocalizations.of(context)?.interRequestDelay ?? ''),
                // title: const Text('Inter Request Delay'),
                subtitle: TextFormField(
                  controller: _interRequestDelayController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixText: AppLocalizations.of(context)?.miliSec ?? '',
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: const BorderSide(
                  color: Colors.black,
                ),
              ),
              child: ListTile(
                title: Text(AppLocalizations.of(context)?.holdingRegMsg ?? ''),
                subtitle: TextFormField(
                  controller: _holdingRegisterBlockSizeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixText: AppLocalizations.of(context)?.miliSec ?? '',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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

                  child: Text(AppLocalizations.of(context)?.save ?? ''),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Column(
              children: [
                Icon(Icons.warning, color: Colors.yellow),
                SizedBox(height: 8.0),
                Text(
                  AppLocalizations.of(context)?.optWarning ?? '',
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
