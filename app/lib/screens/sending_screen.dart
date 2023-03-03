import 'package:flutter/material.dart';
import './splash_screen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:cross_file/cross_file.dart';

class SendingScreen extends StatefulWidget {
  const SendingScreen({super.key, required this.imagefile});
  final imagefile;
  @override
  State<SendingScreen> createState() => _SendingScreenState();
}

class _SendingScreenState extends State<SendingScreen> {
  File? _image;
  @override
  void initState() {
    super.initState();
    _image = widget.imagefile;
  }

  onUploadImage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SplashScreen(imagefile: _image),
        ));
  }

  Future<void> Crop() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: widget.imagefile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.green.shade200,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],
    );
    if (croppedFile != null) {
      _image = File(croppedFile.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.cancel),
        ),
        actions: [
          IconButton(onPressed: Crop, icon: Icon(Icons.crop)),
        ],
      ),
      body: Center(child: Image.file(_image!)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onUploadImage();
        },
        tooltip: 'Send Image',
        child: const Icon(Icons.send),
      ),
    );
  }
}
