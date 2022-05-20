import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Contraller/api_helper.dart';
import 'package:news_app/Models/article.dart';

import 'new_screen.dart';
class Search extends StatefulWidget {
  static String id = "Search";
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Article> listSearch =[];
  ApiHelper db = ApiHelper();
  getNews(String search) async{
    db.getNewsBySearch(search).then((e){
      setState(() {
        listSearch = e;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          preferredSize: Size(1.sw,70.h),
          child: Container(
            margin: const EdgeInsets.only(bottom: 5),
            width: .8.sw,
            height: 60,
            child:TextFormField(
              onChanged: (value){
                setState(() {
                  listSearch.clear();
                });
                getNews(value);
              },
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: GoogleFonts.titilliumWeb(
                  fontSize: 16.sp
                ),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                )
                ),
              )
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: listSearch.length,
          itemBuilder: (context , index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewsScreen(listSearch[index])));
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
                        listSearch[index].urlToImage == null ? Container() :
                        Flexible(
                          flex : 4,
                          child: SizedBox(
                            height: .2.sh,
                            width: .4.sw,
                            child: Image.network(
                              listSearch[index].urlToImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Flexible(
                            flex : 6,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    listSearch[index].title!,
                                    style: GoogleFonts.titilliumWeb(
                                        fontSize: 13.sp,
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
                                      "Published At ${listSearch[index].publishedAt!.substring(0,10)}",
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
                    )
                ),

              ),
            );
          }
      ),
    );
  }
}
