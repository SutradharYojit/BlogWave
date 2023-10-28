import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/model.dart';
import '../../services/api_constants.dart';
import '../../services/api_services.dart';

// Riverpod state management
final blogDataList = StateNotifierProvider<BlogData, List<BlogDataModel>>((ref) => BlogData());

// used to get the list of blog data
class BlogData extends StateNotifier<List<BlogDataModel>> {
  BlogData() : super([]);

  Future getBlogs() async {
    state.clear();
    final data = await ApiServices().getApi(
      api: "${APIConstants.baseUrl}blog/getBlogs",
      body: {},
    );
    for (Map<String, dynamic> i in data) {
      state.add(BlogDataModel.fromJson(i));
    }
    log(state.length.toString());
    state = [...state];
    return state;
  }

  // function to remove the blog data from the list
  Future<void> blogDelete(String blogId, int index) async {
    state.removeAt(index);
    // APi top delete the blog
    ApiServices().deleteApi(
      api: "${APIConstants.baseUrl}blog/deleteBlog",
      body: {"id": blogId},
    );
    state = [...state];
  }
}
