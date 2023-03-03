import 'package:waapusha/models/hive_report.dart';
import 'package:waapusha/screens/info_screen.dart';
import 'package:waapusha/screens/sending_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import './models/report_format.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './models/boxes.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/Intro_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

late Box reports;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RDDreportAdapter());
  await Hive.openBox<RDDreport>("rdd_report");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rice Leaf Disease Detection',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //home: const MyHomePage(),
      home: AnimatedSplashScreen(
        backgroundColor: Colors.green.shade200,
        splash: intro_screen(),
        nextScreen: MyHomePage(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final report_fetch_box = Hive.box('RDD_reports');
  @override
  void initState() {
    readReports();
    super.initState();
  }

  List<RDDreport> report_list = [];
  List<RDDreport> display_list = [];
  List key_list = [];

  Future<List<RDDreport>> readReports() async {
    final mybox = boxes.getRddreports();
    setState(() {
      report_list = mybox.values.toList();
      display_list = report_list;
    });
    return (mybox.values.toList());
  }

  XFile? image;
  dynamic resJson;
  confirmSend(File imagefile) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SendingScreen(imagefile: imagefile),
        ));
  }

  Future getimage(bool isCamera) async {
    XFile? image;
    if (isCamera) {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    setState(() {
      try {
        confirmSend(File(image!.path));
      } catch (iden) {}
    });
  }

  updatelist(String value) {
    setState(() {
      display_list = report_list
          .where((element) =>
              element.report_name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  openReport(RDDreport reportTemp) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InfoScreen(
              report: Album(
                  disease: reportTemp.disease,
                  overview: reportTemp.overview,
                  preventive_measure: reportTemp.preventive_measure,
                  symptoms: reportTemp.symptoms,
                  solution: reportTemp.solution,
                  segmented_image: reportTemp.seg_img),
              report_name: reportTemp.report_name,
              orginal_image: reportTemp.org_img),
        ));
  }

  Future delete_confrimation(report_inst) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                  'Do you want to delete report: ${report_inst.report_name}?'),
              actions: [
                TextButton(
                    onPressed: () {
                      report_inst.delete();

                      readReports();
                      Navigator.pop(context);
                    },
                    child: Text('Delete')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // here the desired height
        child: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          //centerTitle: true,
          title: Row(children: [
            Text(
              "WAA",
              style: GoogleFonts.abrilFatface(
                color: Colors.green.shade900,
                fontSize: 50.0,
              ),
            ),
            Text(
              "PUSHA",
              style: GoogleFonts.abrilFatface(
                fontSize: 50,
              ),
            ),
          ]),
          backgroundColor: Colors.green.shade200,
          elevation: 0.0,
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: IconButton(
                onPressed: () {
                  getimage(false);
                },
                tooltip: 'Gallery',
                icon: Icon(Icons.image, size: 30, color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: IconButton(
                onPressed: () {
                  getimage(true);
                },
                tooltip: 'Camera',
                icon: Icon(Icons.camera_enhance, size: 30, color: Colors.white),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              onChanged: (value) => updatelist(value),
              style: const TextStyle(color: Colors.green),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 253, 253, 253),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 3, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                hintStyle: const TextStyle(color: Colors.green),
                hintText: "Search Report",
                prefixIcon: const Icon(Icons.search),
                focusColor: Colors.green,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Recent Reports:',
                    style: TextStyle(
                      fontSize: 23.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: display_list.length,
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        openReport(display_list[index]);
                      },
                      child: Container(
                        color: display_list[index].disease == "Healthy"
                            ? Colors.green.shade50
                            : Colors.red.shade100,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          title: Text(
                            display_list[index].report_name,
                          ),
                          subtitle: Text(display_list[index].disease),
                          trailing: IconButton(
                            onPressed: () {
                              delete_confrimation(display_list[index]);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent.shade400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
