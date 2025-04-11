import 'package:flutter/material.dart';
import 'package:folk_robe/constants.dart';

class MainOptionCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final void Function()? onTap;

  const MainOptionCard({
    super.key,
    required this.title,
    required this.onTap,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: SizedBox(
        width: 190,
        height: 360,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          color: Colors.grey.shade50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath ?? "",
                errorBuilder: (context, object, stacktrace) {
                  return Icon(
                    Icons.error,
                    color: Colors.redAccent,
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
