// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingsCard extends StatelessWidget {
  IconData icon;
  String label;
  double maxWidth;
  double maxHeight;
  Color color;
  VoidCallback onTap;
  SettingsCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.maxWidth,
    required this.maxHeight,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blue,
      height: maxHeight * 0.07,
      width: double.infinity,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Icon(
            weight: 20,
            icon,
            color: color,
            size: maxHeight * 0.04,
          ),
          title: Text(
            label,
            style: TextStyle(
                color: color,
                fontFamily: "Poppins-Bold",
                fontSize: maxHeight * 0.03),
          ),
        ),
      ),
    );
  }
}
