import 'package:file_picker_pro/file_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/homework_list/HomeworkListResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/homework_api.dart';
import 'package:masterjee/screens/homework/submitted_homework_info.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class HomeworkScreen extends StatefulWidget {
  const HomeworkScreen({super.key});

  static String routeName = 'homeworkScreen';

  @override
  State<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {

  bool _isLoading = false;
  late TabController tabController;
  final formKey = GlobalKey<FormState>();
  late List<HomeworkData> homeworkList = [];
  final _fromMaxMarkController = TextEditingController();
  String? _selectedSubject;
  List<String> subjectData = [
    "PA-1",
    "Personal",
    "Sanskrit",
    "Kannada",
    "English"
  ];
  String? _selectedSubjectId;
  final _HomeWorkDateController = TextEditingController();
  DateTime? _selectedSubmissionDate;

  final _SubmissionDateController = TextEditingController();
  DateTime? _selectedHomeWorkDate;


  Future<void> callApiHomeworkList(String type) async {
    setState(() {
      _isLoading = true;
    });
    try {
      HomeworkListResponse data = await Provider.of<HomeworkApi>(context,
              listen: false)
          .getHomeworkList(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.sectionIdKey)
                  .toString(),
              type);
      if (data.result) {
        setState(() {
          homeworkList = data.data;
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging == true) {
        if (tabController.index == 0) {
          callApiHomeworkList(HomeworkListType.upcoming.name);
        } else if (tabController.index == 1) {
          callApiHomeworkList(HomeworkListType.closed.name);
        }
      }
    });
    callApiHomeworkList(HomeworkListType.upcoming.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: "HomeWork"),
      floatingActionButton: FloatingActionButton(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.sp)),
        backgroundColor: colorGreen,
        tooltip: AppTags.applyLeave,
        onPressed: () {
          _showBottomSheet(context, false);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: Stack(
        children: [
          Builder(builder: (context) {
            /*if (_isLoading) {
              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            if (homeworkList.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hourglass_empty_outlined, size: 100.sp),
                    CommonText.medium('No Record Found',
                        size: 16.sp,
                        color: kDarkGreyColor,
                        overflow: TextOverflow.fade),
                  ],
                ),
              );
            }*/
            return Container(
              padding: EdgeInsets.only(top: 10.sp),
              child: Column(children: [
                Container(
                  height: 50.sp,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: -2.0,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: TabBar(
                    controller: tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: const BoxDecoration(
                      color: colorGreen,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: colorGreen,
                    tabs: [
                      Tab(
                        icon: CommonText.medium(
                          'Upcoming',
                          size: 14.sp,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Tab(
                        icon: CommonText.medium(
                          'Closed',
                          size: 14.sp,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [listView(context), listView(context)],
                  ),
                )
              ]),
            );
          })
        ],
      ),
    );
  }

  Widget listView(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (homeworkList.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_empty_outlined, size: 100.sp),
            CommonText.medium('No Record Found',
                size: 16.sp,
                color: kDarkGreyColor,
                overflow: TextOverflow.fade),
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: homeworkList.length,
          padding: EdgeInsets.only(top: 10.sp),
          itemBuilder: (BuildContext context, int index) {
            return contentCard(index, context);
          }),
    );
  }

  Widget contentCard(int index, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, SubmittedHomeworkInfoScreen.routeName ,arguments: homeworkList[index]);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(10.sp),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            rowValue("Date", homeworkList[index].homeworkDate ?? '-'),
            rowValue("Subject", homeworkList[index].name ?? '-'),
            rowValue("Submitted date ", homeworkList[index].submitDate ?? '-'),
            rowValue(
                "Evaluation date ", homeworkList[index].evaluationDate ?? '-'),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext mainCon, bool isEdit) {
    showModalBottomSheet(
      backgroundColor: kSecondBackgroundColor,
      context: mainCon,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12.r),
            bottom: Radius.circular(12.r),
          )),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButton(
                      hint: const CommonText('Subject',
                          size: 14, color: Colors.black54),
                      value: _selectedSubject,
                      icon: const Card(
                        elevation: 0.1,
                        color: kBackgroundColor,
                        child: Icon(Icons.keyboard_arrow_down_outlined),
                      ),
                      underline: const SizedBox(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSubject = null;
                          _selectedSubject = value.toString();
                          for (int i = 0; i < subjectData.length; i++) {
                            if (subjectData[i].toString().toLowerCase() ==
                                value.toString().toLowerCase()) {
                              _selectedSubjectId = subjectData[i].toString();
                              break;
                            }
                          }
                        });
                      },
                      isExpanded: true,
                      items: subjectData.map((cd) {
                        return DropdownMenuItem(
                          value: cd,
                          onTap: () {
                            setState(() {
                              _selectedSubject = cd;
                              for (int i = 0; i < subjectData.length; i++) {
                                if (subjectData[i].toString().toLowerCase() ==
                                    cd.toString().toLowerCase()) {
                                  _selectedSubjectId = subjectData[i].toString();
                                  break;
                                }
                              }
                            });
                          },
                          child: Text(
                            cd.toString(),
                            style: const TextStyle(
                              color: colorBlack,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    CustomTextField(
                      onTap: () {
                        _selectHomeWorkDate(context);
                      },
                      hintText: 'Select Homework Date',
                      isRequired: true,
                      prefixIcon: const Icon(
                        Icons.date_range_outlined,
                        color: kTextLowBlackColor,
                      ),
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'From Date cannot be empty';
                        }
                        return null;
                      },
                      isReadonly: true,
                      controller: _HomeWorkDateController,
                      onSave: (value) {
                        // _authData['email'] = value.toString();
                        _HomeWorkDateController.text = value as String;
                      },
                    ),
                    CustomTextField(
                      onTap: () {
                        _selectSubmissionDate(context);
                      },
                      hintText: 'Select Submission Date',
                      isRequired: true,
                      prefixIcon: const Icon(
                        Icons.date_range_outlined,
                        color: kTextLowBlackColor,
                      ),
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'From Date cannot be empty';
                        }
                        return null;
                      },
                      isReadonly: true,
                      controller: _SubmissionDateController,
                      onSave: (value) {
                        _SubmissionDateController.text = value as String;
                      },
                    ),
                    CustomTextField(
                      borderRadius: 10.0,
                      onTap: () {},
                      hintText: 'Max mark',
                      isRequired: true,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter max mark';
                        }
                        return null;
                      },
                      isReadonly: false,
                      controller: _fromMaxMarkController,
                      onSave: (value) {
                        _fromMaxMarkController.text = value as String;
                      },
                    )
                  ],
                )
              ),
            );
          }),
        );
      },
    );
  }

  Future<void> _selectHomeWorkDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedHomeWorkDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedHomeWorkDate) {
      setState(() {
        _selectedHomeWorkDate = pickedDate;
        _HomeWorkDateController.text = pickedDate.toLocalDMYDateString();
      });
    }
  }

  Future<void> _selectSubmissionDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedSubmissionDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedSubmissionDate) {
      setState(() {
        _selectedSubmissionDate = pickedDate;
        _SubmissionDateController.text = pickedDate.toLocalDMYDateString();
      });
    }
  }


}

rowValue(String key, value) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SizedBox(
        width: 100.sp,
        child: CommonText.medium(key, size: 12.sp, color: Colors.black)),
    SizedBox(width: 20.w),
    CommonText.medium(value,
        size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
  ]);
}
