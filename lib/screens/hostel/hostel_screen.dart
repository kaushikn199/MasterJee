import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/error_model.dart';
import 'package:masterjee/models/hostel/hostel.dart';
import 'package:masterjee/models/hostel/hostel_rooms.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/hostel_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class HostelRoomsScreen extends StatefulWidget {
  const HostelRoomsScreen({Key? key}) : super(key: key);
  static String routeName = 'hostelRoomsScreen';

  @override
  State<HostelRoomsScreen> createState() => _HostelRoomsScreenState();
}

class _HostelRoomsScreenState extends State<HostelRoomsScreen> with SingleTickerProviderStateMixin {
  var _isLoading = false;
  HostelData hostelData = HostelData();
  HostelRoomsData hostelRoomsData = HostelRoomsData();
  late TabController tabController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    getData();
    tabController.addListener(() {
      print("object");
      print(tabController.indexIsChanging);
      print(tabController.index);
      if (tabController.index == 0) {
        getData();
      } else if (tabController.index == 1) {
        getHostelRooms();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void getData() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<HostelRooms>(context, listen: false).getHostel().then((value) {
      setState(() {
        hostelData = value;
        _isLoading = false;
      });
    });
  }

  void getHostelRooms() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<HostelRooms>(context, listen: false).getHostelRooms().then((value) {
      setState(() {
        hostelRoomsData = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.hostel),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (tabController.index == 0) {
            _showBottomSheet(context);
          } else {
            _showBottomSheetForRooms(context);
          }
        },
        label: CommonText(
          "${AppTags.add}${AppTags.space}${tabController.index == 0 ? AppTags.hostel : AppTags.hostelRooms}",
          color: Colors.white,
          size: 12.sp,
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 22.sp,
        ),
        backgroundColor: colorGreen,
      ),
      body: Stack(
        children: [
          Builder(builder: (context) {
            return Container(
              padding: EdgeInsets.only(top: 10.sp),
              child: Column(children: [
                Container(
                  height: 50.sp,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
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
                          AppTags.hostel,
                          size: 14.sp,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Tab(
                        icon: CommonText.medium(
                          AppTags.hostelRooms,
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
                        if (hostelData.data == null || hostelData.data!.hostels!.isEmpty) {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.hourglass_empty_outlined, size: 100.sp),
                                CommonText.medium('No Record Found',
                                    size: 16.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                              ],
                            ),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: hostelData.data!.hostels?.length,
                              padding: EdgeInsets.only(top: 10.sp),
                              itemBuilder: (BuildContext context, int index) {
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
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          width: double.maxFinite,
                                          padding: EdgeInsets.all(10.sp),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
                                              color: kToastTextColor),
                                          child: Text(
                                            hostelData.data!.hostels?[index].hostelName.toString() ?? "",
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(20.sp),
                                        child: Column(
                                          children: [
                                            rowValue("Room Type", hostelData.data!.hostels?[index].type ?? ""),
                                            gap(10.sp),
                                            rowValue("In Charge",
                                                getStaffNameFromID(hostelData.data!.hostels?[index].employeeId ?? "")),
                                            gap(10.sp),
                                            rowValue("Address", hostelData.data!.hostels?[index].address ?? ""),
                                            gap(10.sp),
                                            rowValue("Intake", hostelData.data!.hostels?[index].intake ?? ""),
                                            gap(10.sp),
                                            rowValue("Meal", hostelData.data!.hostels?[index].mealType ?? ""),
                                            gap(10.sp),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        );
                      }),
                      Builder(builder: (context) {
                        if (_isLoading) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * .5,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (hostelRoomsData.data == null || hostelRoomsData.data!.hostels!.isEmpty) {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.hourglass_empty_outlined, size: 100.sp),
                                CommonText.medium('No Record Found',
                                    size: 16.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                              ],
                            ),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: hostelRoomsData.data!.rooms?.length,
                              padding: EdgeInsets.only(top: 10.sp),
                              itemBuilder: (BuildContext context, int index) {
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
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          width: double.maxFinite,
                                          padding: EdgeInsets.all(10.sp),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
                                              color: kToastTextColor),
                                          child: Text(
                                            hostelRoomsData.data!.rooms?[index].roomNo.toString() ?? "",
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(20.sp),
                                        child: Column(
                                          children: [
                                            rowValue("Hostel", hostelRoomsData.data!.rooms?[index].hostelName ?? ""),
                                            gap(10.sp),
                                            rowValue(
                                                "In Charge",
                                                getStaffNameFromIDForRooms(
                                                    hostelRoomsData.data!.rooms?[index].hostelIncharge ?? "")),
                                            gap(10.sp),
                                            rowValue("Room Type", hostelRoomsData.data!.rooms?[index].roomType ?? ""),
                                            gap(10.sp),
                                            rowValue("Beds", hostelRoomsData.data!.rooms?[index].noOfBed ?? ""),
                                            gap(10.sp),
                                            rowValue("Cost", hostelRoomsData.data!.rooms?[index].costPerBed ?? ""),
                                            gap(10.sp),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        );
                      })
                    ],
                  ),
                )
              ]),
            );
          })
        ],
      ),
    );
  }

  Future<void> callApiSaveHostel(String name, type, address, intake, inCharge, description, meals) async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, String> body = {
        'userId': StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
        "hid": "",
        "name": name,
        "type": type,
        "address": address,
        "intake": intake,
        "hostelIncharge": inCharge,
        "description": description,
        "meals": meals
      };
      ErrorMessageModel data = await Provider.of<HostelRooms>(context, listen: false).saveHostel(body);
      if (data.status == "success") {
        setState(() {
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          CommonFunctions.showSuccessToast(data.message ?? "");
          _isLoading = false;
          getData();
        });
        return;
      } else {
        setState(() {
          CommonFunctions.showWarningToast(data.message ?? "");
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> callApiSaveHostelRoom(String number, hostel, roomType, noBed, costPerBed, period, description) async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, String> body = {
        'userId': StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
        "hid": '',
        "roomNo": number,
        "hostelId": hostel,
        "roomTypeId": roomType, //1=ac, 2 non-ac
        "noOfBed":noBed,
        "costPerBed": costPerBed,
        "costTerm": period,
        "description": description
      };
      ErrorMessageModel data = await Provider.of<HostelRooms>(context, listen: false).saveHostelRooms(body);
      if (data.status == "success") {
        setState(() {
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          CommonFunctions.showSuccessToast(data.message ?? "");
          _isLoading = false;
          getHostelRooms();
        });
        return;
      } else {
        setState(() {
          CommonFunctions.showWarningToast(data.message ?? "");
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showBottomSheet(BuildContext mainCon) {
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final intakeController = TextEditingController();
    final descriptionController = TextEditingController();
    String? selectedType;
    String? selectedInChargeId;
    String? selectedInChargeName;
    List<String> typeList = ["Girls", "Boys", "Combine"];
    List<Staff> inChargeList = hostelData.data?.staff ?? [];
    final List<String> mealTypes = ['Breakfast', 'Lunch', 'Snacks', 'Dinner'];
    final List<String> selectedMeals = [];

    checkValidation(BuildContext context) async {
      if (nameController.text == "") {
        CommonFunctions.showWarningToast("Please enter ${AppTags.hostelName}");
      } else if (selectedType == null || selectedType == "") {
        CommonFunctions.showWarningToast("Please select type");
      } else if (addressController.text == "") {
        CommonFunctions.showWarningToast("Please enter ${AppTags.hostelAddress}");
      } else if (intakeController.text == "") {
        CommonFunctions.showWarningToast("Please enter intake");
      } else if (selectedInChargeId == null || selectedInChargeId == "") {
        CommonFunctions.showWarningToast("Please select In Charge");
      } else if (selectedMeals.isEmpty) {
        CommonFunctions.showWarningToast("Please select at least one meal");
      } else {
        await callApiSaveHostel(nameController.text, selectedType, addressController.text, intakeController.text,
            selectedInChargeId, descriptionController.text, selectedMeals.join(", "));
      }
    }

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
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText.bold(AppTags.add + AppTags.space + AppTags.hostel, size: 18.sp),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close, color: Colors.black, size: 24))
                        ],
                      ),
                      gap(10.sp),
                      CustomTextField(
                        hintText: AppTags.hostelName,
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return '${AppTags.hostelName} cannot be empty';
                          }
                          return null;
                        },
                        onSave: (value) {
                          nameController.text = value as String;
                        },
                      ),
                      gap(10.sp),
                      Card(
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        color: colorWhite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: DropdownButton(
                            hint: const CommonText('Type...', size: 14, color: Colors.black54),
                            value: selectedType,
                            icon: const Card(
                              elevation: 0.1,
                              color: colorWhite,
                              child: Icon(Icons.keyboard_arrow_down_outlined),
                            ),
                            underline: const SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                selectedType = null;
                                selectedType = value.toString();
                              });
                            },
                            isExpanded: true,
                            items: typeList.map((cd) {
                              return DropdownMenuItem(
                                value: cd,
                                onTap: () {
                                  setState(() {
                                    selectedType = cd;
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
                      gap(10.sp), //
                      CustomTextField(
                        hintText: AppTags.hostelAddress,
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return '${AppTags.hostelAddress} cannot be empty';
                          }
                          return null;
                        },
                        onSave: (value) {
                          addressController.text = value as String;
                        },
                      ),
                      gap(10.sp),
                      CustomTextField(
                        hintText: AppTags.hostelIntake,
                        controller: intakeController,
                        keyboardType: TextInputType.number,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return '${AppTags.hostelIntake} cannot be empty';
                          }
                          return null;
                        },
                        onSave: (value) {
                          intakeController.text = value as String;
                        },
                      ),
                      gap(10.sp),
                      Card(
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        color: colorWhite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: DropdownButton(
                            hint: const CommonText("In Charge....", size: 14, color: Colors.black54),
                            value: selectedInChargeName,
                            icon: const Card(
                              elevation: 0.1,
                              color: colorWhite,
                              child: Icon(Icons.keyboard_arrow_down_outlined),
                            ),
                            underline: const SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                selectedInChargeName = value.toString();
                              });
                            },
                            isExpanded: true,
                            items: inChargeList.map((cd) {
                              return DropdownMenuItem(
                                value: cd.name,
                                onTap: () {
                                  setState(() {
                                    selectedInChargeId = cd.employeeId.toString();
                                  });
                                },
                                child: Text(
                                  cd.id.toString() + AppTags.space + cd.name.toString(),
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
                      gap(10.sp),
                      CustomTextField(
                        hintText: AppTags.description,
                        controller: descriptionController,
                        keyboardType: TextInputType.text,
                        maxLines: 2,
                        onSave: (value) {
                          descriptionController.text = value as String;
                        },
                      ),
                      gap(10.sp),
                      Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: CommonText.medium(
                          'Meal Type',
                          size: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                      Wrap(
                        children: mealTypes.map((meal) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: selectedMeals.contains(meal),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedMeals.add(meal);
                                    } else {
                                      selectedMeals.remove(meal);
                                    }
                                  });
                                },
                              ),
                              Text(meal),
                            ],
                          );
                        }).toList(),
                      ),
                      gap(10.sp),
                      // Submit Button
                      CommonButton(
                        cornersRadius: 30,
                        text: AppTags.submit,
                        onPressed: () {
                          checkValidation(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  void _showBottomSheetForRooms(BuildContext mainCon) {
    final numberController = TextEditingController();
    final numberOfBedController = TextEditingController();
    final costOfBedControllerController = TextEditingController();
    final descriptionController = TextEditingController();
    String? selectedType;
    String? selectedTypeId;
    String? selectedHostelId;
    String? selectedHostel;
    List<Roomtypes> typeList = hostelRoomsData.data?.roomtypes ?? [];
    List<HostelsForRooms> hostelList = hostelRoomsData.data?.hostels ?? [];
    final List<String> period = ['Monthly', 'Annually'];
    String selectedPeriod = "Monthly";

    checkValidation(BuildContext context) async {
      if (numberController.text == "") {
        CommonFunctions.showWarningToast("Please enter ${AppTags.roomNumber}");
      } else if (selectedHostel == null || selectedHostelId == "") {
        CommonFunctions.showWarningToast("Please select hostel");
      } else if (selectedType == null || selectedType == "") {
        CommonFunctions.showWarningToast("Please select room type");
      } else if (numberOfBedController.text == "") {
        CommonFunctions.showWarningToast("Please enter ${AppTags.numberOfBed}");
      } else if (costOfBedControllerController.text == "") {
        CommonFunctions.showWarningToast("Please enter ${AppTags.costPerBed}");
      } else if (selectedPeriod == "") {
        CommonFunctions.showWarningToast("Please select at period");
      } else {
        await callApiSaveHostelRoom(numberController.text, selectedHostelId, selectedTypeId, numberOfBedController.text,costOfBedControllerController.text,
            selectedPeriod, descriptionController.text);
      }
    }

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
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText.bold(AppTags.add + AppTags.space + AppTags.hostel, size: 18.sp),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close, color: Colors.black, size: 24))
                        ],
                      ),
                      gap(10.sp),
                      CustomTextField(
                        hintText: AppTags.roomNumber,
                        controller: numberController,
                        keyboardType: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return '${AppTags.roomNumber} cannot be empty';
                          }
                          return null;
                        },
                        onSave: (value) {
                          numberController.text = value as String;
                        },
                      ),
                      gap(10.sp),
                      Card(
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        color: colorWhite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: DropdownButton(
                            hint: const CommonText(AppTags.hostel, size: 14, color: Colors.black54),
                            value: selectedHostel,
                            icon: const Card(
                              elevation: 0.1,
                              color: colorWhite,
                              child: Icon(Icons.keyboard_arrow_down_outlined),
                            ),
                            underline: const SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                selectedHostel = value.toString();
                              });
                            },
                            isExpanded: true,
                            items: hostelList.map((cd) {
                              return DropdownMenuItem(
                                value: cd.hostelName,
                                onTap: () {
                                  setState(() {
                                    selectedHostelId = cd.id.toString();
                                  });
                                },
                                child: Text(
                                  cd.hostelName.toString(),
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
                      gap(10.sp),
                      Card(
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        color: colorWhite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: DropdownButton(
                            hint: const CommonText(AppTags.roomTypeHint, size: 14, color: Colors.black54),
                            value: selectedType,
                            icon: const Card(
                              elevation: 0.1,
                              color: colorWhite,
                              child: Icon(Icons.keyboard_arrow_down_outlined),
                            ),
                            underline: const SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                selectedType = null;
                                selectedType = value.toString();
                              });
                            },
                            isExpanded: true,
                            items: typeList.map((cd) {
                              return DropdownMenuItem(
                                value: cd.roomType,
                                onTap: () {
                                  setState(() {
                                    selectedType = cd.roomType;
                                    selectedTypeId = cd.id.toString();
                                  });
                                },
                                child: Text(
                                  cd.roomType.toString(),
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
                      gap(10.sp),
                      CustomTextField(
                        hintText: AppTags.numberOfBed,
                        controller: numberOfBedController,
                        keyboardType: TextInputType.number,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return '${AppTags.numberOfBed} cannot be empty';
                          }
                          return null;
                        },
                        onSave: (value) {
                          numberOfBedController.text = value as String;
                        },
                      ),
                      gap(10.sp),
                      CustomTextField(
                        hintText: AppTags.costPerBed,
                        controller: costOfBedControllerController,
                        keyboardType: TextInputType.number,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return '${AppTags.costPerBed} cannot be empty';
                          }
                          return null;
                        },
                        onSave: (value) {
                          costOfBedControllerController.text = value as String;
                        },
                      ),
                      gap(10.sp),
                      Card(
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        color: colorWhite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: DropdownButton(
                            hint: const CommonText("Period....", size: 14, color: Colors.black54),
                            value: selectedPeriod,
                            icon: const Card(
                              elevation: 0.1,
                              color: colorWhite,
                              child: Icon(Icons.keyboard_arrow_down_outlined),
                            ),
                            underline: const SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                selectedPeriod = value.toString();
                              });
                            },
                            isExpanded: true,
                            items: period.map((cd) {
                              return DropdownMenuItem(
                                value: cd,
                                onTap: () {
                                  setState(() {
                                    selectedPeriod = cd.toString();
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
                      gap(10.sp),
                      CustomTextField(
                        hintText: AppTags.description,
                        controller: descriptionController,
                        keyboardType: TextInputType.text,
                        maxLines: 2,
                        onSave: (value) {
                          descriptionController.text = value as String;
                        },
                      ),
                      gap(10.sp),

                      // Submit Button
                      CommonButton(
                        cornersRadius: 30,
                        text: AppTags.submit,
                        onPressed: () {
                          checkValidation(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  String getStaffNameFromID(String id) {
    String name = "";
    hostelData.data!.staff?.forEach((action) {
      if (action.employeeId.toString() == id) {
        name = "$id ${action.name.toString()}";
      }
    });
    return name;
  }

  String getStaffNameFromIDForRooms(String id) {
    String name = "";
    hostelRoomsData.data!.staffs?.forEach((action) {
      if (action.employeeId.toString() == id) {
        name = "$id ${action.name.toString()}";
      }
    });
    return name;
  }
}

rowValue(String key, value) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SizedBox(width: 100.sp, child: CommonText.medium(key, size: 14.sp, color: Colors.black)),
    SizedBox(width: 20.w),
    Expanded(child: CommonText.medium(value, size: 14.sp, color: Colors.grey, overflow: TextOverflow.fade)),
  ]);
}
