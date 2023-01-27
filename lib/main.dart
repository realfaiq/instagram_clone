import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import './resopnsive/responsiveLayoutScreen.dart';
import './resopnsive/mobileScreenLayout.dart';
import './resopnsive/webScreenLayout.dart';
import './screens/login_Screen.dart';
import './screens/signup_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyBS2fdDQkRH-5fp85wLn0SPz4BKMmEURV8',
            appId: '1:646236125180:web:ae1340960cd30d4bf02479',
            messagingSenderId: '646236125180',
            projectId: 'instagram-clone-9b318',
            storageBucket: 'instagram-clone-9b318.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: ResponsiveLayoutScreen(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: SignUpScreen(),
    );
  }
}
