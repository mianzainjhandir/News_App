import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/news_channel_headlines_model.dart';
import 'package:news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
            onPressed: (){},
            icon: Image.asset('assets/images/category_icon.png',
            height: 30,
              width: 30,
            )
        ),
        centerTitle: true,
        title: Text('News',style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.bold),),
      ),

      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
                future: newsViewModel.fetchNewsChannelHeadlinesApi(),
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
                          return SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height : height * .6,
                                  width: width * .9,

                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context , url) => Container(child: spinKit2,),
                                    errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red,),
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
          )
        ],
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.blue,
  size: 50,
);

