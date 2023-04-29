import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zomo/Shared/styles/colores.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.lightBlue,
  Color fontcolor = Colors.white,
  required VoidCallback function,
  required String text,
  bool isupper = true,
  double radius = 0.0,
  double? height,
  double Fsize = 18,
}) =>
    Container(
      height:height ,
      width: width,
      child: MaterialButton(
          onPressed: function,
          child: Text(
            (isupper ? text.toUpperCase() : text),
            style: TextStyle(color: fontcolor, fontSize: Fsize),
          )),
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(radius)),
    );

Widget defaulttextFaild({
  required TextEditingController controller,
  required TextInputType keyboardtype,
  ValueChanged? onsubmit=null,
  ValueChanged? onChange=null,
  FormFieldValidator? validate=null,
  VoidCallback? suffixpressed,
  required String lable ,
  IconData? prefixicon,
  IconData? suffixicon,
  double fontsize=18.0,
  double height=45,
  double weight=double.infinity,
  bool ispass=true,
  Color  piconcolor =  const Color(0xFF212121),
  Color fillcolor =  const Color(0xFFfafafa),
  double radius=5.0,
  int? maxlenth,
})=> Container(
  height:height ,
  width: weight,
alignment: Alignment.center,

  decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius),
    color: fillcolor),
  child:   TextFormField(

      controller: controller,
      decoration: InputDecoration(
          hintText: lable,
          hintStyle: TextStyle(fontSize: 15,color: iconColor,fontWeight: FontWeight.w400),
          prefixIcon: prefixicon!=null?Icon(prefixicon,color: iconColor,):null,
          suffixIcon: suffixicon!=null?IconButton(onPressed: (){suffixpressed!();}, icon: Icon(suffixicon),color: iconColor,):null,
          // border:const OutlineInputBorder(),
          border: InputBorder.none,
          prefix:SizedBox(width: 15,)
      ),
      keyboardType:keyboardtype,
      obscureText: ispass,
      onFieldSubmitted: onsubmit,
      onChanged:onChange,
      validator:  validate,
      style: TextStyle(fontSize:fontsize,
fontWeight: FontWeight.w500
      ),
maxLength: maxlenth,
    cursorColor: Colors.white,
  ),
);
