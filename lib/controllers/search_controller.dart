import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/Constants/constants.dart';
import 'package:tiktok_tutorial/models/user.dart';

class SearchController extends GetxController {
  final Rx<List<AppUserModel>> _searchedUsers = Rx<List<AppUserModel>>([]);

  List<AppUserModel> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {
    _searchedUsers.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<AppUserModel> retVal = [];
      for (var elem in query.docs) {
        retVal.add(AppUserModel.fromSnap(elem));
      }
      return retVal;
    }));
  }
}
