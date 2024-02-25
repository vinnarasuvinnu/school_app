// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_application/otpVerify.dart';
// import 'package:image_picker/image_picker.dart';
//
// class create extends StatefulWidget {
//   const create({Key? key}) : super(key: key);
//
//   @override
//   State<create> createState() => _createState();
// }
//
// class _createState extends State<create> {
//   final controllerPName = TextEditingController();
//   final controllerNumber = TextEditingController();
//   String profileimage = '';
//   DateTime date = DateTime(2023, 1, 18, 0, 0, 0, 0, 0);
//   DateTime? dateob = DateTime(2023, 1, 18, 0, 0, 0, 0, 0);
//
//   Future createUsers(users) async {
//     final docProduct = FirebaseFirestore.instance.collection('Users').doc();
//     users.id = docProduct.id;
//
//     final json = users.toJson();
//     await docProduct.set(json);
//     print(json);
//     print('reached herere');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('Create')),
//         body: ListView(padding: EdgeInsets.all(16), children: <Widget>[
//           TextField(
//             controller: controllerPName,
//             decoration: const InputDecoration(
//               labelText: 'Name',
//               contentPadding:
//                   EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton(
//               child: const Text('upload picture button'),
//               onPressed: () async {
//                 ImagePicker imagePicker = ImagePicker();
//                 XFile? file =
//                     await imagePicker.pickImage(source: ImageSource.gallery);
//                 print('${file?.path}');
//
//                 if (file == null) return;
//
//                 String uniqueFileName =
//                     DateTime.now().millisecondsSinceEpoch.toString();
//
//                 Reference referenceRoot = FirebaseStorage.instance.ref();
//                 Reference referenceDirImages = referenceRoot.child('images');
//                 Reference referenceImageToUpload =
//                     referenceDirImages.child(uniqueFileName);
//
//                 try {
//                   await referenceImageToUpload.putFile(File(file!.path));
//
//                   profileimage = await referenceImageToUpload.getDownloadURL();
//                   print(profileimage);
//                   print("cooll dsfadsfadsf**************");
//                 } catch (error) {}
//
//                 if (profileimage.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('please upload an image')));
//                   return;
//                 }
//               }), //upload picture button
//           TextField(
//             controller: controllerNumber,
//             decoration: const InputDecoration(
//               hintText: '01234567890',
//               labelText: 'Phone number',
//               contentPadding:
//                   EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 24),
//
//           const SizedBox(
//             width: 10,
//           ),
//
//           Row(children: [
//             Text('${date.day}/${date.month}/${date.year}'),
//             const SizedBox(width: 16),
//             ElevatedButton(
//               child: const Text('End date'),
//               onPressed: () async {
//                 dateob = await showDatePicker(
//                   context: context,
//                   initialDate: date,
//                   firstDate: DateTime(1900),
//                   lastDate: DateTime(2100),
//                 );
//                 if (dateob == null) return;
//                 setState(() {
//                   date = dateob!;
//                 });
//               },
//             ), //end d
//           ]),
//
//           const SizedBox(height: 24),
//           ElevatedButton(
//               child: Text('create'),
//               onPressed: () {
//                 final users = Users(
//                   name: controllerPName.text,
//                   number: controllerNumber.text,
//                   dateob: dateob!,
//                   profileimage: profileimage,
//                 );
//                 // Navigator.pop(context);
//
//                 createUsers(users);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => OTP_Verify(),
//                   ),
//                 );
//               }),
//         ]));
//   }
// }
//
// class Users {
//   String id; //can the id refer to the id of teacher from user auth?
//               like a foreign key to acess the auth table
//
//   final String name;
//   final String number;
//   final DateTime dateob;
//   final String profileimage;
//
//   Users({
//     this.id = '',
//     required this.name,
//     required this.number,
//     required this.dateob,
//     required this.profileimage,
//   });
//
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'name': name,
//         'number': number,
//         'dateob': dateob,
//         'profileimage': profileimage,
//       };
// }
