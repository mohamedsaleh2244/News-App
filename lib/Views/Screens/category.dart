import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Contraller/api_helper.dart';
import 'package:news_app/Models/article.dart';
import 'package:news_app/Models/category.dart';
import 'package:news_app/Views/Screens/new_screen.dart';
class CategoryScreen extends StatefulWidget {
  final CategoryModel category ;
  static String id = "Category";
  const CategoryScreen(this.category);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Article>? listCategory = [];
  ApiHelper db = ApiHelper();
  getNewsFromApiHelper() async{
    listCategory!.clear();
    db.getNewsByCategory(context, widget.category.name!).then((e){
      setState(() {
        listCategory = e;
      });
    });
  }
  @override
  initState(){
    super.initState();
    getNewsFromApiHelper();
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
          preferredSize: Size(1.sw,50.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.category.name! ,
                style: GoogleFonts.titilliumWeb(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                ),
              )
            ],
          ),
        ),
      ),
      body: SizedBox(
        width: 1.sw,
        height: .8.sh,
        child: ListView.builder(
            itemCount: listCategory!.length,
            itemBuilder: (context , index){
              return InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsScreen(listCategory![index] )
                      )
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    height: listCategory![index].urlToImage == null? .17.sh : .37.sh,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.shade300
                        ),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        listCategory![index].urlToImage == null?
                        Container():
                        Container(
                          padding: const EdgeInsets.all(5),
                          height: .2.sh,
                          width: 1.sw,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.network(
                            getImageUrl(index)!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            listCategory![index].title!,
                            style: GoogleFonts.titilliumWeb(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Published At ${listCategory![index].publishedAt}",
                              style: GoogleFonts.abel(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
  String? getImageUrl(index){
    if(listCategory![index].urlToImage == null)  {
      return widget.category.imgUrl;
    }
    else{
      return listCategory![index].urlToImage;
    }

  }
}
