import 'package:flutter/material.dart';


class Withconst extends StatefulWidget {
  const Withconst({super.key,this.subject, this.phobeNumber, this.reg = 2391, required this.department});
  // For constructor variables declare and initialize
  final String? subject;
  final int? phobeNumber;
  final int reg;
  final String department;

   // normal variable declare and initialize
  final String name = 'Minhaz';
  final int num = 1;

   
  @override
  State<Withconst> createState() => _WithconstState();
}

class _WithconstState extends State<Withconst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('${widget.name} ${widget.phobeNumber} ${widget.reg}'),
    );
  }
}
