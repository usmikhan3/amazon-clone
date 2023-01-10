import 'package:amazon_firebase/layout/screen_layout.dart';
import 'package:amazon_firebase/model/product_model.dart';
import 'package:amazon_firebase/providers/user_details_provider.dart';
import 'package:amazon_firebase/screens/home_screen.dart';
import 'package:amazon_firebase/screens/product_screen.dart';
import 'package:amazon_firebase/screens/sell_screen.dart';
import 'package:amazon_firebase/screens/sign_in_screen.dart';
import 'package:amazon_firebase/screens/splash_screen.dart';
import 'package:amazon_firebase/utils/color_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserDetailProvider()),

      ],
      child: MaterialApp(
        title: 'Amazon Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,AsyncSnapshot<User?> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            }
            if( snapshot.hasData){
              //FirebaseAuth.instance.signOut();
              //return const SellScreen();
              return const ScreenLayout();

            }
              return const SignInScreen();


          },
        ),
      ),
    );
  }
}
