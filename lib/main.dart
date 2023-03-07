import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:politics_game/providers/user_provider.dart';
import 'package:politics_game/responsive/mobile_screen_layout.dart';
import 'package:politics_game/responsive/responsive_layout_screen.dart';
import 'package:politics_game/responsive/web_screen_layout.dart';
import 'package:politics_game/screens/login_screen.dart';
import 'package:politics_game/screens/signup_screen.dart';
import 'package:politics_game/screens/start_screen.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBENpsk7ji0llz_QWA8XFl6vYzaJTxc9mQ",
            appId: "1:394788898713:web:c8fd2e8647a21bace27508",
            messagingSenderId: "394788898713",
            projectId: "politics-game-9eb21",
            storageBucket: "politics-game-9eb21.appspot.com"));
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
            return const SignupScreen();
          },
        ),
      ),
    );
  }
}
