import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:so_bicos/config/assets.dart';
import 'package:so_bicos/core/data/di/data_dependencies.dart';
import 'package:so_bicos/core/external/di/external_dependencies.dart';
import 'package:so_bicos/routing/router.dart';
import 'package:so_bicos/ui/designsystem/localization/app_localizations.dart';
import 'package:so_bicos/ui/designsystem/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  if (kIsWeb) {
    final json = await _loadStringAsset(Assets.googleServices);
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: json["apiKey"],
        authDomain: json["authDomain"],
        projectId: json["projectId"],
        storageBucket: json["storageBucket"],
        messagingSenderId: json["messagingSenderId"],
        appId: json["appId"],
        measurementId: json["measurementId"],
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(
    MultiProvider(
      providers: externalDependencies + dataDependencies,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), Locale('pt')],
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router(context.read()),
    );
  }
}

Future<Map<String, dynamic>> _loadStringAsset(String asset) async {
  final localData = await rootBundle.loadString(asset);
  return (jsonDecode(localData)).cast<Map<String, dynamic>>();
}