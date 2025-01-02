import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget text;
  final void Function()? ontap;

  const CustomButton({super.key, required this.text, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: Colors.orange, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.all(15),
        child: Center(
          child: text,
          // child: loading? CircularProgressIndicator():Text(
          //   text,
          // style: TextStyle(color: Colors.white, fontSize: 25),
          // ),
        ),
      ),
    );
  }
}
