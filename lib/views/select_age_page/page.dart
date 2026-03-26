import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:folk_robe/common/common_main_options_card.dart';
import 'package:folk_robe/helpers/screen_size_helper.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/dancers_page/page.dart';
import 'package:folk_robe/views/gender_page/page.dart';

class SelectAgePage extends StatelessWidget {
  final PageSource pageSource;

  const SelectAgePage({
    super.key,
    required this.pageSource,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (kDebugMode) {
      print("Screen sizes\nWidth: ${size.width}\nHeight: ${size.height}");
    }

    return CorePage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: CommonOptionCard(
                  title: AgeGroup.adult.agesName,
                  icon: Icon(
                    Icons.person_3_outlined,
                    size: ScreenSizeHelper(context).isSmall ? 40 : 44,
                    color: context.appTheme.colors.primary,
                  ),
                  onTap: () {
                    locator<NavigationService>().push(
                      MaterialPageRoute(
                        builder: (context) => pageSource == PageSource.costumes
                            ? GenderPage(age: AgeGroup.adult)
                            : DancersPage(ageGroup: AgeGroup.adult),
                      ),
                    );
                  },
                ),
              ),
              Flexible(
                child: CommonOptionCard(
                  title: AgeGroup.child.agesName,
                  icon: Icon(
                    Icons.child_care_outlined,
                    size: ScreenSizeHelper(context).isSmall ? 38 : 44,
                    color: context.appTheme.colors.primary,
                  ),
                  onTap: () {
                    locator<NavigationService>().push(
                      MaterialPageRoute(
                        builder: (context) => pageSource == PageSource.costumes
                            ? GenderPage(age: AgeGroup.child)
                            : DancersPage(ageGroup: AgeGroup.child),
                      ),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
