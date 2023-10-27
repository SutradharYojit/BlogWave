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
  final ValueNotifier<List> _techList = ValueNotifier([]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateProject();
  }

  void updateProject() {
    if (widget.editProject.projectDetailsScreen) {
      _titleCtrl.text = widget.editProject.projectData?.title ?? "";
      _descriptionCtrl.text = widget.editProject.projectData?.description ?? "";
      _githubUrlCtrl.text = widget.editProject.projectData?.projectUrl ?? "";
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
                      keyboardType: TextInputType.emailAddress,
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
                      keyboardType: TextInputType.emailAddress,
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
                        _techList.value.insert(0, _techCtrl.text.trim());
                        _techCtrl.clear();
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          _techList.value.insert(0, _techCtrl.text.trim());
                          _techCtrl.clear();
                          setState(() {});
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
                      keyboardType: TextInputType.emailAddress,
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
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Consumer(
                   builder: (context, ref, child) {
                     return PrimaryButton(
                       title: widget.editProject.projectDetailsScreen
                           ? StringManager.updateProjectTxt
                           : StringManager.addProjectTxt,
                       onTap: () async {
                         showDialog(
                             context: context,
                             builder: (context) {
                               return const Center(child: Loading());
                             });
                         if (widget.editProject.projectDetailsScreen) {
                           //Api Services for Update Project
                           ApiServices().postApi(
                             api: "${APIConstants.baseUrl}Project/updateProject",
                             body: {
                               "title": _titleCtrl.text.trim(),
                               "description": _descriptionCtrl.text.trim(),
                               "technologies": _techList.value,
                               "projectUrl": _githubUrlCtrl.text.trim(),
                               "id": widget.editProject.projectData!.id,
                             },
                           ).then(
                                 (value)async {
                               WarningBar.snackMessage(context, message: StringManager.updateProjectSuccessTxt, color: ColorManager.greenColor);
                               await ref.watch(projectList.notifier).getUserProject();

                               Navigator.pop(context); // For Loading
                               Navigator.pop(context); // for Project Details
                               Navigator.pop(context); // for Project Listing
                             },
                           );
                         } else {
                           //Api Services for Add Project
                           ApiServices().postApi(
                             api: "${APIConstants.baseUrl}Project/createproject",
                             body: {
                               "title": _titleCtrl.text.trim(),
                               "description": _descriptionCtrl.text.trim(),
                               "technologies": _techList.value,
                               "projectUrl": _githubUrlCtrl.text.trim(),
                               "userId": UserPreferences.userId
                             },
                           ).then(
                                 (value) {
                               _titleCtrl.clear();
                               _descriptionCtrl.clear();
                               _githubUrlCtrl.clear();
                               _techList.value.clear();
                               setState(() {});
                               WarningBar.snackMessage(context, message: StringManager.addProjectSuccessTxt, color: ColorManager.greenColor);
                               Navigator.pop(context);
                               Navigator.pop(context);
                             },
                           );
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
    );
  }
}
