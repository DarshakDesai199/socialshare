import 'package:flutter/material.dart';
import 'package:socialshare/social_share_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Share',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SocialShareScreen(),
    );
  }
}
