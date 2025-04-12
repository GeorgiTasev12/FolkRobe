import 'package:flutter/material.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class CostumeItem extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final void Function()? onDelete;

  const CostumeItem({
    super.key,
    required this.title,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: context.appTheme.colors.surfaceContainer,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: context.appTheme.colors.error,
                  shape: BoxShape.circle
                ),
                child: IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete,
                    color: context.appTheme.colors.surfaceContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
