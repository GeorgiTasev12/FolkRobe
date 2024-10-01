import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String title;
  final void Function() onTap;

  const CustomCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap.call(),
      child: SizedBox(
        width: 190,
        height: 360,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
          ),
          color: Colors.grey.shade50,
          child: Center(
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 21,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
