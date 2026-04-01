import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news_channel_headlines_model.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:news_app/views/categories_screen.dart';

import '../model/category_news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


enum FilterList {bbcNews, aryNews, independentNews, reuters, cnn, alJazeera}


class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedManu;


  final format = DateFormat('MMMM dd, yyyy');

  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {



    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
            onPressed: (){
              Get.to(()=> CategoriesScreen());
            },
            icon: Image.asset('assets/images/category_icon.png',
            height: 30,
              width: 30,
            )
        ),
        centerTitle: true,
        title: Text('News',style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.bold),),

        actions: [
          PopupMenuButton<FilterList>(
            color: Colors.white,
            initialValue: selectedManu,
              icon: Icon(Icons.more_vert),
              onSelected: (FilterList item){

                if(item == FilterList.bbcNews){
                  name = 'bbc-news';
                }
                else if(item == FilterList.cnn){
                  name = 'cnn';
                }else if(item == FilterList.alJazeera){
                  name = 'al-jazeera-english';
                }else if(item == FilterList.aryNews){
                  name = 'ary-news';
                }

                setState(() {
                  selectedManu = item;
                });

              },


              itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>> [
                PopupMenuItem(
                  value: FilterList.bbcNews,
                  child: Text("BBC News"),
                ),
                PopupMenuItem(
                  value: FilterList.cnn,
                  child: Text("CNN News"),
                ),
                PopupMenuItem(
                  value: FilterList.alJazeera,
                  child: Text("AlJazeera"),
                ),
                PopupMenuItem(
                  value: FilterList.aryNews,
                  child: Text("Ary News"),
                )
              ]
          )
        ],

      ),

      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
                future: newsViewModel.fetchNewsChannelHeadlinesApi(name),
                builder: (BuildContext context, AsyncSnapshot<dynamic>snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  }else{
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context , index){
                          DateTime dateTime = DateTime.parse(snapshot.data.articles[index].publishedAt.toString());
                          return SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height : height * .6,
                                  width: width * .9,
                                  padding : EdgeInsets.symmetric(
                                    horizontal: height * .02
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context , url) => Container(child: spinKit2,),
                                      errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red,),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape:  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      
                                      padding: EdgeInsets.all(15),
                                      alignment: Alignment.bottomCenter,
                                      height: height * .22,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width * .7,
                                            child: Text(snapshot.data!.articles![index].title.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w700),),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: width * .7,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(format.format(dateTime),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600),),
                                                Text(snapshot.data!.articles![index].source.name.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(color: Colors.blue,fontSize: 13,fontWeight: FontWeight.w500),),
                                              ],
                                            ),

                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                    );

                  }
                }
            ),
          ),
          Gap(10),
          FutureBuilder<CategoryNewsModel>(
              future: newsViewModel.fetchCategoriesNewsApi('General'),
              builder: (BuildContext context, AsyncSnapshot<dynamic>snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                }else{
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context , index){
                        DateTime dateTime = DateTime.parse(snapshot.data.articles[index].publishedAt.toString());
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                  fit: BoxFit.cover,
                                  height : height * .18,
                                  width : width * .3,
                                  placeholder: (context , url) => Container(child: Center(
                                    child: SpinKitCircle(
                                      size: 50,
                                      color: Colors.blue,
                                    ),
                                  ),),
                                  errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red,),
                                ),
                              ),
                              Expanded(

                                  child: Container(
                                    height: height * .18,
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      children: [
                                        Text(snapshot.data.articles[index].title.toString(),
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),),
                                        Row(
                                          children: [
                                            Text(snapshot.data.articles[index].source.name.toString(),

                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),),
                                            Gap(25),
                                            Text(format.format(dateTime).toString(),

                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        );
                      }
                  );

                }
              }
          ),
        ],
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.blue,
  size: 50,
);

//kkkjuttu
