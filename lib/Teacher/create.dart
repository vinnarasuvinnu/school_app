import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class tcreate extends StatefulWidget {
  const tcreate({Key? key}) : super(key: key);

  @override
  State<tcreate> createState() => _tcreateState();
}

class _tcreateState extends State<tcreate> {
  final controllerName = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerLink = TextEditingController();
  final controllerPrice = TextEditingController();
  bool? coursevalue = false;
  DateTime date = DateTime(2023, 1, 18, 0, 0, 0, 0, 0);
  DateTime? StartDate = DateTime(2023, 1, 18, 0, 0, 0, 0, 0);
  DateTime? EndDate = DateTime(2023, 1, 18, 0, 0, 0, 0, 0);
  DateTime time = DateTime(00, 00, 00); //hh:mm:ss hour minute format
  DateTime classtime = DateTime(00, 00, 00); //hh:mm:ss hour minute format
  String imageUrl = '';
  TimeOfDay startTime=TimeOfDay(hour: 10, minute: 0);

  Future createProduct(product) async {
    final docProduct = FirebaseFirestore.instance.collection('Product').doc();
    product.id = docProduct.id;

    final json = product.toJson();
    await docProduct.set(json);
    print(json);
    print('reachecd herere');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Create')),
        body: SingleChildScrollView(
          child: Column( children: <Widget>[
            TextFormField(
              controller: controllerName,
              decoration: const InputDecoration(
                hintText: 'Enter a course/class/workshop name',
                labelText: 'Name',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
                child: const Text('upload picture button'),
                onPressed: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  print('${file?.path}');

                  if (file == null) return;

                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();

                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('images');
                  Reference referenceImageToUpload =
                      referenceDirImages.child(uniqueFileName);

                  try {
                    await referenceImageToUpload.putFile(File(file.path));

                    imageUrl = await referenceImageToUpload.getDownloadURL();
                    print(imageUrl);
                    print("cooll dsfadsfadsf**************");
                  } catch (error) {}

                  if (imageUrl.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('please upload an image')));
                    return;
                  }
                }), //upload picture button
            TextFormField(
              controller: controllerDescription,
              decoration: const InputDecoration(
                hintText:
                    'Enter a description of the course/class/workshop in atleast 50 words include duration of class',
                labelText: 'Description',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                RegExp regex = new RegExp(r'^.{50,}$');
                if (value!.isEmpty) {
                  return "Description cannot be empty";
                }
                if (!regex.hasMatch(value)) {
                  return ("please enter at least 50 words");
                } else {
                  return null;
                }
              },
              onChanged: (value) {},
            ),
            const SizedBox(height: 24),

            const SizedBox(
              width: 10,
            ),


              Text('${date.day}/${date.month}/${date.year}'),


              ElevatedButton(
                child: const Text('Start date'),
                onPressed: () async {
                  StartDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    initialDate: date,
                  );
                  if (StartDate == null) return;
                  setState(() {
                    date = StartDate!;
                  });
                },
              ),
              const SizedBox(width: 16),

              ElevatedButton(
                child: const Text('End date'),
                onPressed: () async {
                  EndDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (EndDate == null) return;
                  setState(() {
                    date = EndDate!;
                  });
                },
              ),

              Text('${date.day}/${date.month}/${date.year}'),





              TextFormField(
                controller: controllerLink,
                decoration: const InputDecoration(
                  hintText: 'Enter a zoom or googlemeet link',
                  labelText: 'Class link',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  border: OutlineInputBorder(),
                ),
              ),



                Text('${time.hour}/${time.minute}'),

                const SizedBox(width: 16),

                ElevatedButton(
                  child: const Text('Class Start Time'),
                  onPressed: () async {
                    
                  startTime = (await showTimePicker(
                    context: context, initialTime: startTime,
                    
                  ))!;
                  if (StartDate == null) return;
                  setState(() {
                    time = classtime!;
                  });
                  },
                ), //end

                const SizedBox(height: 16),

                TextField(
                  controller: controllerPrice,
                  decoration: const InputDecoration(
                    hintText: 'Enter a suitable price in rupees',
                    labelText: 'Price',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                    child: Text('create'),
                    onPressed: () {
                      final product = Product(
                        name: controllerName.text,
                        description: controllerDescription.text,
                        StartDate: StartDate!,
                        EndDate: EndDate!,
                        price: controllerPrice.text,
                        link: controllerLink.text,
                        imageUrl: imageUrl,
                        //classtime: classtime
                      );

                      createProduct(product);
                    }),








          ]),
        ));

  }
}

class Product {
  String id;

  final String name;
  final String description;
  final DateTime StartDate;
  final DateTime EndDate;
  final String price;
  final String link;
  final String imageUrl;

  //final DateTime classtime;

  Product({
    this.id = '',
    required this.name,
    required this.description,
    required this.StartDate,
    required this.EndDate,
    required this.price,
    required this.link,
    required this.imageUrl,
    //required this.classtime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'start date': StartDate,
        'end date': EndDate,
        'price': price,
        'link': link,
        'imageUrl': imageUrl,
        //'classtime':classtime,
      };
}
