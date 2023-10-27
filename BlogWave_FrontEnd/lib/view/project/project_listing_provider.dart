import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/model.dart';
import '../../services/services.dart';

final projectList = StateNotifierProvider<ProjectData, List<ProjectModel>>((ref) => ProjectData());

class ProjectData extends StateNotifier<List<ProjectModel>> {
  ProjectData() : super([]);


  Future getUserProject() async {
    await UserPreferences().getUserInfo();
    log(UserPreferences.userId.toString());
    state.clear();
    final data = await ApiServices().getApi(
      api: "${APIConstants.baseUrl}Project/userProjects",
      body: {
        // "id": UserPreferences.userId,
        "id":UserPreferences.userId,
      },
    );
    for(Map<String,dynamic> i in data) {
      state.add(ProjectModel.fromJson(i));
    }
    log(state.length.toString());
    state = [...state];
    return state;
  }




}
