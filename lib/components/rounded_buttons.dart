import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final Color color;
  final Function onPressed;

  RoundedButton(
      {@required this.label, @required this.color, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          disabledColor: Colors.grey,
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
