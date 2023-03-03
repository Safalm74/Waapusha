import 'package:waapusha/models/hive_report.dart';
import 'package:flutter/material.dart';
import '../models/report_format.dart';
import 'dart:convert';
import '../main.dart';
import '../models/boxes.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen(
      {super.key,
      required this.report,
      required this.report_name,
      required this.orginal_image});
  final Album report;
  final String report_name;
  final String orginal_image;

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late TextEditingController controller;
  var file_name;
  @override
  void initState() {
    // TODO: implement initState
    controller = TextEditingController();
    file_name = widget.report_name;
    super.initState();
  }

  @override
  void dispose() {
    file_name = widget.report_name;
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  Future addReport() async {
    final report_ = RDDreport(
        report_name: file_name,
        disease: widget.report.disease,
        overview: widget.report.overview,
        preventive_measure: widget.report.preventive_measure,
        symptoms: widget.report.symptoms,
        solution: widget.report.solution,
        seg_img: widget.report.segmented_image,
        org_img: widget.orginal_image);
    final box = boxes.getRddreports();
    box.add(report_);
    return report_;
  }

  Tochange(String value) async {
    file_name = value;
    setState(() {});
  }

  Future change_name() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Enter Name For Report'),
              content: TextField(
                controller: controller,
                autofocus: true,
                onChanged: (value) => Tochange(value),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      addReport();
                      returnHome();
                    },
                    child: Text('Save')),
              ],
            ));
  }

  returnHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
        ModalRoute.withName('/app/lib/main.dart'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        leading: IconButton(
            onPressed: () {
              returnHome();
            },
            icon: const Icon(Icons.home)),
        elevation: 0.0,
        centerTitle: false,
        title: Text(file_name),
        actions: [
          IconButton(
              onPressed: () {
                change_name();
              },
              icon: const Icon(Icons.download))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.report.disease == 'Healthy'
                  ? Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 200,
                                padding: const EdgeInsets.all(10),
                                child:
                                    imageFromBase64String(widget.orginal_image),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Fig: original image")
                            ],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 200,
                                padding: const EdgeInsets.all(10),
                                child:
                                    imageFromBase64String(widget.orginal_image),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Original image")
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 200,
                                padding: const EdgeInsets.all(10),
                                child: imageFromBase64String(
                                    widget.report.segmented_image),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Segmented Image")
                            ],
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  widget.report.disease == "Healthy"
                      ? const Text(
                          "No disease Detected",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      : const Text(
                          'Disease: ',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                  const SizedBox(height: 5),
                  widget.report.disease == "Healthy"
                      ? const Text(" ")
                      : Text(
                          widget.report.disease,
                          style: const TextStyle(fontSize: 16),
                        ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              widget.report.disease == "Healthy"
                  ? const Text(" ")
                  : const Text(
                      'Overview: ',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
              const SizedBox(height: 5),
              Text(
                widget.report.overview,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 25,
              ),
              widget.report.disease == "Healthy"
                  ? const Text(" ")
                  : const Text(
                      'Symptoms: ',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
              const SizedBox(height: 5),
              Text(
                widget.report.symptoms,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 25,
              ),
              widget.report.disease == "Healthy"
                  ? const Text(" ")
                  : const Text(
                      'Preventive Measure: ',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
              const SizedBox(height: 5),
              Text(
                widget.report.preventive_measure,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 25,
              ),
              widget.report.disease == "Healthy"
                  ? const Text(" ")
                  : const Text(
                      'Solution: ',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
              const SizedBox(height: 5),
              Text(
                widget.report.solution,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
