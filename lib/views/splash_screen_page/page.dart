import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/views/home_page/page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class SplashScreenPage extends HookWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageOpacity = useState(0.0);
    final textOpacity = useState(0.0);
    final textOffset = useState(const Offset(0, -0.5));

    useEffect(() {
      Future.delayed(
        const Duration(seconds: 1),
        () => imageOpacity.value = 1.0,
      );

      Future.delayed(const Duration(seconds: 2), () {
        textOpacity.value = 1.0;
        textOffset.value = Offset.zero;
      });

      Future.delayed(const Duration(seconds: 6), () {
        locator<NavigationService>().pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      });

      return null;
    }, []);

    return CorePage(
      hasAppBar: false,
      hasAppBarTitle: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: imageOpacity.value,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOutCubic,
            child: Image.asset(
              "assets/front-cover_logo.png",
            ),
          ),
          const SizedBox(height: 15),
          AnimatedSlide(
            offset: textOffset.value,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            child: AnimatedOpacity(
              opacity: textOpacity.value,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Text(
                'FolkRobe',
                style: GoogleFonts.notoSans(
                  color: context.appTheme.colors.primary,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
