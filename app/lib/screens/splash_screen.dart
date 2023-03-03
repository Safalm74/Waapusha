import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/report_format.dart';
import './info_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.imagefile});
  final imagefile;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var url = "http://20.244.123.24:5000/";
  int connection_flag = 1;
  var text_a = "Loading...";
  var text_b = "please wait";
  @override
  void initState() {
    super.initState();
    toinfo();
  }

  String imageToBase64() {
    List<int> imageBytes = widget.imagefile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  callnavi(report) {
    const report_name = "No_name";
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => InfoScreen(
                report: report,
                report_name: report_name,
                orginal_image: imageToBase64())));
  }

  toinfo() async {
    await onupload();
  }

  Future<void> onupload() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url + 'classify_image/'),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'file',
        (widget.imagefile).readAsBytes().asStream(),
        (widget.imagefile).lengthSync(),
        filename: (widget.imagefile).path.split('/').last,
      ),
    );
    request.headers.addAll(headers);
    //eception handeller required
    try {
      final res = await request.send().timeout(Duration(seconds: 25));
      http.Response response = await http.Response.fromStream(res);
      if (jsonDecode(response.body)["status"]) {
        callnavi(Album.fromJson(jsonDecode(response.body)));
      } else {
        text_a = "No Rice leaf Detected";
        text_b = "Or the image is blur";
        setState(() {});
      }
    } on TimeoutException catch (_) {
      connection_flag = 0;
      text_a = " ";
      text_b = "No connection established!!!";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Text(' '),
        elevation: 0.0,
        backgroundColor: Colors.green.shade200,
      ),
      body: Container(
        color: Colors.green.shade200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              connection_flag == 1
                  ? Text(
                      text_a,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white),
                    )
                  : Icon(
                      Icons.wifi_off_outlined,
                      size: 50,
                    ),
              Text(
                text_b,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
