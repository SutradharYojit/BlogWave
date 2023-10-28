import 'package:blogwave_frontend/resources/resources.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/model.dart';
import '../../services/services.dart';

final projectList = StateNotifierProvider<ProjectData, List<ProjectModel>>((ref) => ProjectData());

class ProjectData extends StateNotifier<List<ProjectModel>> {
  ProjectData() : super([]);

// Define a function to fetch user projects.
  Future getUserProject() async {
    // Retrieve user information from UserPreferences.
    await UserPreferences().getUserInfo();
    // Clear the existing project list in the 'state'.
    state.clear();
    // Make an API request to get the user's projects using the user's ID.
    final data = await ApiServices().getApi(
      api: "${APIConstants.baseUrl}Project/userProjects", // API endpoint for user projects.
      body: {
        ApiRequestBody.apiId: UserPreferences.userId, // Pass the user's ID as a request parameter.
      },
    );
    // Iterate over the data obtained from the API response and convert it into ProjectModel objects.
    for (Map<String, dynamic> i in data) {
      state.add(ProjectModel.fromJson(i)); // Create ProjectModel objects and add them to the 'state'.
    }
    // Update the 'state' with the new project list using the spread operator.
    state = [...state];
    return state; // Return the updated project list.
  }

}
