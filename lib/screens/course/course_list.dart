import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/course/course_model.dart';
import 'package:masterjee/models/error_model.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/course_api.dart';
import 'package:masterjee/screens/course/single_course_details.dart';
import 'package:masterjee/screens/exam/exam/add_score_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  static String routeName = 'courseListScreen';

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  var _isLoading = false;
  var _isLoadingPopUp = false;
  late List<Courses> courseList = [];
  late List<Category> categoryList = [];

  @override
  void initState() {
    callApiAllExams();
    super.initState();
  }

  Future<void> callApiAllExams() async {
    setState(() {
      _isLoading = true;
    });
    try {
      AllCourseData data = await Provider.of<CourseApi>(context, listen: false).allCourse(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.sectionIdKey).toString());
      print("ddfdf");
      print(data.status);
      if (data.status == "success") {
        setState(() {
          courseList = data.data?.courses ?? [];
          categoryList = data.data?.category ?? [];
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      _isLoading = false;
    }
  }

  void showAddCourseModalBottomSheet(BuildContext mainCon, List<Category> categoryValues) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController fileController = TextEditingController();
    final TextEditingController youtubeUrlController = TextEditingController();
    final TextEditingController discountController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    final List<Category> sections = categoryValues;
    final List<String> types = ['Front Visibility - Yes', 'Front Visibility - No'];

    String? selectedCategory;
    String selectedType = 'Front Visibility - Yes';
    bool selectedOption = false;

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: mainCon,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 24,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Section Dropdown
                      DropdownButtonFormField<String>(
                        value: selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => setState(() {
                          print(value);
                          selectedCategory = value;
                        }),
                        items: sections.map((category) {
                          return DropdownMenuItem(
                            value: category.id,
                            child: Text(category.categoryName.toString()),
                          );
                        }).toList(),
                        validator: (value) => value == null ? 'Please select a category' : null,
                      ),
                      const SizedBox(height: 12),

                      // Title
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => (value == null || value.isEmpty) ? 'Title required' : null,
                      ),
                      const SizedBox(height: 12),

                      // description
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 12),

                      // Title
                      TextFormField(
                        controller: priceController,
                        decoration: const InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) => (value == null || value.isEmpty) ? 'Price required' : null,
                      ),
                      const SizedBox(height: 12),

                      // Discount
                      TextFormField(
                        controller: discountController,
                        decoration: const InputDecoration(
                          labelText: 'Discount %',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) => (value == null || value.isEmpty) ? 'Discount required' : null,
                      ),

                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Switch(
                            value: selectedOption,
                            activeColor: colorGreen, // ✅ active thumb color
                            activeTrackColor: Colors.lightGreenAccent, // ✅ active track color
                            inactiveThumbColor: Colors.green.shade50, // ✅ inactive thumb color
                            inactiveTrackColor: Colors.white, // ✅ inactive track color
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                selectedOption = value;
                              });
                            },
                          ),
                          const SizedBox(width: 2),
                          const Text("Free course"),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Type Dropdown
                      DropdownButtonFormField<String>(
                        value: selectedType,
                        decoration: const InputDecoration(
                          labelText: 'Front Visibility',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedType = value ?? "Front Visibility - Yes";
                            // Clear dependent fields
                          });
                        },
                        items: types.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        validator: (value) => value == null ? 'Please select a type' : null,
                      ),
                      const SizedBox(height: 12),

                      // YouTube URL
                      TextFormField(
                        controller: youtubeUrlController,
                        decoration: const InputDecoration(
                          labelText: 'YouTube Video URL',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.url,
                        validator: (value) => (value == null || value.isEmpty) ? 'YouTube URL required' : null,
                      ),
                      const SizedBox(height: 12),
                      // Upload File
                      TextFormField(
                        readOnly: true,
                        controller: fileController,
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles();
                          if (result != null && result.files.isNotEmpty) {
                            fileController.text = result.files.single.path ?? "";
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Upload File',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.attach_file),
                        ),
                        validator: (value) => (value == null || value.isEmpty) ? 'File is required' : null,
                      ),
                      const SizedBox(height: 12),

                      // // Preview Thumbnail
                      // TextFormField(
                      //   readOnly: true,
                      //   controller: thumbnailController,
                      //   onTap: () async {
                      //     FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
                      //     if (result != null && result.files.isNotEmpty) {
                      //       thumbnailController.text = result.files.single.path ?? "";
                      //     }
                      //   },
                      //   decoration: const InputDecoration(
                      //     labelText: 'Preview Thumbnail',
                      //     border: OutlineInputBorder(),
                      //     suffixIcon: Icon(Icons.image),
                      //   ),
                      //   validator: (value) => (value == null || value.isEmpty) ? 'Thumbnail required' : null,
                      // ),
                      const SizedBox(height: 20),

                      // Submit Button
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Submission logic
                            File? doc;
                            if (fileController.text != "") {
                              setState(() {
                                doc = File(fileController.text);
                              });
                            }
                            callApiSaveCourse(
                                titleController.text,
                                descriptionController.text,
                                priceController.text,
                                selectedOption ? "1" : "0",
                                discountController.text,
                                selectedCategory ?? "",
                                selectedType,
                                youtubeUrlController.text,
                                doc);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Add'),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (courseList.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_empty_outlined, size: 100.sp),
            CommonText.medium('No Record Found', size: 16.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
          ],
        ),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: colorGreen,
          onPressed: () {
            showAddCourseModalBottomSheet(context, categoryList);
          },
          child: const Icon(Icons.add, color: Colors.white)),
      body: Container(
        height: double.infinity,
        color: kBackgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: courseList.length,
              padding: EdgeInsets.only(top: 10.sp),
              itemBuilder: (BuildContext c, int index) {
                Courses data = courseList[index];
                return InkWell(
                    onTap: () {
                      //Navigator.push(context);
                    },
                    child: leadsCard(data, context));
              }),
        ),
      ),
    );
  }

  Widget leadsCard(Courses data, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: kSecondBackgroundColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: -2.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200.sp,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading_animated.gif',
                      image: '${data.courseThumbnail}',
                      height: 120.sp,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)), color: colorGaryText),
                        child: CommonText.regular(data.title ?? "",
                                size: 10.sp, color: Colors.white, overflow: TextOverflow.fade)
                            .paddingOnly(left: 5, right: 5, bottom: 2, top: 2),
                      ),
                    ),
                    gap(10.w),
                    Container(
                      decoration:
                          const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: colorGaryText),
                      child: CommonText.regular((data.employeeId ?? "") + AppTags.space + (data.name ?? ""),
                              size: 10.sp, color: Colors.white, overflow: TextOverflow.fade)
                          .paddingOnly(left: 5, right: 5, bottom: 2, top: 2),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                CommonText.medium(data.description ?? "",
                    size: 13.sp, color: Colors.black, overflow: TextOverflow.fade),
                gap(15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showOutComesPopup(context, data.id.toString());
                      },
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.news,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    ),
                    InkWell(
                      onTap: () {
                        showSectionsPopup(context, data.id.toString());
                      },
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.book,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    ),
                    InkWell(
                      onTap: () {
                        showSectionModalBottomSheet(context, data.sections ?? []);
                      },
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.newspaper,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SingleCourseDetailScreen(course: data)),
                        );
                      },
                      child: Icon(
                        CupertinoIcons.eye_fill,
                        size: 15.sp,
                        color: Colors.black,
                      ).paddingAll(10),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> callApiSaveCourse(
    String title,
    description,
    price,
    freeCourse,
    discount,
    categoryId,
    frontSideVisibility,
    videoId,
    File? file,
  ) async {
    setState(() {
      _isLoadingPopUp = true;
    });
    try {
      Map<String, String> body = {
        'userId': StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
        "sectionId": StorageHelper.getStringData(StorageHelper.sectionIdKey).toString(),
        "classId": StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
        "title": title,
        "description": description,
        "price": price,
        "discount": discount,
        "freeCourse": freeCourse,
        "categoryId": categoryId,
        "frontSideVisibility": frontSideVisibility,
        "videoId": videoId,
        "teacherId": ""
      };

      print(body);
      ErrorMessageModel data = await Provider.of<CourseApi>(context, listen: false).saveCourse(body, file);
      if (data.status == "success") {
        setState(() {
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          CommonFunctions.showSuccessToast(data.message ?? "");
          _isLoadingPopUp = false;
        });
        return;
      } else {
        setState(() {
          CommonFunctions.showWarningToast(data.message ?? "");
          _isLoadingPopUp = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> callApiSaveLesson(String sectionId, lessonTitle, lessonType, lessonUrl, lessonSummary, lessonDuration,
      File? file, File? file2) async {
    setState(() {
      _isLoadingPopUp = true;
    });
    try {
      Map<String, String> body = {
        'userId': StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
        "sectionId": sectionId,
        "lessonTitle": lessonTitle,
        "lessonType": lessonType,
        "lessonUrl": lessonUrl,
        "lessonSummary": lessonSummary,
        "lessonDuration": lessonDuration,
      };
      print(body);
      ErrorMessageModel data = await Provider.of<CourseApi>(context, listen: false).saveLesson(body, file, file2);
      if (data.status == "success") {
        setState(() {
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          CommonFunctions.showSuccessToast(data.message ?? "");
          _isLoadingPopUp = false;
        });
        return;
      } else {
        setState(() {
          CommonFunctions.showWarningToast(data.message ?? "");
          _isLoadingPopUp = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  rowValue(String key, value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 80.sp, child: CommonText.regular(key, size: 12.sp, color: Colors.black)),
      const Expanded(child: SizedBox()),
      CommonText.regular(value, size: 12.sp, color: Colors.black, overflow: TextOverflow.fade),
    ]);
  }

  List<Map<String, dynamic>> items = [
    {'id': 1, 'name': '918772 Aishwarya', 'isChecked': false},
    {'id': 2, 'name': '78299 Dhanashree', 'isChecked': false},
    {'id': 3, 'name': '12365 Eshwar L', 'isChecked': false},
  ];

  List<Map<String, dynamic>> items1 = [
    {'date': "2024-02-16", 'name': 'business management', 'isChecked': false},
    {'date': "	2024-02-05", 'name': 'Science', 'isChecked': false},
  ];

  bool _isChecked = true;

  void showSectionModalBottomSheet(BuildContext mainCon, List<Section> sectionValues) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TextEditingController lessonTitleController = TextEditingController();
    final TextEditingController summaryController = TextEditingController();
    final TextEditingController fileController = TextEditingController();
    final TextEditingController thumbnailController = TextEditingController();
    final TextEditingController youtubeUrlController = TextEditingController();
    final TextEditingController durationController = TextEditingController();

    final List<Section> sections = sectionValues;
    final List<String> types = ['Video', 'PDF', 'Text', 'Document'];

    String? selectedSection;
    String selectedType = 'Video';

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: mainCon,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 24,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Section Dropdown
                      DropdownButtonFormField<String>(
                        value: selectedSection,
                        decoration: const InputDecoration(
                          labelText: 'Section',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => setState(() {
                          print(value);
                          selectedSection = value;
                        }),
                        items: sections.map((section) {
                          return DropdownMenuItem(
                            value: section.id,
                            child: Text(section.sectionTitle.toString()),
                          );
                        }).toList(),
                        validator: (value) => value == null ? 'Please select a section' : null,
                      ),
                      const SizedBox(height: 12),

                      // Lesson Title
                      TextFormField(
                        controller: lessonTitleController,
                        decoration: const InputDecoration(
                          labelText: 'Lesson Title',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => (value == null || value.isEmpty) ? 'Lesson Title required' : null,
                      ),
                      const SizedBox(height: 12),

                      // Type Dropdown
                      DropdownButtonFormField<String>(
                        value: selectedType,
                        decoration: const InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedType = value ?? "Video";
                            // Clear dependent fields
                            fileController.clear();
                            youtubeUrlController.clear();
                            durationController.clear();
                          });
                        },
                        items: types.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        validator: (value) => value == null ? 'Please select a type' : null,
                      ),
                      const SizedBox(height: 12),

                      if (selectedType == 'Video') ...[
                        // YouTube URL
                        TextFormField(
                          controller: youtubeUrlController,
                          decoration: const InputDecoration(
                            labelText: 'YouTube URL',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.url,
                          validator: (value) => (value == null || value.isEmpty) ? 'YouTube URL required' : null,
                        ),
                        const SizedBox(height: 12),

                        // Duration
                        TextFormField(
                          readOnly: true,
                          controller: durationController,
                          onTap: () async {
                            Duration selectedDuration = const Duration(hours: 0, minutes: 0, seconds: 0);
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 250,
                                  child: CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hms,
                                    initialTimerDuration: selectedDuration,
                                    onTimerDurationChanged: (Duration newDuration) {
                                      setState(() {
                                        selectedDuration = newDuration;
                                        durationController.text =
                                            "${selectedDuration.inHours.toString().padLeft(2, '0')}:${(selectedDuration.inMinutes % 60).toString().padLeft(2, '0')}:${(selectedDuration.inSeconds % 60).toString().padLeft(2, '0')}";
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          decoration: const InputDecoration(
                            labelText: 'Duration',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.access_time),
                          ),
                          validator: (value) => (value == null || value.isEmpty) ? 'Duration required' : null,
                        ),
                      ] else ...[
                        // Upload File
                        TextFormField(
                          readOnly: true,
                          controller: fileController,
                          onTap: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles();
                            if (result != null && result.files.isNotEmpty) {
                              fileController.text = result.files.single.path ?? "";
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Upload File',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.attach_file),
                          ),
                          validator: (value) => (value == null || value.isEmpty) ? 'File is required' : null,
                        ),
                      ],
                      const SizedBox(height: 12),

                      // Summary
                      TextFormField(
                        controller: summaryController,
                        decoration: const InputDecoration(
                          labelText: 'Summary',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 12),

                      // Preview Thumbnail
                      TextFormField(
                        readOnly: true,
                        controller: thumbnailController,
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
                          if (result != null && result.files.isNotEmpty) {
                            thumbnailController.text = result.files.single.path ?? "";
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Preview Thumbnail',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.image),
                        ),
                        validator: (value) => (value == null || value.isEmpty) ? 'Thumbnail required' : null,
                      ),
                      const SizedBox(height: 20),

                      // Submit Button
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Submission logic
                            File? doc;
                            if (fileController.text != "") {
                              setState(() {
                                doc = File(fileController.text);
                              });
                            }
                            callApiSaveLesson(
                                selectedSection ?? "",
                                lessonTitleController.text,
                                selectedType,
                                youtubeUrlController.text,
                                summaryController.text,
                                durationController.text,
                                doc,
                                File(thumbnailController.text));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Add'),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> showSectionsPopup(BuildContext cnt, String cID) async {
    List<TextEditingController> controllers = [
      TextEditingController(),
    ];

    void addField(StateSetter setState) {
      setState(() {
        controllers.add(TextEditingController());
      });
    }

    void submitSections(cnt) async {
      setState(() {
        _isLoadingPopUp = true;
      });
      List<Map<String, String>> sections = [];
      for (var controller in controllers) {
        sections.add({
          "sectionTitle": controller.text,
        });
        print('Section: ${controller.text}');
      }
      try {
        SuccessData data = await Provider.of<CourseApi>(cnt, listen: false)
            .saveSections(StorageHelper.getStringData(StorageHelper.userIdKey).toString(), cID, sections);
        if (data.status == "success") {
          setState(() {
            _isLoadingPopUp = false;
            Navigator.pop(cnt);
            CommonFunctions.showSuccessToast(data.message ?? "");
          });
          return;
        } else {
          setState(() {
            _isLoadingPopUp = false;
            CommonFunctions.showWarningToast(data.message ?? "Something went wrong");
          });
        }
      } catch (error) {
        print("callApi_error : $error");
        /*setState(() {
        _isLoading = false;
      });*/
      }
    }

    await showDialog(
      context: cnt,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // Use this to update the UI inside the dialog
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: kBackgroundColor,
              title: const CommonText('Sections', size: 18),
              content: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: kBackgroundColor, // background color
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width - 30.sp,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...controllers.map((controller) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: CustomTextField(
                              borderRadius: 5,
                              hintText: 'Section',
                              isReadonly: false,
                              controller: controller,
                              keyboardType: TextInputType.name,
                            ),
                          )),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => addField(setState),
                        child: Row(
                          children: [
                            const Icon(Icons.add, size: 20),
                            const SizedBox(width: 4),
                            Text("Add More", style: TextStyle(color: Colors.grey[700])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                _isLoadingPopUp
                    ? const CircularProgressIndicator()
                    : CommonButton(
                        cornersRadius: 30,
                        text: AppTags.add,
                        onPressed: () => submitSections(context),
                      ).paddingOnly(left: 15, right: 15, bottom: 10)
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showOutComesPopup(BuildContext cnt, String cID) async {
    List<TextEditingController> controllers = [
      TextEditingController(),
    ];

    void addField(StateSetter setState) {
      setState(() {
        controllers.add(TextEditingController());
      });
    }

    void submitOutComes(cnt) async {
      setState(() {
        _isLoadingPopUp = true;
      });
      List<Map<String, String>> outcomes = [];
      for (var controller in controllers) {
        outcomes.add({
          "outcome": controller.text,
        });
        print('outcome: ${controller.text}');
      }
      try {
        SuccessData data = await Provider.of<CourseApi>(context, listen: false)
            .saveOutComes(StorageHelper.getStringData(StorageHelper.userIdKey).toString(), cID, outcomes);
        if (data.status == "success") {
          setState(() {
            _isLoadingPopUp = false;
            Navigator.pop(cnt);
            CommonFunctions.showSuccessToast(data.message ?? "");
          });
          return;
        } else {
          setState(() {
            _isLoadingPopUp = false;
            CommonFunctions.showWarningToast(data.message ?? "Something went wrong");
          });
        }
      } catch (error) {
        print("callApi_error : $error");
        /*setState(() {
        _isLoading = false;
      });*/
      }
    }

    await showDialog(
      context: cnt,
      builder: (BuildContext cont) {
        return StatefulBuilder(
          // Use this to update the UI inside the dialog
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: kBackgroundColor,
              title: const CommonText(
                'OutComes',
                size: 18,
              ),
              content: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: kBackgroundColor, // background color
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width - 30.sp,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...controllers.map((controller) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: CustomTextField(
                              borderRadius: 5,
                              hintText: 'Outcome',
                              isReadonly: false,
                              controller: controller,
                              keyboardType: TextInputType.name,
                            ),
                          )),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => addField(setState),
                        child: Row(
                          children: [
                            const Icon(Icons.add, size: 20),
                            const SizedBox(width: 4),
                            Text("Add More", style: TextStyle(color: Colors.grey[700])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                CommonButton(
                  cornersRadius: 30,
                  text: AppTags.add,
                  onPressed: () => submitOutComes(context),
                ).paddingOnly(left: 15, right: 15, bottom: 10)
              ],
            );
          },
        );
      },
    );
  }

  Widget studentRow(Map<String, dynamic> data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        gap(8.0),
        Transform.scale(
          scale: 0.85,
          child: Checkbox(
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value ?? false;
              });
            },
            checkColor: Colors.white,
            activeColor: Colors.green,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(
          width: 80,
          height: 0,
        ),
        CommonText.medium(
          data['name'],
          size: 14.sp,
          color: colorBlack,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }

  Widget subjectRow(Map<String, dynamic> data, BuildContext c) {
    return InkWell(
      onTap: () {
        Navigator.of(c).pop();
        Navigator.of(context).pushNamed(AddScoreScreen.routeName);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: CommonText.medium(
              data["name"],
              size: 14.sp,
              color: colorBlack,
              overflow: TextOverflow.fade,
            ),
          ),
          CommonText.medium(
            data["date"],
            size: 14.sp,
            color: colorBlack,
            overflow: TextOverflow.fade,
          ),
          gap(10.0),
          SvgPicture.asset(
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
            AssetsUtils.news,
            width: 15.sp,
            height: 15.sp,
          )
        ],
      ).paddingOnly(top: 10),
    );
  }
}
