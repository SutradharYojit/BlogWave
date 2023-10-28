import 'package:blogwave_frontend/view/project/project_listing_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/model.dart';
import '../../resources/resources.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key, required this.editProject});

  final EditProject editProject;

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  final TextEditingController _techCtrl = TextEditingController();
  final TextEditingController _githubUrlCtrl = TextEditingController();
// Create a ValueNotifier to hold a list (it's recommended to specify the type).
  final ValueNotifier<List> _techList = ValueNotifier([]);

// Create a GlobalKey for the form (used to identify and control the form).
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Call the `updateProject` method when the widget is initialized.
    updateProject();
  }

  void updateProject() {
    // If editing a project in the ProjectDetailsScreen:
    if (widget.editProject.projectDetailsScreen) {
      // Populate form fields with existing project data.
      _titleCtrl.text = widget.editProject.projectData?.title ?? "";
      _descriptionCtrl.text = widget.editProject.projectData?.description ?? "";
      _githubUrlCtrl.text = widget.editProject.projectData?.projectUrl ?? "";
      // Populate the _techList with existing technologies.
      _techList.value.addAll(widget.editProject.projectData?.technologies ?? []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(); // To unfocus on the text filled
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.editProject.projectDetailsScreen ? StringManager.updateProjectTxt : StringManager.addProjectTxt,
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: Form(
                key:_formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15.r),
                      child: PrimaryTextFilled(
                        controller: _titleCtrl,
                        textCapitalization: TextCapitalization.sentences,
                        hintText: StringManager.titleHintTxt,
                        labelText: StringManager.titleLabelTxt,
                        prefixIcon: const Icon(
                          Icons.title,
                          color: ColorManager.tealColor,
                        ),
                        keyboardType: TextInputType.text,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return StringManager.titleHintTxt;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.r),
                      child: PrimaryTextFilled(
                        controller: _descriptionCtrl,
                        hintText: StringManager.descHintTxt,
                        labelText: StringManager.descLabelTxt,
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 6,
                        prefixIcon: const Icon(
                          Icons.description,
                          color: ColorManager.tealColor,
                        ),
                        keyboardType: TextInputType.text,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return StringManager.descHintTxt;
                          }
                          return null;
                        },
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: _techList,
                      builder: (context, data, child) {
                        return Padding(
                          padding: EdgeInsets.only(top: 10.r),
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2.1,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 1,
                            ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(data[index]),
                                    InkWell(
                                      onTap: () {
                                        _techList.value.removeAt(index);
                                        setState(() {});
                                      },
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: ColorManager.grey300Color,
                                        child: Icon(
                                          Icons.close,
                                          size: 13.h,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                            },
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.r),
                      child: PrimaryTextFilled(
                        controller: _techCtrl,
                        textCapitalization: TextCapitalization.sentences,
                        hintText: StringManager.techHintTxt,
                        labelText: StringManager.techLabelTxt,

                        onFieldSubmitted: (p0) {
                          if(_techCtrl.text.trim()!=""){
                            _techList.value.insert(0, _techCtrl.text.trim());
                            _techCtrl.clear();
                          }

                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            if(_techCtrl.text.trim()!=""){
                              _techList.value.insert(0, _techCtrl.text.trim());
                              _techCtrl.clear();
                              setState(() {});
                            }

                          },
                          icon: const CircleAvatar(
                            backgroundColor: ColorManager.gradientLightTealColor,
                            radius: 18,
                            child: Icon(Icons.add),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        prefixIcon: const Icon(
                          Icons.build,
                          color: ColorManager.tealColor,
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.r),
                      child: PrimaryTextFilled(
                        controller: _githubUrlCtrl,
                        hintText: StringManager.urlHintTxt,
                        labelText: StringManager.urlLabelTxt,
                        prefixIcon: const Icon(
                          Icons.link_rounded,
                          color: ColorManager.tealColor,
                        ),
                        keyboardType: TextInputType.text,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return StringManager.urlHintTxt;
                          }
                          // Check if the input string doesn't match a valid URL pattern.
                          if (!RegExp(
                              r"^(http(s):\/\/.)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$")
                              .hasMatch(p0)) {
                            // If the input is not a valid URL, return an error message.
                            return 'Enter Correct Url';
                          }

                          return null;
                        },
                      ),
                    ),
                    Consumer(
                     builder: (context, ref, child) {
                       return PrimaryButton(
                         title: widget.editProject.projectDetailsScreen
                             ? StringManager.updateProjectTxt
                             : StringManager.addProjectTxt,
                         onTap: () async {
                           if (_formKey.currentState!.validate()) {
                             loading(context); // Display a loading indicator.

                             if (widget.editProject.projectDetailsScreen) {
                               // If editing a project, make an API request to update the project.
                               ApiServices().postApi(
                                 api: "${APIConstants.baseUrl}Project/updateProject", // API endpoint for updating a project.
                                 body: {
                                   ApiRequestBody.apiTitle: _titleCtrl.text.trim(),
                                   ApiRequestBody.apiDescription: _descriptionCtrl.text.trim(),
                                   ApiRequestBody.apiTechnologies: _techList.value,
                                   ApiRequestBody.apiProjectUrl: _githubUrlCtrl.text.trim(),
                                   ApiRequestBody.apiId: widget.editProject.projectData!.id, // Pass the project's ID for updating.
                                 },
                               ).then(
                                     (value) async {
                                   if (value.statusCode == ServerStatusCodes.addSuccess) {
                                     // Show a success message and refresh the project list.
                                     WarningBar.snackMessage(context, message: StringManager.updateProjectSuccessTxt, color: ColorManager.greenColor);
                                     await ref.watch(projectList.notifier).getUserProject();
                                     Navigator.pop(context); // Close the loading screen.
                                     Navigator.pop(context); // Close the Project Details screen.
                                     Navigator.pop(context); // Close the Project Listing screen.
                                   } else {
                                     // Show an error message if the update was unsuccessful.
                                     WarningBar.snackMessage(context, message: value.data["message"], color: ColorManager.greenColor);
                                     Navigator.pop(context); // Close the loading screen.
                                   }
                                 },
                               );
                             } else {
                               // If creating a new project, make an API request to add the project.
                               ApiServices().postApi(
                                 api: "${APIConstants.baseUrl}Project/createproject", // API endpoint for creating a new project.
                                 body: {
                                   ApiRequestBody.apiTitle: _titleCtrl.text.trim(),
                                   ApiRequestBody.apiDescription: _descriptionCtrl.text.trim(),
                                   ApiRequestBody.apiTechnologies: _techList.value,
                                   ApiRequestBody.apiProjectUrl: _githubUrlCtrl.text.trim(),
                                   ApiRequestBody.apiUserId: UserPreferences.userId, // Pass the user's ID for creating the project.
                                 },
                               ).then(
                                     (value) {
                                   if (value.statusCode == ServerStatusCodes.success) {
                                     // Clear form fields and show a success message.
                                     _titleCtrl.clear();
                                     _descriptionCtrl.clear();
                                     _githubUrlCtrl.clear();
                                     _techList.value.clear();
                                     WarningBar.snackMessage(context, message: StringManager.addProjectSuccessTxt, color: ColorManager.greenColor);
                                     Navigator.pop(context); // Close the current screen.
                                     Navigator.pop(context); // Close the previous screen.
                                     Navigator.pop(context); // Close the screen before the previous screen.
                                   } else {
                                     // Show an error message if project creation was unsuccessful.
                                     WarningBar.snackMessage(context, message: value.data["message"], color: ColorManager.greenColor);
                                     Navigator.pop(context); // Close the loading screen.
                                   }
                                 },
                               );
                             }
                           }

                         },
                       );
                     },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
