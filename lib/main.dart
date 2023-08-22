// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:async/async.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image Upload Example',
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//    String? imagePath;

//   void onTakePictureButtonPressed() {
//     takePicture().then((String filePath) {
//       if (mounted) {
//         setState(() {
//           imagePath = filePath;
//         });

//         // Initiate file upload
//         upload(File(filePath)).then((response) {
//           print('Response: ${response.statusCode}');
//           response.stream.transform(utf8.decoder).listen((value) {
//             print('Response Data: $value');
//           });
//         });

//         if (filePath != null) {
//           // showInSnackBar('Picture saved to $filePath');
//         }
//       }
//     });
//   }

//   Future<String> takePicture() async {
//     // Simulate taking a picture and return the file path
//     String tempImagePath = '/path/to/saved/image.jpg';
//     await Future.delayed(Duration(seconds: 2)); // Simulate image capture delay
//     return tempImagePath;
//   }

//   Future<http.StreamedResponse> upload(File imageFile) async {
//     var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//     var length = await imageFile.length();
//     var uri = Uri.parse(
//         "http://192.168.56.1:8101/justborrow-service/file/upload?UploadType=USER_PROFILE&id=1");
//     var request = http.MultipartRequest("POST", uri);
//     var multipartFile = http.MultipartFile(
//       'file',
//       stream,
//       length,
//       filename: basename(imageFile.path),
//     );
//     request.files.add(multipartFile);
//     return await request.send();
//   }

//   // void showInSnackBar(String message) {
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(content: Text(message)),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Upload Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (imagePath != null)
//               Image.file(
//                 File(imagePath!),
//                 height: 200,
//               ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: onTakePictureButtonPressed,
//               child: Text('Take Picture and Upload'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:async/async.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:camera/camera.dart'; // Import the camera package
// import 'package:path_provider/path_provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras(); // Get available cameras
//   final firstCamera = cameras.first;
//   runApp(MyApp(camera: firstCamera));
// }

// class MyApp extends StatelessWidget {
//   final CameraDescription camera;

//   const MyApp({Key? key, required this.camera}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image Upload Example',
//       home: MyHomePage(camera: camera),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   final CameraDescription camera;

//   const MyHomePage({Key? key, required this.camera}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   CameraController? _controller;
//   Future<void>? _initializeControllerFuture;
//   String? imagePath;

//   @override
//   void initState() {
//     super.initState();
//     _controller = CameraController(
//       widget.camera,
//       ResolutionPreset.medium,
//     );
//     _initializeControllerFuture = _controller!.initialize();
//   }

//   @override
//   void dispose() {
//     _controller!.dispose();
//     super.dispose();
//   }

//   // void onTakePictureButtonPressed() async {
//   //   try {
//   //     await _initializeControllerFuture;
//   //     final path = join(
//   //       (await getTemporaryDirectory()).path,
//   //       '${DateTime.now()}.png',
//   //     );

//   //     await _controller!.takePicture(path);

//   //     setState(() {
//   //       imagePath = path;
//   //     });

//   //     // Initiate file upload
//   //     upload(File(imagePath!)).then((response) {
//   //       print('Response: ${response.statusCode}');
//   //       response.stream.transform(utf8.decoder).listen((value) {
//   //         print('Response Data: $value');
//   //       });
//   //     });

//   //     showInSnackBar('Picture saved to $path');
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }

//   void onTakePictureButtonPressed() async {
//   try {
//     await _initializeControllerFuture;

//     XFile picture = await _controller!.takePicture(); // Capture the picture

//     setState(() {
//       imagePath = picture.path; // Use the picture's path
//     });

//     // Initiate file upload
//     upload(File(imagePath!)).then((response) {
//       print('Response: ${response.statusCode}');
//       response.stream.transform(utf8.decoder).listen((value) {
//         print('Response Data: $value');
//       });
//     });

//     // showInSnackBar('Picture saved to ${picture.path}');
//   } catch (e) {
//     print(e);
//   }
// }

//   Future<http.StreamedResponse> upload(File imageFile) async {
//     var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//     var length = await imageFile.length();
//     var uri = Uri.parse("http://192.168.56.1:8101/justborrow-service/file/upload?UploadType=USER_PROFILE&id=1");
//     var request = http.MultipartRequest("POST", uri);
//     var multipartFile = http.MultipartFile(
//       'file',
//       stream,
//       length,
//       filename: basename(imageFile.path),
//     );
//     request.files.add(multipartFile);
//     return await request.send();
//   }

//   // void showInSnackBar(String message) {
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(content: Text(message)),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Upload Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (_controller != null && _controller!.value.isInitialized)
//               AspectRatio(
//                 aspectRatio: _controller!.value.aspectRatio,
//                 child: CameraPreview(_controller!),
//               ),
//             if (imagePath != null)
//               Image.file(
//                 File(imagePath!),
//                 height: 200,
//               ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: onTakePictureButtonPressed,
//               child: Text('Take Picture and Upload'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Upload Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Future<void> uploadImage(File imageFile) async {
    var uri = Uri.parse(
        'http://192.168.56.1:8101/justborrow-service/file/upload?UploadType=PRODUCT_MEDIA&id=1');

    var request = http.MultipartRequest('POST', uri);

    // request.headers['Content-Type'] = 'multipart/form-data';

    // Map<String, String> headers = {"Content-type": "multipart/form-data"};
     Map<String, String> headers = {"Content-type": "application/json"};
  
    // Attach the image data as the request body
    // request.files.add(http.MultipartFile.fromBytes(
    //   'file',
    //   await imageFile.readAsBytes(),
    // ));
    request.files.add(http.MultipartFile.new(
      'file',
       imageFile.readAsBytes().asStream(),
       imageFile.lengthSync(),
       filename: imageFile.path.split("/").last
    ));
  // print(await imageFile.readAsBytes().toString());
    // request.headers.addAll(headers);

    var response = await request.send();

    debugPrint(imageFile.toString());

    if (response.statusCode == 200) {
      debugPrint('Image uploaded successfully');
    } else {
      debugPrint('Image upload failed with status: ${response.statusCode}');
    }
  }

  // Future<void> uploadImage(File imageFile) async {
  //   var uri = Uri.parse(
  //       'http://192.168.56.1:8101/justborrow-service/file/upload?UploadType=USER_PROFILE&id=1'); // Replace with your actual upload URL

  //   var request = http.MultipartRequest('POST', uri);
  //   var multipartFile =
  //       await http.MultipartFile.fromPath('image', imageFile.path);
  //   request.files.add(multipartFile);

  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     print('Image uploaded successfully');
  //   } else {
  //     print('Image upload failed with status: ${response.statusCode}');
  //   }
  // }

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await uploadImage(imageFile);
    } else {
      debugPrint('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                pickImage();
              },
              child: const Text('Pick and Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
