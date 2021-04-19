import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class mainScreen extends StatefulWidget {
  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
    _controller.setVolume(1.0);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Play This Video"),
      ),
      body:  Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            }else{
              return CircularProgressIndicator();
            }
          },
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_controller.value.isPlaying){
            _controller.pause();
          }else{
            _controller.play();
          }
        },
        child: Icon(_controller.value.isPlaying ? Icons.pause: Icons.play_arrow),
      ),
    );
  }
}