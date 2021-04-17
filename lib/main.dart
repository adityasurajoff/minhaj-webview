import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.green, statusBarColor: Colors.green));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.green),
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isconnected = false;
  @override
  void initState() {
    super.initState();
    _checkConnection().then((val) {
      setState(() {
        isconnected = val;
      });
    });
  }

  _checkConnection() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: isconnected == false
          ? Column(
              children: <Widget>[
                Container(height: 27, color: Colors.blue[300]),
                Spacer(),
                Center(child: noNetworkIcon()),
                Spacer()
              ],
            )
          : Column(
              children: <Widget>[
                Container(height: 27, color: Colors.blue[300]),
                Expanded(
                  child: Container(
                    width: size.width,
                    child: WebviewScaffold(
                      scrollBar: false,
                      url: "https://minhajpublicationsindia.com/",
                      hidden: true,
                      initialChild: Container(
                        width: size.width,
                        child: loadingScreen(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

Widget noNetworkIcon() {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
    Image(
      image: AssetImage("asset/logo.png"),
      height: 200,
      width: 200,
    ),
    SizedBox(height: 10),
    Text(
      "No network\n Check your network connection...",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
    )
  ]);
}

Widget loadingScreen() {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
    Image.asset(
      "asset/logo.png",
      height: 240,
      width: 240,
    ),
    Text(
      "Minhaj Publications India",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    Text(
      "Online Books Store",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 90),
    SpinKitRipple(color: Colors.green),
    SizedBox(
      height: 10,
    ),
    Text("Loading...", style: TextStyle(fontWeight: FontWeight.bold)),
  ]);
}
