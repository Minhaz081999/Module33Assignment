
import 'package:flutter/material.dart';
// user defined function() ---------------
void showSnackBarMessage(BuildContext context , String message ){
  // Flutter widget --------------------
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message) )
  );
}