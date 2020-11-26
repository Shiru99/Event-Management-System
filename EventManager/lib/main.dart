import 'package:EventManager/Authorisations/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  // print("Hello");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Manager',
      // debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black, // black
        // textSelectionColor: Colors.white,
        // textSelectionHandleColor:  Colors.white,
        primaryColor: Colors.white,
        // cardColor: Colors.white,
        inputDecorationTheme: new InputDecorationTheme(
          hintStyle: TextStyle(
            color: Colors.white38,
          ),
          labelStyle: TextStyle(
              color: Colors.white,
          ),
          
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color:Colors.white,
            )
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color:Colors.white,
            )

          ),
        ),
        
      ),
      
      home: authenticate(),
    );
  }

}