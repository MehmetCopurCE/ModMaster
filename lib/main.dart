import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_project/data/register_list.dart';
import 'package:mobile_project/my_theme.dart';
import 'package:mobile_project/provider/register_notifier.dart';
import 'package:mobile_project/provider/theme_provider.dart';
import 'package:mobile_project/screens/auth_check.dart';
import 'package:mobile_project/service/connection_service.dart';
import 'package:mobile_project/service/firestore_service.dart';
import 'package:mobile_project/service/register_service.dart';
import 'package:mobile_project/utils/constants.dart';
import 'firebase_options.dart';

FireStoreService fireStoreService = FireStoreService();
RegisterService registerService = RegisterService();
ConnectionService connectionService = ConnectionService();
FlutterSecureStorage secureStorage = const FlutterSecureStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
  // registerService.getRegisterNames(registerList);
  registerService.createRegisterList(mapRegisterList);
  connectionService.setConnectionProperties();
  registerService.getDummyList();
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: themeMode,
      home: const AuthCheck(),
    );
  }
}

// Firebase Authentication - Profile Page  --> Şeyma
// Settings Page                           --> Ebru
// HomePage - Modbus write/read            --> Efşan
// Chart Page - Register Detail Page       --> Mehmet
