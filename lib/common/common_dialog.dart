import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/bloc/costume_bloc.dart';
import 'package:folk_robe/common/common_textfield.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class CommonDialog extends StatelessWidget {
  final void Function() onPressed;

  const CommonDialog({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CostumeBloc>();

    return BlocBuilder<CostumeBloc, CostumeState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          previous.nameTextController != current.nameTextController ||
          previous.costumeList != current.costumeList,
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Моля, въведете реквизит.'),
          backgroundColor: context.appTheme.colors.surfaceContainer,
          content: BlocProvider.value(
            value: bloc,
            child: BlocBuilder<CostumeBloc, CostumeState>(
              buildWhen: (previous, current) =>
                  bloc.buildWhen(previous, current),
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextfield(
                      textController:
                          state.nameTextController ?? TextEditingController(),
                      isClearIconVisible: state.isNameNotEmpty,
                      onIconButtonPress: () => bloc.add(
                        OnNameClearEvent(
                          textController: state.nameTextController ??
                              TextEditingController(),
                        ),
                      ),
                      onChanged: (text) =>
                          bloc.add(OnNameChangedEvent(text: text)),
                    ),
                    const SizedBox(height: 12),
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
                            textController: state.quantityTextController ??
                                TextEditingController(),
                            keyboardType: TextInputType.number,
                            formatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            isClearIconVisible: state.isQuantityNotEmpty,
                            onIconButtonPress: () => bloc.add(
                              OnQuantityClearEvent(
                                textController: state.quantityTextController ??
                                    TextEditingController(),
                              ),
                            ),
                            onChanged: (number) => context
                                .read<CostumeBloc>()
                                .add(OnQuantityChangedEvent(number: number)),
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                bloc.add(OnCloseDialogEvent());
                locator<NavigationService>().pop();
              },
              child: Text(
                'Затвори',
                style: TextStyle(color: context.appTheme.colors.secondary),
              ),
            ),
            FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: context.appTheme.colors.secondary,
              ),
              child: Text(
                'Запази',
                style:
                    TextStyle(color: context.appTheme.colors.surfaceContainer),
              ),
            ),
          ],
        );
      },
    );
  }
}
