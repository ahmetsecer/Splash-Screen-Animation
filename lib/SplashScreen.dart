import 'package:flutter/material.dart';
import 'package:splashscreenanimation/main.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class Helper {
  static const String appBarTitle = "Home Page";
  static const String centerGifUrl = "assets/images/logo.json";
  static const String bottomGifUrl = "assets/images/loading.json";
  static const String tokenUrl = "https://example.com/get_token";
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token = '';

  @override
  void initState() {
    super.initState();
    //getToken();

    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  Future<void> getToken() async {
    // Burada token almak için servise istek gönderilecek.
    var response = await http.get(Uri.parse(Helper.tokenUrl));
    if (response.statusCode == 200) {
      setState(() {
        token = response.body; // Gerçek uygulamada JSON parsing gerekebilir.
      });
    } else {
      // Hata işleme
      print("Token alınamadı: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Lottie.asset(
              Helper.centerGifUrl,
              width: 200,
              height: 200,
              //fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 30),
                child: Lottie.asset(
                  Helper.bottomGifUrl,
                  width: 50,
                  height: 50,
                )),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
