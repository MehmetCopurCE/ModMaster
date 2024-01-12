import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_project/utils/constants.dart';

class ConnectionService {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> setConnectionProperties() async {
    String portNumber = await secureStorage.read(key: Constants.connectionPortNumber) ?? "";
    String timeout = await secureStorage.read(key: Constants.connectionTimeout) ?? "";
    String interRequestDelay = await secureStorage.read(key: Constants.connectionInterRequestDelay) ?? "";
    String holdingRegisterBlockSize = await secureStorage.read(key: Constants.connectionHoldingRegisterBlockSize) ?? "";

    if (portNumber == "") {
      await secureStorage.write(key: Constants.connectionPortNumber, value: "502");
    }

    if (timeout == "") {
      await secureStorage.write(key: Constants.connectionTimeout, value: "3000");
    }

    if (interRequestDelay == "") {
      await secureStorage.write(key: Constants.connectionInterRequestDelay, value: "100");
    }

    if (holdingRegisterBlockSize == "") {
      await secureStorage.write(key: Constants.connectionHoldingRegisterBlockSize, value: "32");
    }
  }
}
