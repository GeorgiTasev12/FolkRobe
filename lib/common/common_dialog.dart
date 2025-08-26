import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folk_robe/common/common_textfield.dart';
import 'package:folk_robe/helpers/screen_size_helper.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class CommonDialog extends StatelessWidget {
  final String dialogTitle;
  final TextEditingController nameTextController;
  final bool isNameNotEmpty;
  final void Function() onSavePressed;
  final void Function() onClosedPressed;
  final void Function() onNameClearPressed;
  final void Function(String name) onNameChanged;
  final TextEditingController? quantityTextController;
  final bool? isQuantityNotEmpty;
  final void Function()? onQuantityClearPressed;
  final void Function(String number)? onNumberChanged;

  const CommonDialog({
    super.key,
    required this.dialogTitle,
    required this.onSavePressed,
    required this.onClosedPressed,
    required this.onNameClearPressed,
    required this.onNameChanged,
    required this.nameTextController,
    this.isNameNotEmpty = false,
    this.onNumberChanged,
    this.quantityTextController,
    this.isQuantityNotEmpty = false,
    this.onQuantityClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeHelper(context);

    return AlertDialog(
      title: Text(
        dialogTitle,
        style: screenSize.isSmall
            ? context.appTheme.textStyles.titleMedium.copyWith(
                fontWeight: FontWeight.w400,
              )
            : null,
      ),
      scrollable: screenSize.isSmall ? true : false,
      backgroundColor: context.appTheme.colors.surfaceContainer,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextfield(
            textController: nameTextController,
            isClearIconVisible: isNameNotEmpty,
            onIconButtonPress: onNameClearPressed,
            onChanged: onNameChanged,
            isSearchTextField: false,
          ),
          SizedBox(height: screenSize.isSmall ? 12 : 8),
          if (onNumberChanged != null &&
              quantityTextController != null &&
              isQuantityNotEmpty != null &&
              onQuantityClearPressed != null)
            Row(
              children: [
                Text(
                  'Брой: ',
                  style: context.appTheme.textStyles.bodyLarge.copyWith(
                    color: context.appTheme.colors.onSurfaceContainer,
                  ),
                ),
                Flexible(
                  child: CommonTextfield(
                    textController:
                        quantityTextController ?? TextEditingController(),
                    keyboardType: TextInputType.number,
                    formatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    isClearIconVisible: isQuantityNotEmpty ?? false,
                    onIconButtonPress: onQuantityClearPressed,
                    onChanged: onNumberChanged,
                  ),
                )
              ],
            )
        ],
      ),
      actions: [
        TextButton(
          onPressed: onClosedPressed,
          child: Text(
            'Затвори',
            style: TextStyle(color: context.appTheme.colors.secondary),
          ),
        ),
        FilledButton(
          onPressed: onSavePressed,
          style: FilledButton.styleFrom(
            backgroundColor: context.appTheme.colors.secondary,
          ),
          child: Text(
            'Запази',
            style: TextStyle(color: context.appTheme.colors.surfaceContainer),
          ),
        ),
      ],
    );
  }
}
