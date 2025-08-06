import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/student_behaviour_view/BehaviourViewResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/student_behavior_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:masterjee/widgets/util.dart';
import 'package:provider/provider.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  static String routeName = 'ViewScreen';

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {

  var _isLoading = false;
  late List<IncidentData> incidentList = [];
  late String studentId;
  bool _isInitialized = false;
  late Student stuData;
  List<TextEditingController> controllers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is String) {
        studentId = args;
        callApiStudentBehaviourView(studentId);
        _isInitialized = true;
      }
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> callApiStudentBehaviourView(String studentId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      BehaviourViewResponse data =
          await Provider.of<StudentBehaviorApi>(context, listen: false)
              .studentBehaviourView(
                  StorageHelper.getStringData(StorageHelper.userIdKey)
                      .toString(),
                  studentId);
      if (data.result) {
        setState(() {
          stuData = data.data!.studentData;
          incidentList = data.data!.incidentData;
          controllers = List.generate(data.data!.incidentData.length, (index) => TextEditingController());
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("error : ${error}");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> saveIncidentComment(String userId,String incidentId,
      String comment,int index) async {
    setState(() {
      _isLoading = true;
    });
    try {
      BehaviourViewResponse data =
      await Provider.of<StudentBehaviorApi>(context, listen: false)
          .saveIncidentComment(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          incidentId,
          comment);
      if (data.result) {
        setState(() {
          _isLoading = false;
          /*for (var controller in controllers) {
            controller.dispose();
          }*/
          for (int i = 0 ; i < controllers.length ; i++){
            controllers[i].text = "";
          }
          CommonFunctions.showWarningToast(data.message);
          callApiStudentBehaviourView(studentId);
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("error : ${error}");
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.view),
      body: Stack(
        children: [
          Builder(builder: (context) {
            if (_isLoading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * .5,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (incidentList.isEmpty) {
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
                  itemCount: incidentList.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        child: assignmentCard(incidentList[index], index));
                  }),
            );
          }),
        ],
      ),
    );
  }

  Widget assignmentCard(IncidentData data,int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.sp),
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
            padding: EdgeInsets.all(20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                      child: CommonText.bold(data.title,
                          size: 14.sp, color: Colors.black)),
                  SizedBox(width: 20.w),
                  CommonText.medium("Point : ${data.point}",
                      size: 13.sp,
                      color: kDarkGreyColor,
                      overflow: TextOverflow.fade),
                ]),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: colorGaryLine,
                  width: double.infinity,
                  height: 1.h,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonText.regular(
                    "${formatDateString(data.idate, "yyyy-MM-dd", "yyyy-MM-dd")} | ${data.employeeId} - ${data.name}",
                    size: 9.sp,
                    color: colorBlack,
                    overflow: TextOverflow.fade),
                const SizedBox(
                  height: 5,
                ),
                CommonText.regular(data.description,
                    size: 11.sp,
                    color: kDarkGreyColor,
                    overflow: TextOverflow.fade),
                const SizedBox(
                  height: 10,
                ),
                studentList(data.studentComments, data),
                const SizedBox(
                  height: 10,
                ),
                studentList(data.staffComments, data),
                TextFormField(
                  style: const TextStyle(fontSize: 14),
                  keyboardType: TextInputType.name,
                  maxLines: 3,
                  controller: controllers[index],
                  decoration: getInputDecoration('Write comment here...', null,
                      kSecondBackgroundColor, Colors.white),
                  validator: (input) {
                    if (input == null) {
                      return "Please enter name";
                    } else {
                      return "";
                    }
                  },
                  onSaved: (value) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CommonButton(
                          cornersRadius: 30,
                          text: AppTags.submit,
                          onPressed: () {
                            if(controllers[index].text != ""){
                              saveIncidentComment(data.studentId,data.incidentId,controllers[index].text,index);
                            }
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget studentList(List<StudentComment> data, IncidentData incidentData) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        padding: EdgeInsets.only(top: 10.sp),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: studentData(data[index], incidentData),
          );
        });
  }

  Widget studentData(StudentComment data, IncidentData incidentData) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: CommonText.medium(data.comment,
                  size: 12.sp, color: Colors.black)),
          SizedBox(width: 20.w),
          CommonText.medium(
              "${formatDateString(data.createdDate, "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd")} | ${stuData.admissionNo} - ${stuData.firstname}",
              size: 9.sp,
              color: kDarkGreyColor,
              overflow: TextOverflow.fade),
        ])
      ],
    );
  }

  rowValue(String key, value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: CommonText.medium(key, size: 12.sp, color: Colors.black)),
      SizedBox(width: 20.w),
      CommonText.medium(value,
          size: 11.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
    ]);
  }
}
