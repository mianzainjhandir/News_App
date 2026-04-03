
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  final String newImage, newstitle, newsData, author, description, content, source;
   DetailScreen({super.key,
  required this.description,
    required this.author,
    required this.content,
    required this.newImage,
    required this.newsData,
    required this.newstitle,
    required this.source
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    DateTime dateTime = DateTime.parse(widget.newsData);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: height * .45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(40),
              ),
              child: CachedNetworkImage(
                  imageUrl: widget.newImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: CircularProgressIndicator(),)
              ),
            ),
          ),
          Container(
            height: height * .6,
            margin: EdgeInsets.only(
              top: height * .4,
            ),
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(40),
              ),
            ),
            child: ListView(
              children: [
                Text(widget.newstitle,style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),),
                SizedBox(height: height * .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(widget.source,style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),),
                    ),
                    Text(format.format(dateTime),style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),),

                  ],
                ),
                SizedBox(height: height * .03,),
                Text(widget.description,style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),),
              ],
            ),
          )

        ],
      ),
    );
  }

}