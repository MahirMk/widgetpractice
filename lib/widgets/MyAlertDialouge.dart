import 'package:flutter/material.dart';
import '../resources/StyleResources.dart';

logOutDialogue(BuildContext context,String title,String content,Function()? btn1,String text1,Function()? btn2,String text2){
  AlertDialog alert = AlertDialog(
    title: Text(title,style: Theme.of(context).textTheme.headline6),
    backgroundColor: StyleResources.tealDarkColor,
    content:  Text(content,style: const TextStyle(color: Colors.white)),
    actions: [
      TextButton(
        onPressed: btn1, child:  Text(text1,style: Theme.of(context).textTheme.subtitle2),
      ),
      TextButton(onPressed: btn2, child: Text(text2,style: Theme.of(context).textTheme.subtitle2),),
    ],
  );
  showDialog(context: context, builder: (BuildContext context){
    return alert;
  });
}
simpleDialogue(BuildContext context,String data,){
  AlertDialog alert = AlertDialog(
    title: Text(data,style: Theme.of(context).textTheme.headline6),
    backgroundColor: StyleResources.tealDarkColor,
    actions: [
      TextButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        child: Text("OK",style: Theme.of(context).textTheme.subtitle2),),
    ],
  );
  showDialog(context: context, builder: (BuildContext context){
    return alert;
  });
}
