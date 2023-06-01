import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
   var name;
   void Function() onTap;
   ButtonStyle? style;

  CustomButton({Key? key, this.name, required this.onTap, this.style}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  // MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: widget.style,
        child: Text("${widget.name}"),
      ),
    );
  }
}
