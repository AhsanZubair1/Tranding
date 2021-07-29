import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class Playvideo extends StatelessWidget {

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'g1GJlyWjdY8',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: YoutubePlayer(controller: _controller,
          showVideoProgressIndicator: true,
          progressColors: ProgressBarColors(
              bufferedColor: Colors.yellow,
              playedColor: Colors.red,
              backgroundColor: Colors.black54
          ),
          onReady: (){
            _controller.addListener(() {
            });
          },
          liveUIColor:  Colors.amber,

        ),

      ),
    );
  }
}
