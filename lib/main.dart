import 'package:finsec/logic/stores/auth_store.dart';
import 'package:finsec/logic/stores/state_store.dart';
import 'package:finsec/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // initialise firebase messaging
  FirebaseMessaging.instance.setAutoInitEnabled(true);
  // check if supported
  logger.d("Token: ${await FirebaseMessaging.instance.isSupported()}");
  logger.d("Token: ${await FirebaseMessaging.instance.getToken()}");

  // upon notification while app is in foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    logger.d("Token: $message");
  });
  FirebaseMessaging.onBackgroundMessage((message) async {
    logger.d("Token: $message");
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).brightness == Brightness.light ? Palette.white : null,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    SizeConfig().init(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthStore()),
        ChangeNotifierProvider(create: (_) => StateStore()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.system,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
