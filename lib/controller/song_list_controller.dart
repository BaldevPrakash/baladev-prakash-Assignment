import 'package:baladev_assignment_persist_ventures_sound_of_meme/model/songs_list_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../helper/network_helper.dart';
import '../utils/toast_utils/error_toast.dart';

class SongListController extends GetxController {
  ApiService apiService = ApiService();

  final RxBool _isBusy = RxBool(false);
  bool get isBusy => _isBusy.value;

  setBusy(bool value) {
    _isBusy.value = value;
  }

  final RxList<Data> _getSongList = RxList([]);
  List<Data> get songList => _getSongList;

  setSongList(List<Data> value) {
    _getSongList.clear();
    _getSongList.addAll(value);
  }

  clearSongList() {
    _getSongList.clear();
  }

  TextEditingController typeSongController = TextEditingController();

  initiate() {
    typeSongController = TextEditingController();
  }

  /// Song List Api Call...
  Future<void> getSongListApiCall(BuildContext context) async {
    bool isConnectedToInternet = await checkIsConnectedToInternet();
    if (isConnectedToInternet) {
      var apiUrl = "http://10.0.2.2:1337/api/song-lists";
      try {
        setBusy(true);
        var value = await apiService.getWithoutToken(
            apiUrl, Get.overlayContext ?? context);

        if (value.statusCode == 200 && value.response != null) {
          SongsListModel songsListModel =
              SongsListModel.fromJson(value.response);

          setSongList(songsListModel.data ?? []);

          setBusy(false);
        } else {
          setBusy(false);
          clearSongList();
        }
      } catch (e) {
        setBusy(false);
        clearSongList();
        if (e.toString().contains('Unauthorized')) {
          getSongListApiCall(Get.overlayContext ?? context);
        }
      }
    } else {
      errorToast("pleaseCheckYourInternetConnectivityAndTryAgain",
          Get.overlayContext ?? context);
      setBusy(false);
      clearSongList();
    }
  }

  Future<bool> checkIsConnectedToInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return false;
    }
  }
}
