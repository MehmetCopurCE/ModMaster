import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_project/data/register_list.dart';
import 'package:mobile_project/main.dart';
import 'package:mobile_project/models/write_register.dart';
import 'package:mobile_project/service/register_service.dart';
import 'package:mobile_project/utils/constants.dart';
import 'package:mobile_project/utils/custom_toast_message.dart';
import 'package:modbus/modbus.dart' as modbus;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterNotifier extends StateNotifier<List<int>> {
  RegisterNotifier() : super([]) {
    // Başlangıçta ve ardından belirli bir süre aralığında veri okuma işlemini başlatın
    startReadingData();
  }

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  RegisterService registerService = RegisterService();
  late modbus.ModbusClient client;
  //TODO Bu yazılacak registerları provider ile kontrol edebiliriz
  List<WriteRegister> writeRegisters = [];

  String ipAddress = "";
  int portNumber = 502;

  Future<void> startReadingData() async {
    await createClient();
    while (true) {
      await readData(); // Veri okuma işlemini çağırın ve tamamlanmasını bekleyin
      await Future.delayed(const Duration(milliseconds: 5000)); // 2 saniye bekleyin
    }
  }

  ///Client bir defa burada oluşturuluyor
  Future<void> createClient() async {
    ipAddress = await getIpAddress();
    portNumber = await getPortNumber();
    int timeout = await getTimeout();
    try {
      client = modbus.createTcpClient(ipAddress,
          port: portNumber,
          mode: modbus.ModbusMode.rtu,
          //timeout: Duration(seconds: 3));
          timeout: Duration(milliseconds: timeout));
      print('Client oluşturuldu');
    } catch (e) {
      print('Client oluşturulamadı. Hata: ${e.toString()}');
    }
  }

  ///Modbus veri okuma
  Future<void> readData() async {
    List<int> updatedRegisters = [];
    String userEmail = await getUserEmail();

    try {
      await connectClient();

      if (writeRegisters.isNotEmpty) {
        await writeTag(writeRegisters);
      }

      int registerAmount = registerService.getRegisterCount(mapRegisterList);
      int readRegister = await getReadRegister();
      int interRequestDelay = await getInterRequestDelay();
      List<int> readedRegisters = [];
      for (int i = 0; i < registerAmount; i += readRegister) {
        List<int> registers = [];
        if (i + readRegister > registerAmount) {
          registers = await client.readHoldingRegisters(i, (registerAmount - i)).timeout(Duration(seconds: 1));
          //await Future.delayed(Duration(milliseconds: 100));
          await Future.delayed(Duration(milliseconds: interRequestDelay)); // 2 s¬niye bekleyin
        } else {
          registers = await client.readHoldingRegisters(i, readRegister).timeout(Duration(seconds: 1));
          //await Future.delayed(Duration(milliseconds: 100));
          await Future.delayed(Duration(milliseconds: interRequestDelay)); // 2 saniye bekleyin
        }
        readedRegisters.addAll(registers);
        //print('Okunan tag sayısı: ${readedRegisters.length}');
      }

      updatedRegisters = readedRegisters;
      // state = updatedRegisters;
      //updatedRegisters = [];
      print('Okunan register sayısı: ${updatedRegisters.length}');
    } catch (e) {
      updatedRegisters = [];
      print('Tag okurken hata: ${e.toString()}');
    } finally {
      await closeClientConnection();
      final dummyList = registerService.getDummyList();
      //state = updatedRegisters;
      state = dummyList;
      fireStoreService.updateAllRegistersInBatch2(userEmail, state);
      print('Bir Modbus okuma döngüsü bitti');
    }
  }

  /// Kullanıcının girdiği ip address i burada alıyoruz
  Future<String> getIpAddress() async {
    final String ipAddress = await secureStorage.read(key: Constants.connectionIpAddress) ?? "";
    return ipAddress;
  }

  Future<int> getPortNumber() async {
    String stringPortNumber = await secureStorage.read(key: Constants.connectionPortNumber) ?? "502";
    int portNumber = int.parse(stringPortNumber);
    return portNumber;
  }

  /// Kullanıcının belirlediği timout süresini burada alıyoruz
  Future<int> getTimeout() async {
    String stringTimeout = await secureStorage.read(key: Constants.connectionTimeout) ?? "";
    int timeout = int.parse(stringTimeout);
    return timeout;
  }

  Future<int> getReadRegister() async {
    String stringReadRegister = (await secureStorage.read(key: Constants.connectionHoldingRegisterBlockSize))!;
    int readRegister = int.parse(stringReadRegister);
    return readRegister;
  }

  Future<int> getInterRequestDelay() async {
    String stringInterRequestDelay = (await secureStorage.read(key: Constants.connectionInterRequestDelay))!;
    int interRequestDelay = int.parse(stringInterRequestDelay);
    return interRequestDelay;
  }

  /// Kullanıcının girdiği ip address i burada alıyoruz
  Future<String> getUserEmail() async {
    final String userEmail = await secureStorage.read(key: Constants.userEmail) ?? "";
    return userEmail;
  }

  /// Modbus bağlantı kurma
  Future<void> connectClient() async {
    try {
      await client.connect();
      print('Client bağlantı kuruldu.');
    } catch (e) {
      print('Client bağlantı kurulamadı. Hata: ${e.toString()}');
    }
  }

  /// Modbus bağlantı kapatma
  Future<void> closeClientConnection() async {
    try {
      await client.close();
      print('Client bağlantı kapatıldı.');
    } catch (e) {
      print('Client bağlantı kapatılamadı. Hata: ${e.toString()}');
    }
  }

  Future<void> writeTag(List<WriteRegister> writeRegisterList) async {
    try {
      for (var i = 0; i < writeRegisterList.length; i++) {
        await client.writeSingleRegister(writeRegisterList[i].registerAddress, writeRegisterList[i].newValue);
        print('Veri yazıldı');
        //writeRegisterList.remove(writeRegisters[i]);
        writeRegisterList.removeWhere((register) => register.id == writeRegisterList[i].id);
        print('Veri listeden silindi');
        await Future.delayed(const Duration(milliseconds: 20)); // 0.2 saniye bekleyin
        ToastMessage('Yeni değer yazıldı');
      }
    } catch (e) {
      print('Tag yazarken hata: ${e.toString()}');
    }
  }
}

final registerProvider = StateNotifierProvider<RegisterNotifier, List<int>>((ref) => RegisterNotifier());
