import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/leads/view_leads_reasponse.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';


class EditLeadsScreen extends StatefulWidget {
  const EditLeadsScreen({super.key});

  static String routeName = 'editLeadsScreen';

  @override
  State<EditLeadsScreen> createState() => _EditLeadsScreenState();
}

class _EditLeadsScreenState extends State<EditLeadsScreen> {

  DateTime? _selectedFromDate;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String? _selectedGender;
  List<String> genderList = ["Male", "Female"];
  String? _selectedResourceId;

  String? _selectedResource;
  List<String> resourceList = ["Parent", "Teacher","newspaper","Social media",
    "Student TS","Tele marketing TS","Cousin"];
  String? _selectedGenderId;

  final _dateController = TextEditingController();
  late var nameController = TextEditingController();
  late var casteController = TextEditingController();
  late var subCasteController = TextEditingController();
  late var aadhaarNoController = TextEditingController();
  late var bloodGroupController = TextEditingController();
  late var religionController = TextEditingController();
  late var motherTongueController = TextEditingController();
  late var fatherNameController = TextEditingController();
  late var fatherPhoneController = TextEditingController();
  late var fatherOccupationController = TextEditingController();
  late var motherQualificationController = TextEditingController();
  late var guardianNameController = TextEditingController();
  late var guardianPhotoController = TextEditingController();
  late var classController = TextEditingController();
  late var courseController = TextEditingController();
  late var subjectController = TextEditingController();
  late var addressController = TextEditingController();
  late var locationController = TextEditingController();
  late var phoneNumberController = TextEditingController();
  late var alternativePhoneNumberController = TextEditingController();
  late var emergencyPhoneNumberController = TextEditingController();
  late var emailController = TextEditingController();
  late var sourceController = TextEditingController();
  late LeadData? data;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      data = ModalRoute.of(context)!.settings.arguments as LeadData;
      if(data != null){
        nameController.text = data?.lName ?? "";
        emailController.text = data?.lEmail ?? "";
        casteController.text = data?.lCaste ?? "";
        subCasteController.text = data?.lSubCaste ?? "";
        aadhaarNoController.text = data?.lAadharNo ?? "";
        bloodGroupController.text = data?.lBloodGroup ?? "";
        religionController.text = data?.lReligion ?? "";
        motherTongueController.text = data?.lMotherTongue ?? "";
        fatherNameController.text = data?.lFatherName ?? "";
        fatherPhoneController.text = data?.lFatherPhone ?? "";
        fatherOccupationController.text = data?.lFatherQualification ?? "";
        motherQualificationController.text = data?.lMotherQualification ?? "";
        guardianNameController.text = data?.lGuradianName ?? "";
        guardianPhotoController.text = data?.lGuardianPhone ?? "";
        classController.text = data?.lClass ?? "";
        courseController.text = data?.lEnrolledCourse ?? "";
        subjectController.text = data?.lClass ?? "";
        addressController.text = data?.lAddress ?? "";
        locationController.text = data?.lLocation ?? "";
        phoneNumberController.text = data?.lPhoneNumber ?? "";
        alternativePhoneNumberController.text = data?.lAlternativePhone ?? "";
        emergencyPhoneNumberController.text = data?.lEmergencyContactNo ?? "";
        sourceController.text = data?.lSource ?? "";
      }
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      backgroundColor: colorGaryBG,
      bottomNavigationBar: CommonButton(
        paddingHorizontal: 7,
        paddingVertical: 9,
        cornersRadius: 10,
        text: AppTags.save,
        onPressed: () {
          if (!globalFormKey.currentState!.validate()) {
            return;
          }
          globalFormKey.currentState!.save();
        },
      ).paddingOnly(bottom: 10,left: 10,right: 10),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Form(
                key: globalFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextField(
                        validate: (input) =>
                            input!.length == 0 ? "Please enter name" : null,
                        hintText: 'Name',
                        isReadonly: false,
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        onSave: (value) {
                          nameController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      Card(
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        color: colorWhite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: DropdownButton(
                            hint: const CommonText('Select gender',
                                size: 14, color: Colors.black54),
                            value: _selectedGender,
                            icon: const Card(
                              elevation: 0.1,
                              color: colorWhite,
                              child: Icon(Icons.keyboard_arrow_down_outlined),
                            ),
                            underline: const SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = null;
                                _selectedGender = value.toString();
                                for (int i = 0; i < genderList.length; i++) {
                                  if (genderList[i].toString().toLowerCase() ==
                                      value.toString().toLowerCase()) {
                                    _selectedResourceId = genderList[i].toString();
                                    break;
                                  }
                                }
                              });
                            },
                            isExpanded: true,
                            items: genderList.map((cd) {
                              return DropdownMenuItem(
                                value: cd,
                                onTap: () {
                                  setState(() {
                                    _selectedGender = cd;
                                    for (int i = 0; i < genderList.length; i++) {
                                      if (genderList[i]
                                              .toString()
                                              .toLowerCase() ==
                                          cd.toString().toLowerCase()) {
                                        _selectedResourceId =
                                            genderList[i].toString();
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
                        ),
                      ),
                      gap(10.0),
                      CustomTextField(
                        onTap: () {
                          _selectFromDate(context);
                        },
                        hintText: 'Date',
                        isRequired: true,
                        prefixIcon: const Icon(
                          Icons.date_range_outlined,
                          color: kTextLowBlackColor,
                        ),
                        isReadonly: true,
                        controller: _dateController,
                        onSave: (value) {
                          _dateController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) =>
                            input!.length == 0 ? "Please enter caste" : null,
                        hintText: 'Caste',
                        isReadonly: false,
                        controller: casteController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          casteController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) => input!.length == 0
                            ? "Please enter sub caste"
                            : null,
                        hintText: 'Sub caste',
                        isReadonly: false,
                        controller: subCasteController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          subCasteController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) => input!.length == 0
                            ? "Please enter aadhaar no"
                            : null,
                        hintText: 'Aadhaar no',
                        isReadonly: false,
                        controller: aadhaarNoController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          aadhaarNoController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) => input!.length == 0
                            ? "Please enter blood group"
                            : null,
                        hintText: 'Blood group',
                        isReadonly: false,
                        controller: bloodGroupController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          bloodGroupController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) =>
                            input!.length == 0 ? "Please enter religion" : null,
                        hintText: 'Religion',
                        isReadonly: false,
                        controller: religionController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          religionController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) => input!.length == 0
                            ? "Please enter mother tongue"
                            : null,
                        hintText: 'Mother tongue',
                        isReadonly: false,
                        controller: motherTongueController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          motherTongueController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) => input!.length == 0
                            ? "Please enter father name"
                            : null,
                        hintText: 'Father name',
                        isReadonly: false,
                        controller: fatherNameController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          fatherNameController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) => input!.length == 0
                            ? "Please enter father phone"
                            : null,
                        hintText: 'Father phone',
                        isReadonly: false,
                        controller: fatherPhoneController,
                        keyboardType: TextInputType.number,
                        onSave: (value) {
                          fatherPhoneController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) => input!.length == 0
                            ? "Please enter father occupation"
                            : null,
                        hintText: 'Father occupation',
                        isReadonly: false,
                        controller: fatherOccupationController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          fatherOccupationController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) => input!.length == 0
                            ? "Please enter mother qualification"
                            : null,
                        hintText: 'Mother qualification',
                        isReadonly: false,
                        controller: motherQualificationController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          motherQualificationController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) => input!.length == 0
                            ? "Please enter guardian name"
                            : null,
                        hintText: 'Guardian name',
                        isReadonly: false,
                        controller: guardianNameController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          guardianNameController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) => input!.length == 0
                            ? "Please enter guardian photo"
                            : null,
                        hintText: 'Guardian photo',
                        isReadonly: false,
                        controller: guardianPhotoController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          guardianPhotoController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) =>
                            input!.length == 0 ? "Please enter class" : null,
                        hintText: 'class',
                        isReadonly: false,
                        controller: classController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          classController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) =>
                            input!.length == 0 ? "Please enter course" : null,
                        hintText: 'course',
                        isReadonly: false,
                        controller: courseController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          courseController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) =>
                            input!.length == 0 ? "Please enter subject" : null,
                        hintText: 'Subject',
                        isReadonly: false,
                        controller: subjectController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          subjectController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) =>
                            input!.length == 0 ? "Please enter address" : null,
                        hintText: 'Address',
                        isReadonly: false,
                        controller: addressController,
                        keyboardType: TextInputType.streetAddress,
                        onSave: (value) {
                          addressController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) =>
                            input!.length == 0 ? "Please enter location" : null,
                        hintText: 'location',
                        isReadonly: false,
                        controller: locationController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          locationController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) => input!.length == 0
                            ? "Please enter phone number"
                            : null,
                        hintText: 'Phone number',
                        isReadonly: false,
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        onSave: (value) {
                          phoneNumberController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) => input!.length == 0
                            ? "Please enter alternative phone number"
                            : null,
                        hintText: 'Alternative Phone number',
                        isReadonly: false,
                        controller: alternativePhoneNumberController,
                        keyboardType: TextInputType.number,
                        onSave: (value) {
                          alternativePhoneNumberController.text =
                              value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) => input!.length == 0
                            ? "Please enter emergency phone number"
                            : null,
                        hintText: 'Emergency Phone number',
                        isReadonly: false,
                        controller: emergencyPhoneNumberController,
                        keyboardType: TextInputType.number,
                        onSave: (value) {
                          emergencyPhoneNumberController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) =>
                            input!.length == 0 ? "Please enter email" : null,
                        hintText: 'Email',
                        isReadonly: false,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onSave: (value) {
                          emailController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        validate: (input) =>
                            input!.length == 0 ? "Please enter source" : null,
                        hintText: 'source',
                        isReadonly: false,
                        controller: sourceController,
                        keyboardType: TextInputType.text,
                        onSave: (value) {
                          sourceController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      Card(
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        color: colorWhite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: DropdownButton(
                            hint: const CommonText('Select resource',
                                size: 14, color: Colors.black54),
                            value: _selectedResource,
                            icon: const Card(
                              elevation: 0.1,
                              color: colorWhite,
                              child: Icon(Icons.keyboard_arrow_down_outlined),
                            ),
                            underline: const SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                _selectedResource = null;
                                _selectedResource = value.toString();
                                for (int i = 0; i < resourceList.length; i++) {
                                  if (resourceList[i].toString().toLowerCase() ==
                                      value.toString().toLowerCase()) {
                                    _selectedResourceId = resourceList[i].toString();
                                    break;
                                  }
                                }
                              });
                            },
                            isExpanded: true,
                            items: resourceList.map((cd) {
                              return DropdownMenuItem(
                                value: cd,
                                onTap: () {
                                  setState(() {
                                    _selectedResource = cd;
                                    for (int i = 0; i < resourceList.length; i++) {
                                      if (resourceList[i]
                                          .toString()
                                          .toLowerCase() ==
                                          cd.toString().toLowerCase()) {
                                        _selectedResourceId =
                                            resourceList[i].toString();
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedFromDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedFromDate) {
      setState(() {
        _selectedFromDate = pickedDate;
        _dateController.text = pickedDate.toLocalDMYDateString();
      });
    }
  }
}