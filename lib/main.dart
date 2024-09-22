
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/provider.dart';
import 'auth/forgetPasswordPage.dart';
import 'auth/login.dart';
import 'auth/noInternetConnection.dart';
import 'auth/sign up page.dart';
import 'home.dart';
import 'pages/Show groups.dart';
import 'colors_app.dart';
import 'firebase/firebase_options.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import connectivity_plus

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check for internet connectivity
  var connectivityResult = await (Connectivity().checkConnectivity());
  bool hasConnection = (connectivityResult != ConnectivityResult.none);

  runApp(
    ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MyApp(hasConnection: hasConnection), // Pass the connection status
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool hasConnection;

  const MyApp({super.key, required this.hasConnection});

  @override
  Widget build(BuildContext context) {
    var dataprovider = Provider.of<DataProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontSize: 20, color: app_colors.green,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        useMaterial3: true,
      ),
      home: hasConnection
          ? (dataprovider.firebaseUser != null ? Homescreen() : LoginPage())
          : NoConnectionPage(), // Show NoConnectionPage if no internet
      routes: {
        '/SignupPage': (context) => SignupPage(),
        '/Forgetpasswordpage': (context) => ForgetPasswordPage(),
        '/LoginPage': (context) => LoginPage(),
        '/HomeScreen': (context) => Homescreen(),
        '/ShowGroups': (context) => ShowGroups(),
      },
    );
  }
}
