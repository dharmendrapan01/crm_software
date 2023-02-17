import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlay extends StatefulWidget {
  final videoUrl;
  const VideoPlay({Key? key, this.videoUrl}) : super(key: key);

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late VideoPlayerController _controller;
  double _aspectRatio = 16 / 9;

  void _playVideo() {
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() => setState(() {}))..setLooping(true)..initialize().then((value) => _controller.play());
  }

  String _videoDuration(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minuts = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if(duration.inHours > 0) hours,
      minuts,
      seconds,
    ].join(':');
  }

  @override
  void initState() {
    _playVideo();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: Colors.transparent,
      ),
      height: 300,
      child: _controller.value.isInitialized ? Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 8, left: 8, right: 8),
            height: 244,
            child: VideoPlayer(_controller),
          ),

          // SizedBox(height: 12,),

          Row(
            children: [
              IconButton(
                onPressed: (){
                  _controller.value.isPlaying ? _controller.pause() : _controller.play();
                },
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.black,
                  size: 35,
                ),
              ),

              ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, VideoPlayerValue value, child) {
                    return Text(
                        _videoDuration(value.position),
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    );
                  }
              ),
              Text(' / ', style: TextStyle(fontSize: 20, color: Colors.black),),
              Text(_videoDuration(_controller.value.duration), style: TextStyle(fontSize: 20, color: Colors.black),),

              Expanded(
                child: SizedBox(
                  height: 20,
                  child: VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      padding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 12,
                    ),
                  ),
                ),
              ),


            ],
          ),
        ],
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}
