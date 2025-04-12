import 'package:flutter/material.dart';

class PecentageIndi extends StatelessWidget
{
  const PecentageIndi({super.key});

  @override
  Widget build(BuildContext context) {
   
   return Scaffold(
    body:Center(
      child: Container(
        height: MediaQuery.of(context).size.height*2/100,
         width: MediaQuery.of(context).size.width*90/100,
        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(30),
          color:const Color.fromARGB(255, 233, 216, 167)
        ),
      ),
    )
   );
  }
  
}