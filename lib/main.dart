import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:politics_game/providers/user_provider.dart';
import 'package:politics_game/responsive/mobile_screen_layout.dart';
import 'package:politics_game/responsive/responsive_layout_screen.dart';
import 'package:politics_game/responsive/web_screen_layout.dart';
import 'package:politics_game/screens/start/login_screen.dart';
import 'package:politics_game/screens/start/signup_screen.dart';
import 'package:politics_game/screens/start/start_screen.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      // I AM NOT SHOWING MY CREDENTIALS HERE. THE APP WONT WORK WITHOUT THESE CREDENTIALS!!!
        options: const FirebaseOptions(
            apiKey: "API_KEY",
            appId: "APP_ID",
            messagingSenderId: "MESSAGEING_SENDER_ID",
            projectId: "PROJEXT_ID",
            storageBucket: "STORAGE_BUCKET"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Comfortaa'),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            print(snapshot.connectionState.toString());

            // if snapshot has data, then user is authenticated
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            // if snapshot does not have data, user needs to login
            return const StartScreen();
          },
        ),
      ),
    );
  }
}
