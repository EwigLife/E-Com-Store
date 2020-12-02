import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomeStepper extends StatefulWidget {
  CustomeStepper({
    @required this.lowerLimit,
    @required this.upperLimit,
    @required this.iconSize,
    @required this.onChanged,
    @required this.stepValue,
    @required this.value,
  });

  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  int value;
  final ValueChanged<dynamic> onChanged;

  @override
  _CustomeStepperState createState() => _CustomeStepperState();
}

class _CustomeStepperState extends State<CustomeStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 15,
              spreadRadius: 10,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                widget.value = widget.value == widget.lowerLimit
                    ? widget.lowerLimit
                    : widget.value -= widget.stepValue;
                this.widget.onChanged(widget.value);
              });
            },
          ),
          Container(
            width: this.widget.iconSize,
            child: Text(
              '${widget.value}',
              style: TextStyle(
                fontSize: widget.iconSize * 0.8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                widget.value = widget.value == widget.upperLimit
                    ? widget.upperLimit
                    : widget.value += widget.stepValue;
                this.widget.onChanged(widget.value);
              });
            },
          ),
        ],
      ),
    );
  }
}
