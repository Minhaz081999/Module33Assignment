import 'package:flutter/material.dart';

//
// class IncDecButton extends StatefulWidget {
//   const IncDecButton({super.key,  required this.onChange, this.initialValue });
//
//   final Function(int) onChange;
//   final int? initialValue;
//
//   @override
//   State<IncDecButton> createState() => _IncDecButtonState();
// }
//
// class _IncDecButtonState extends State<IncDecButton> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     if(widget.initialValue != null ){
//       counter = widget.initialValue!;
//     }
//   }
//
//   // variable
//   int counter = 1;
//   // increment function
//   void Increment(){
//     counter = counter + 1;
//     widget.onChange(counter);
//     setState(() {});
//   }
//   // decrement function
//   void Decrement(){
//     if( counter > 0 ){
//       counter = counter - 1;
//       widget.onChange(counter);
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         // Minus Icon Button
//         IconButton(onPressed: Decrement, icon: Icon(Icons.remove)),
//         // number
//         Text('$counter'),
//         // Plus Icon Button
//         IconButton(onPressed: Increment, icon: Icon(Icons.add))
//       ],
//     );
//   }
// }
class IncDecButton extends StatefulWidget {
  const IncDecButton({
    super.key,
    required this.onChange,
    this.initialValue,
    required this.maxValue,
  });

  final Function(int) onChange;
  final int? initialValue;
  final int maxValue;

  @override
  State<IncDecButton> createState() => _IncDecButtonState();
}

class _IncDecButtonState extends State<IncDecButton> {
  int _counter = 1;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _counter = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (_counter > 1) {
              _counter--;
              widget.onChange(_counter);
              setState(() {});

            }
          },
          icon: Icon(Icons.remove),
        ),
        Text('$_counter', style: TextStyle(fontSize: 16)),
        IconButton(
          onPressed: () {
            if (_counter >= widget.maxValue) return;

            _counter++;
            widget.onChange(_counter);
            setState(() {});
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}