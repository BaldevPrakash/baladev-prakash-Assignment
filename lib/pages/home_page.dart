import 'dart:math';

import 'package:baladev_assignment_persist_ventures_sound_of_meme/pages/audio_player.dart';
import 'package:baladev_assignment_persist_ventures_sound_of_meme/utils/color_utils.dart';
import 'package:baladev_assignment_persist_ventures_sound_of_meme/utils/text_utils/normal_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/song_list_controller.dart';
import '../utils/text_utils/text_form_field.dart';
import 'icon_button_anchor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SongListController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.isRegistered<SongListController>()
        ? Get.find<SongListController>()
        : Get.put(SongListController());
    initCall();
  }

  void initCall() async {
    controller.getSongListApiCall(context);
  }

  @override
  Widget build(BuildContext context) {
    // controller.initiate();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryBlack,
        elevation: 0.5,
        title: const NormalText(
          text: "Sound Of Meme",
          textFontWeight: FontWeight.w600,
          textSize: 24,
          textColor: kWhiteColor,
          // textColor: Colors.white,
        ),
        actions: const [IconButtonAnchor()],
      ),
      body: Stack(
        children: [
          Image.network(
            'https://i.gifer.com/cm8.gif',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: HomerTextInputFieldSmall(
                  filled: true,
                  fillColor: kPrimaryBlack,
                  hintText: 'Type Text To Generate',
                  labelText: 'Type Text To Generate',
                  textController: controller.typeSongController,
                  onSaveCallBack: (text) {},
                  validationCallBack: (text) =>
                      text.isEmpty ? 'Please Enter Text' : null,
                  onChangedCallBack: (_) {},
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AudioPlayerForApp(
                              index: Random()
                                  .nextInt(controller.songList.length))));
                  setState(() {});
                },
                color: kWhiteColor,
                child: const Text(
                  "Generate Your Song",
                  style: TextStyle(color: kPrimaryBlack),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
