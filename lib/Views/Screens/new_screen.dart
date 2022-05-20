import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';
class NewsScreen extends StatelessWidget {
  late Article model ;
  NewsScreen(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl: model.url,
        )
      ),
    );
  }
}
