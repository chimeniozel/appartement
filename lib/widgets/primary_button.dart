import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../theme/color.dart';

class PrimaryButton extends StatelessWidget {
  // final String text;
  final bool? load;
  final double width;
  final double height;
  final Widget? widget;
  final void Function() onPressed;
  PrimaryButton({ required this.onPressed, required this.width, required this.height, this.load, this.widget});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
             BoxShadow(
              color: Color.fromRGBO(169, 176, 185, 0.42),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: widget
        ),
      ),
    );
  }
}
