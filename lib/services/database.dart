import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:widgetpractice/models/AuthModel.dart';

class Database
{
  static String saveFdUserTable = "user";

//static FirebaseFirestore? database;


 static Future saveDataBase({Auth? authAllData,})
  async {
   await FirebaseFirestore.instance.collection(saveFdUserTable).doc(authAllData!.uid).set(
     authAllData.toJson()
   ).then((value){
     print('Data Inserted');
   });
  }
}
