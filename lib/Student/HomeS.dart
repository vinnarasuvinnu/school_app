import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/Student/productInfo.dart';
import 'package:flutter_application/Teacher/create.dart';

//this page insnt loading since formating the ui 
//aslo the data shown in stream builder needs to be sorted by start date and 
//classes past end date need to be deleted from firebase

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  late CollectionReference _reference;
  List allData = [];
  @override
  void initState() {
    super.initState();
    _reference = FirebaseFirestore.instance.collection('Product');
    print(_reference);
    getData();
  }

  Future<void> getData() async {
    print("get data");
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _reference.get();
    print(querySnapshot);
    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(allData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome!!!'),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Product') //  collection name here
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductInfo(data_info: data)),
                    );
                    print('somwething*****************************');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                       padding: EdgeInsets.all(16),
                       decoration:  BoxDecoration(
                         color: Color.fromARGB(60, 241, 244, 223),
                        border: Border.all(width: 5),
                        borderRadius: BorderRadius.circular(30),
                       ),


                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(data['name'],
                              style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20),),

                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  data['price'].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14),),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ( data['imageUrl']!=null && data['imageUrl']!= "")? Image.network(

                                    data['imageUrl'],
                                    fit: BoxFit.fill,
                                  ):Container(),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),

                    ),
                  ),

                );
              }).toList()),
            );
          },
        ),
      ),
    );
  }
}
