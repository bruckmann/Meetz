import 'package:flutter/cupertino.dart';
import 'package:meetz/pages/home/home_state.dart';
import 'package:meetz/pages/home/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController {
  final stateNotifier = ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  UserModel? user;

  var url = Uri.parse("http://3.87.255.237/user");

  void getUser() async {
    state = HomeState.loading;
    //user = await http.get("${url}/", );
    state = HomeState.success;
  }
}
