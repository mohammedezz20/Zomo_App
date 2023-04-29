import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Shared/styles/colores.dart';

 ShowSnackBar({context, text}){
  return  ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
      content:  Center(
          child: Text(
            "$text",
            style: TextStyle(color: Colors.black),
          )),
      padding: EdgeInsets.all(10),
      backgroundColor: iconColor,

    ));


}