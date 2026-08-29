import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'presentation/theme/neon_theme.dart';
import 'presentation/screens/splash_screen.dart';
import 'core/i18n/localization_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MiMundoApp());
}

class MiMundoApp extends StatefulWidget {
  const MiMundoApp({super.key});

  @override
  State<MiMundoApp> createState() => _MiMundoAppState();
}

class _MiMundoAppState extends State<MiMundoApp> {
  final LocalizationService _loc = LocalizationService();

  @override
  void initState() {
    super.initState();
    _loc.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My World',
      debugShowCheckedModeBanner: false,
      theme: NeonTheme.themeData,
      home: Directionality(
        textDirection: _loc.isRTL ? TextDirection.rtl : TextDirection.ltr,
        child: SplashScreen(loc: _loc),
      ),
    );
  }
}
