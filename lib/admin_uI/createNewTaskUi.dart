import 'package:flutter/material.dart';

class Createnewtask extends StatefulWidget
{
  Createnewtask({super.key});
  @override
 State<Createnewtask>createState()=>MycreateUi();
}
class MycreateUi extends State<Createnewtask >
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
    appBar:AppBar(),
      body:Center(
        child:Text("crate_task"),
      ),
    );
  }
}