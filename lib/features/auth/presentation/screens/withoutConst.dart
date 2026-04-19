import 'package:flutter/material.dart';

class Newpage extends StatefulWidget {
     Newpage({super.key, this.name, this.phoneNumber, required this.roll, this.reg = 2391});
    // For constructor variables declare and initialize
     String? name ;
     String? phoneNumber ;
     int roll;
     int reg;

     // Normal Variable declaration and initialization
     int? num;
     String subject = 'Computer Science and Engineering';

  @override
  State<Newpage> createState() => _NewpageState();
}

class _NewpageState extends State<Newpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Text('//For constructro vaiables declare and initialize'),
          Text('${widget.name} '),
          Text(' ${widget.phoneNumber}  '),
          Text(' ${widget.roll}'),
          Text(' ${widget.reg}'),

          Text(' // Normal Variable declaration and initialization'),
          Text(' ${widget.num}'),
          Text(' ${widget.subject}'),


        ],
      ),

    );
  }
}
