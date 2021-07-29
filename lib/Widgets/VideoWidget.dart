import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trade_watch/Extras/CustomColors.dart';
import 'package:video_player/video_player.dart';
class VideoWidget extends StatefulWidget {
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
   VideoPlayerController? controller;
  ChewieController ?chewieController;
  bool check=false;
   Future<void> initializeVideoPlayerFuture()async{
     controller= VideoPlayerController.network("https://www.youtube.com/watch?v=9xwazD5SyVg");

     await Future.wait([controller!.initialize()]);
     chewieController=ChewieController(
         videoPlayerController: controller!,
         autoPlay: true,looping: true,
     materialProgressColors: ChewieProgressColors(playedColor: Colors.red,
         handleColor: Colors.cyanAccent,backgroundColor: Colors.yellow,bufferedColor: Colors.greenAccent),
     placeholder: Container(color: Colors.greenAccent,),
       autoInitialize: true,
     );
  }
void initState(){
  super.initState();
  //


 // initializeVideoPlayerFuture = controller.initialize();


}
dispose(){
  controller!.dispose();
  chewieController!.dispose();
  super.dispose();
}
  late double height , width;

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15), ),
                  child: Container(
                    width: double.infinity,
                    height: height * 0.25,
                    child: Image(
                        image: NetworkImage('https://www.bankrate.com/2019/03/22142110/How-to-trade-stocks.jpg'),
                      fit: BoxFit.cover,
                    ),
                  )
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04,vertical: width * 0.03),
                  child: Row(
                    children: [
                      GestureDetector(onTap:(){

                        setState(() {
                          check=true;

                        });
                      },child: check==false?Image(image: AssetImage('assets/images/play.png'),width: 45,):videoplaye()),
                      SizedBox(width: width * 0.03,),
                      Expanded(
                        child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'pm'
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 25,
                right: 25,
                child: Text('10:23',
                  style: TextStyle(
                      fontFamily: 'pm',
                      fontSize: 12,
                      color: Colors.white
                  ),
                ),
              )
            ],
          ),


          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: width * 0.03),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image(
                          image: NetworkImage('https://pyxis.nymag.com/v1/imgs/e48/209/63cbdefa481d2e12651381284a2b590d9a-wandavision.rsquare.w700.jpg'),
                          width: 34,
                          height: 34,
                        ),
                      ),
                      SizedBox(width: width * 0.03,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Alex H',
                              style: TextStyle(
                                color: CColors.yellowd,
                                fontFamily: 'pm',
                                fontSize: 12
                              ),
                            ),
                            SizedBox(height: height * 0.0025,),
                            Row(
                              children: [
                                Text('Today',
                                  style: TextStyle(
                                    color: CColors.graytext,
                                    fontFamily: 'pm',
                                    fontSize: 12
                                  ),
                                ),
                                SizedBox(width: width *0.01,),
                                Icon(Icons.circle,color: CColors.graytext, size: 13,),
                                SizedBox(width: width *0.01,),
                                Text('5 m read',
                                  style: TextStyle(
                                      color: CColors.graytext,
                                      fontFamily: 'pm',
                                      fontSize: 12
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image(
                          image: AssetImage('assets/icons/like.png'),
                        width: 20,
                        height: 20,
                      ),

                      Image(
                        image: AssetImage('assets/icons/share.png'),
                        width: 20,
                        height: 20,
                      ),

                      Image(
                        image: AssetImage('assets/icons/dislike.png'),
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
  //for mute

  Widget videoplaye() {
   return Container(
      height: 300,
      width: 250,
      child:
      FutureBuilder(
        future: initializeVideoPlayerFuture(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return chewieController != null ?
            Chewie(controller: chewieController!) :Container(height: 0,width: 0,);
            check = true;
          } else {
            check=true;
            return const Center(
              child: CircularProgressIndicator(color: Colors.white,),

            );
          }
        },
      ),

    );
  }
}

