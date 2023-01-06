import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioExample extends StatefulWidget {
  String audioUrl;
  AudioExample({Key? key, required this.audioUrl}) : super(key: key);

  @override
  State<AudioExample> createState() => _AudioExampleState();
}

class _AudioExampleState extends State<AudioExample> {
  Duration _duration = Duration();
  Duration _position = Duration();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    playSong(widget.audioUrl);
  }

  playSong(String uri) {
    // print(uri);
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));
      _audioPlayer.play();
      _isPlaying = true;
    } on Exception {
      log('Error parsing song');
    }
    _audioPlayer.durationStream.listen((newDuration) {
      setState(() {
        _duration = newDuration!;
      });
    });
    _audioPlayer.positionStream.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: (){
                  setState(() {
                    if(_isPlaying){
                      _audioPlayer.pause();
                    }else{
                      _audioPlayer.play();
                    }
                    _isPlaying = !_isPlaying;
                  });
                },
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 40.0 ,
                ),
              ),
              Text(_position.toString().split('.')[0]),
              Text(' / '),
              Text(_duration.toString().split('.')[0]),
              Expanded(
                child: Slider(
                    min: Duration(microseconds: 0).inSeconds.toDouble(),
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (value){
                      setState(() {
                        changeToSecond(value.toInt());
                        value = value;
                      });
                    }
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void changeToSecond(int seconds) {
    Duration duration = Duration(seconds: seconds);
    _audioPlayer.seek(duration);
  }


  }