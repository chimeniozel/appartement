import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/auth/authentication.dart';
import 'providers/input_provider.dart';
import 'theme/color.dart';
import 'widgets/bottom_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InputProvider(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Appartement',
        theme: ThemeData(
            primaryColor: primaryColor, fontFamily: 'AkayaTelivigala'),
        home: FirebaseAuth.instance.currentUser != null
            ? const BottomBar()
            : const Authentication(),
      ),
    );
  }
}
