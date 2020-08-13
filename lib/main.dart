// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

//import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

import 'package:flutter/material.dart';

import 'letterView.dart';

import 'ScannerUtils.dart';

import 'detector_painters.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,

      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[700],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Scan Tan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".





  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

//  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  String letter='Press the plus button';


  bool _isDetecting = false;

  VisionText _textScanResults;

  CameraLensDirection _direction = CameraLensDirection.back;

  CameraController _camera;

  final TextRecognizer _textRecognizer =
  FirebaseVision.instance.textRecognizer();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final CameraDescription description =
    await ScannerUtils.getCamera(_direction);

    _camera = CameraController(
      description,
      ResolutionPreset.high,
    );

    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {

      // Here we will scan the text from the image
      // which we are getting from the camera.

      if (_isDetecting) return;

      setState(() {

        _isDetecting = true;
      });
      ScannerUtils.detect(
        image: image,
        detectInImage: _getDetectionMethod(),
        imageRotation: description.sensorOrientation,
      ).then(
            (results) {
          setState(() {
            if (results != null) {
              setState(() {
                _textScanResults = results;
                List<TextBlock> blocks = _textScanResults.blocks;
                letter=blocks[0].text;
              });
            }
          });
        },
      ).whenComplete(() => _isDetecting = false);
    });
  }


  Widget _buildImage() {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: _camera == null
          ? const Center(
        child: Text(
          'Initializing Camera...',
          style: TextStyle(
            color: Colors.green,
            fontSize: 30.0,
          ),
        ),
      ) : GestureDetector (

        onTap:(){
if(letter != 'Press the plus button') {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LetterView(letter: letter)),
  ); //go to another class
}
        },

      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CameraPreview(_camera),
          _buildResults(),
      Text(letter,style: TextStyle(fontSize: 30.0, foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.7
        ..color = Color(0xFF80cde0),fontFamily: "Ewert"

      )),

        ],
    ),
    ),
    );
  }

  Widget _buildResults() {
    const Text noResultsText = const Text('No results!');

    if (_textScanResults == null ||
        _camera == null ||
        !_camera.value.isInitialized) {
      return noResultsText;
    }

    CustomPainter painter;


    final Size imageSize = Size(
      _camera.value.previewSize.height ,
      _camera.value.previewSize.width,
    );



        painter = TextDetectorPainter(imageSize, _textScanResults);


    return CustomPaint(
      painter: painter,
    );
  }


  Future<VisionText> Function(FirebaseVisionImage image) _getDetectionMethod() {
    return _textRecognizer.processImage;
  }







//  @override
//  void initState() {
//    super.initState();
//
////    FlutterMobileVision.start().then((x) => setState(() {}));
////
////    FlutterMobileVision.start().then((previewSizes) => setState(() {
////      _previewOcr = previewSizes[_cameraOcr].first;
////    }));
//  }

  void _incrementCounter() {

    setState(() {
//      _read();

      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to return the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(


      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _buildImage(),
      floatingActionButton: FloatingActionButton(
        onPressed:  _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

//  Future<Null> _read() async {
//    List<OcrText> texts = [];
//    try {
//      texts = await FlutterMobileVision.read(
//        camera: _cameraOcr,
//        fps: 2.0,
//        waitTap: true,
//      );
//
//
//        letter = texts[0].value; // the return value
//
//      Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => LetterView(letter: texts[0].value)),
//      );//go to another class
//      // add if statement here
//
//    } on Exception {
////      texts.add(new OcrText('Failed to recognize text.'));
//    }
//
//  }


  Future<bool> onbackpresseddialog(){
    return showDialog(//builds dialogs

      context:context,
      builder:(context)=> AlertDialog(

          title:Text("Do you really want to close?"),

          actions: <Widget>[

            FlatButton(
              child: Text("No"),
              onPressed: ()=>Navigator.pop(context,false),

            ),
            FlatButton(
              child: Text("Yes"),
              onPressed: ()=>Navigator.pop(context,true),

            ),

          ]

      ),
    );
  }
}

