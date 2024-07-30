import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:baladev_assignment_persist_ventures_sound_of_meme/utils/color_utils.dart';
import 'package:baladev_assignment_persist_ventures_sound_of_meme/utils/text_utils/normal_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/song_list_controller.dart';
import '../services/stripe_service.dart';

class AudioPlayerForApp extends StatefulWidget {
  const AudioPlayerForApp({super.key, required this.index});
  final int index;

  @override
  State<AudioPlayerForApp> createState() => _AudioPlayerForAppState();
}

class _AudioPlayerForAppState extends State<AudioPlayerForApp> {
  late SongListController controller;
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.isRegistered<SongListController>()
        ? Get.find<SongListController>()
        : Get.put(SongListController());

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = (state == PlayerState.playing);
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: kWhiteColor, // Change this color to your desired color
        ),
        backgroundColor: kPrimaryBlack,
        title: NormalText(
          text: 'Music',
          textColor: kPrimaryWhite,
          textSize: 24,
        ),
      ),
      body: Container(
        color: Colors.black54,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                (controller.songList[widget.index].attributes?.imageUrl ??
                    '') /*'https://content.imageresizer.com/images/memes/Patrick-Bateman-listening-to-music-meme-7.jpg'*/,
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            const Text(
              'Sound Of Meme',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryWhite),
            ),
/*            SizedBox(
              height: 10,
            ),
            const Text(
              'Sarah',
              style: TextStyle(fontSize: 20, color: kPrimaryWhite),
            ),*/
            Slider(
              activeColor: kPrimaryWhite,
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
                await audioPlayer.resume();
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NormalText(
                    text: formatTime(position),
                    textColor: kWhiteColor,
                  ),
                  NormalText(
                    text: formatTime(duration - position),
                    textColor: kWhiteColor,
                  ),
                ],
              ),
            ),
            CircleAvatar(
              backgroundColor: kPrimaryWhite,
              radius: 35,
              child: IconButton(
                color: kPrimaryBlack,
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 50,
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    /*String url =
                        ' https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3';
                    await audioPlayer.play(url as Source);*/

                    await audioPlayer.resume();
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryBlack,
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                StripeService.instance.makePayment();
              },
              child: const NormalText(
                text: 'Purchase The Song',
                textColor: kWhiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future setAudio() async {
    // audioPlayer.setReleaseMode(ReleaseMode.loop);

    String url = (controller.songList[widget.index].attributes?.songUrl ??
        '') /*"https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3"*/;
    audioPlayer.setSourceUrl(url);
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
