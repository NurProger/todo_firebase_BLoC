import 'package:flutter/material.dart';


class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    required this.name,
    this.width = double.infinity,
    required this.height
  });
  final width;
  final double height;
  final String name;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 234, 46, 98),
            borderRadius: BorderRadius.circular(8)
        ),
        child: Center(child: Text(name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)),
      ),
    );
  }
}
