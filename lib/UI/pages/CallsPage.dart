import 'package:flutter/material.dart';

class CallsPage extends StatefulWidget {
  const CallsPage({Key? key}) : super(key: key);

  @override
  State<CallsPage> createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context,int index){
            return ListTile(
              leading: CircleAvatar(
                child: Text("MK",style: Theme.of(context).textTheme.subtitle2,),
              ),
              title:  Text("Mahir Kangda",style: Theme.of(context).textTheme.bodyText1,),
              subtitle:  Text("Hi...",style: Theme.of(context).textTheme.bodyText1,),
              trailing:  Text("10:00 AM",style: Theme.of(context).textTheme.bodyText1,),
              onTap: (){},
            );
        }

      ),
    );
  }
}
