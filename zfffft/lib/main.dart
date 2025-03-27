import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zfffft/ChatBot/const.dart';
import 'package:zfffft/firebase_options.dart';
import 'package:zfffft/screens/Setteing/themeProvider.dart';
import 'package:zfffft/screens/auth-ui/splash-screen.dart';

void main() async {
  //Activate gemini pakage
   Gemini.init(apiKey: GEMINI_API_KEY); //From const file
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    ChangeNotifierProvider(
      create: (context) => Themeprovider(),
      child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
     /* theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),*/
      home: const SplashScreen(),
      theme: Provider.of<Themeprovider>(context).themeData,
    );
  }
}
