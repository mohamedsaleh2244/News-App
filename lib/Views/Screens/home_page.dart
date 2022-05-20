import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Contraller/api_helper.dart';
import 'package:news_app/Models/article.dart';
import 'package:news_app/Models/category.dart';
import 'package:news_app/Providers/country_prov.dart';
import 'package:news_app/Views/Screens/search.dart';
import 'package:provider/provider.dart';
import 'category.dart';
import 'new_screen.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  List<CategoryModel>? list = [CategoryModel(name : "Business", imgUrl :"https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=815&q=80"), CategoryModel(name : "Sports", imgUrl :"https://images.unsplash.com/photo-1512588617594-f80495876bff?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDV8fHNwb3J0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60")];
  List<Article>? model = [];
  GlobalKey<ScaffoldState> key = GlobalKey();
  bool isConnected = false;
  StreamSubscription? sub;
  Connectivity connect = Connectivity();
  ApiHelper db = ApiHelper();
  getNewsFromApiHelper() async{
    model!.clear();
    db.getNews(context).then((e){
      setState(() {
        model = e;
      });
    });
  }
  @override
  initState(){
    super.initState();
    getNewsFromApiHelper();
    sub = connect.onConnectivityChanged.listen((event) {
      if(event == ConnectivityResult.wifi || event == ConnectivityResult.mobile){
        setState(() {
          isConnected = true ;
        });
      }
    });
  }
  @override
  dispose(){
    super.dispose();
    sub!.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Search.id);
        },
        child: const Icon(
          Icons.search
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
                 "SmartCode  ",
               style: GoogleFonts.titilliumWeb(
                 fontSize: 25.sp,
                 fontWeight: FontWeight.bold,
                 color: Colors.deepPurple
               ),
             ),
             Text(
               " News",
               style: GoogleFonts.titilliumWeb(
                   fontSize: 25.sp,
                   fontWeight: FontWeight.bold,
                 color: Colors.grey
               ),
             ),

          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size(1.sw,50.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CountryCodePicker(
                onChanged: (value){
                  Provider.of<CountryProv>(context,listen: false).changeCountry(value.code!.toString());
                  setState(() {
                    getNewsFromApiHelper();
                  });
                },
                initialSelection: Provider.of<CountryProv>(context,listen: false).countryId ,
                showOnlyCountryWhenClosed: true,
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          isConnected ?
          SizedBox(
            height: .2.sh,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: list!.length,
                itemBuilder: (context , index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(list![index])
                        )
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: .6.sw,
                        height: 180.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(list![index].imgUrl!),
                            fit: BoxFit.cover
                          )
                        ),
                        child: Center(
                          child: Text(
                            list![index].name!,
                            style: GoogleFonts.titilliumWeb(
                            fontSize: 20.sp,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w800,
                              color: Colors.white
                            )
                          )
                        ),
                      ),
                    ),
                  );
                }
            ),
          ) :
          Container(height: .2.sh),
          isConnected ?
          Expanded(
            child: ListView.builder(
              itemCount:model!.length,
              itemBuilder: (context , index){
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewsScreen(model![index])));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: .2.sh,
                      width: 1.sw,
                      decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                          color: Colors.grey.shade300
                        )
                      ),
                      child: Row(
                        children: [
                          model![index].urlToImage == null ? Container() :
                          Flexible(
                            flex : 4,
                            child: SizedBox(
                              height: .2.sh,
                              width: .4.sw,
                              child: Image.network(
                                model![index].urlToImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Flexible(
                            flex : 7,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      model![index].title!,
                                      style: GoogleFonts.titilliumWeb(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Flexible(
                                    flex : 1,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Published At ${model![index].publishedAt!.substring(0,10)}",
                                        style: GoogleFonts.abel(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            ),
          )
          :
          Column(
            children: [
              const Icon(Icons.wifi_off,size: 50,color: Colors.grey),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                    "Check your Internet Connection",
                  style: GoogleFonts.abel(
                    fontSize : 19.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}