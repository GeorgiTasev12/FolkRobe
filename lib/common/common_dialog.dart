import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folk_robe/common/common_textfield.dart';
import 'package:folk_robe/helpers/screen_size_helper.dart';
import 'package:folk_robe/models/options.dart';
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
  final void Function(GenderType?)? onSelectedGender;
  final bool isEnabled;
  final bool isGenderSelected;
  final GenderType? initialSelection;

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
    this.isEnabled = true,
    this.onSelectedGender,
    this.isGenderSelected = true,
    this.initialSelection,
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
            ),
          if (onSelectedGender != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Пол:'),
                const SizedBox(width: 10),
                Theme(
                  data: Theme.of(context).copyWith(
                    dropdownMenuTheme: DropdownMenuThemeData(
                      menuStyle: MenuStyle(
                        backgroundColor: WidgetStateProperty.all(
                          context.appTheme.colors.surfaceContainer,
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                        minimumSize: WidgetStateProperty.all(
                          Size(
                            ScreenSizeHelper(context).width * 0.6,
                            40,
                          ),
                        ),
                        maximumSize: WidgetStateProperty.all(
                          Size(
                            ScreenSizeHelper(context).width * 0.8,
                            double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),
                  child: DropdownMenu(
                    dropdownMenuEntries: (GenderType.values)
                        .where((gender) => gender != GenderType.none)
                        .map((gender) {
                      return DropdownMenuEntry(
                        value: gender,
                        label: gender.genderName,
                      );
                    }).toList(),
                    enabled: isEnabled,
                    initialSelection: initialSelection,
                    onSelected: onSelectedGender,
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      filled: true,
                      fillColor: context.appTheme.colors.surfaceContainer,
                    ),
                  ),
                ),
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
          onPressed: isEnabled && isGenderSelected ? onSavePressed : null,
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
