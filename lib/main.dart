import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_web_login/Src/Auth/Auth.dart';
import 'package:firebase_web_login/Src/Home/Home.dart';
import 'package:flutter/material.dart';

import 'package:firebase_web_login/Src/Const/Utils.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDE4Di6xXb7TILechjB49q94sPbOEztNKc",
        appId: "1:694070348483:web:7887a3d8c799ecd448b076",
        messagingSenderId: "694070348483",
        projectId: "website-16c0d"
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Utils.messengerKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: Colors.black,),);
          }else if(snapshot.hasError){
            return Center(child: Text('Something went wrong'),);
          }else if(snapshot.hasData){
            return Home();
          }else{
            return Auth();
          }
        },
      ),
    );
  }
}

