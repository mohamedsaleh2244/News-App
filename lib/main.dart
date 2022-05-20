import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/Providers/country_prov.dart';
import 'package:provider/provider.dart';
import 'Views/Screens/onboarding_screen.dart';
import 'Views/Screens/search.dart';
import 'Views/Screens/splash_screen.dart';
void main() {
  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CountryProv())
      ],
      child: const NewsApp()
      )
  );
}
class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          routes: {
            OnBoardingScreen.id : (context) => const OnBoardingScreen(),
            Search.id : (context) => const Search(),
          },
          home: const Scaffold(
            body: SplashingScreen(),
          ),
        );
      }
    );
  }
}