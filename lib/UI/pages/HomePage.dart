import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:widgetpractice/utils/helper.dart';

import '../../models/PersonModel.dart';


final List<Person> personList = [
  Person(name: "Mahir", id: 1,),
  Person(name: "Faheem", id: 2,),
  Person(name: "Faisal", id: 3,),
  Person(name: "Saad", id: 4,),
  Person(name: "anas", id: 5,),
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? email;
  String? password;
  String? uid;

  String? gidName;
  String? gidEmail;
  String? gidPhoto;
  String? gidUid;

  String? fbEmail;
  String? displayName;
  String? photoURL;


  // Future getUserInfo() async {
  //   String? data = await Helper.getUserData();
  //   setState(() {
  //     email = jsonDecode(data!)['Email'];
  //     password = jsonDecode(data)['Password'];
  //     uid = jsonDecode(data)['Uid'];
  //     gidName = jsonDecode(data)['gName'];
  //     gidEmail = jsonDecode(data)['gEmail'];
  //     gidPhoto = jsonDecode(data)['gPhoto'];
  //     gidUid = jsonDecode(data)['gGoogleID'];
  //     displayName = jsonDecode(data)['displayName'];
  //     photoURL = jsonDecode(data)['photoURL'];
  //   });
  //}
  dynamic dropdownValue;
  readData() async {
   // SharedPreferences prefs = await SharedPreferences.getInstance();
    Helper.getFriend().then((value){
      setState(() {
        dropdownValue = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getUserInfo();
    readData();
    //print(personList[2].name);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 1.h),
            Visibility(
              visible: false,
              child: IntlPhoneField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
            ),
            SizedBox(height: 1.h),
            SizedBox(
              width: 100.w,
              child: Column(
                children: [
                  Card(
                    elevation: 10,
                    color: Colors.teal.shade800,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(height: 1.h,),
                            Text('name: $displayName',style: Theme.of(context).textTheme.bodyText2,),
                            Text('email: $email',style: Theme.of(context).textTheme.bodyText2,),
                            Text('password: $password',style: Theme.of(context).textTheme.bodyText2,),

                           // Text('$data',style: const TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold,),),

                            SizedBox(height: 1.h,),

                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
           //(gidPhoto) != null ? Image.network(gidPhoto!) : const CircularProgressIndicator(),
            Center(
            child: DropdownButton(
            hint: const Text('Please choose a Person'),
            value: dropdownValue,
            onChanged: (newValue) {
              setState(()  {
                dropdownValue = newValue;
                Helper.saveFriend(dropdownValue!);
                print(dropdownValue);
              });
            },
            items: personList.map((data) {
              return DropdownMenuItem(
                value:  data.id,
                child:  Text(data.name!),
              );
            }).toList(),
          ),
        ),
        ]
        ),
      ),
    );
  }
}
