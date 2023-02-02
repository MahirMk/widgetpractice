import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:widgetpractice/resources/StyleResources.dart';
import 'package:widgetpractice/widgets/MyAlertDialouge.dart';
import '../../services/database.dart';
import '../../utils/helper.dart';
import '../../widgets/RowPage.dart';


class UserPage extends StatefulWidget {
  const UserPage({super.key});


  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  final FirebaseAuth phAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection(Database.saveFdUserTable).where(Helper.spUid, isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
            {
              if(snapshot.hasData)
              {
                if(snapshot.data!.size<=0)
                {
                  return  const Center(child: Text("No Data"));
                }
                else
                {
                  return Column(
                    children: snapshot.data!.docs.map((document){
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                          child: SizedBox(
                            width: 400,
                            child: Card(
                              elevation: 10,
                              color: StyleResources.tealLightColor,
                              child: Column(
                                children: [

                                  const SizedBox(height: 20,),
                                  rowHP(context, 'Name', document['userName']),
                                  const SizedBox(height:20,),
                                  rowHP(context, 'Phone', document['phoneNumber']),
                                  const SizedBox(height:20,),
                                  rowHP(context, 'Email', document['email']),
                                  const SizedBox(height: 20,),
                                  rowHP(context, 'uid', document['uid']),
                                  const SizedBox(height: 20,),
                                  GestureDetector(
                                    onTap: (){
                                      logOutDialogue(context,
                                        'Warning','Are you sure you want to delete record?',
                                            (){
                                          Navigator.of(context).pop();
                                        },
                                        'Cancel',
                                        () async {
                                        //String doCid = document.id;
                                        String? uid = await Helper.getUidData();
                                        await FirebaseFirestore.instance.collection(Database.saveFdUserTable).doc(uid).delete().then((value){
                                          Navigator.of(context).pop();
                                        });
                                        },
                                        'Delete',
                                      );
                                    },
                                    child: Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 2)
                                        ),
                                        child: Center(child: Text("DELETE",style: TextStyle(color: StyleResources.tealDarkColor,fontSize: 20,fontWeight: FontWeight.bold),))
                                    ),
                                  ),
                                   const SizedBox(height: 20,),

                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              }
              else
              {
                return const Center(child: CircularProgressIndicator(),);
              }
            }
        ),
      ),
    );
  }
}


