import 'dart:developer';
import 'package:blogwave_frontend/resources/resources.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model.dart';
import '../../services/services.dart';

final userDataList = StateNotifierProvider<UserData, List<UserDataModel>>((ref) => UserData());

class UserData extends StateNotifier<List<UserDataModel>> {
  UserData() : super([]);
  String? image;

// Method to fetch user data from the API
  Future<void> getUser() async {
    await UserPreferences().getUserInfo(); // Retrieve user information
    log(UserPreferences.userId.toString()); // Log the user's ID
    state.clear(); // Clear the current state
    final data = await ApiServices().getApi(
      api: "${APIConstants.baseUrl}Portfolio/getUser", // API endpoint to fetch user data
      body: {
        ApiRequestBody.apiId: UserPreferences.userId, // Include the user's ID in the request body
      },
    );
    state.add(UserDataModel.fromJson(data)); // Add the retrieved user data to the state
    state = [...state]; // Update the state with the new data
    image = state.first.userData!.profileUrl!; // Set the 'image' variable to the user's profile image URL
  }

// Method to update user data
  void update({required Map<String, dynamic> data}) async {
    // Update the user data in the state with the provided data
    state.first.userData!.userName = data["userName"];
    state.first.userData!.email = data["email"];
    state.first.userData!.bio = data["bio"];
    state.first.userData!.profileUrl = data["profileUrl"];
    image = state.first.userData!.profileUrl!; // Update the 'image' variable with the new profile image URL

    await ApiServices().postApi(
      api: "${APIConstants.baseUrl}Portfolio/updateProfile", // API endpoint to update the user's profile
      body: data, // Include the updated data in the request body
    );

    state = [...state]; // Update the state with the new user data
  }

}
