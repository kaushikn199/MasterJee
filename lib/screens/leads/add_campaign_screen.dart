import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/leads/add_camp_response.dart';
import 'package:masterjee/models/leads/campaign_leads_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/leads_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class AddCampaignScreen extends StatefulWidget {
  const AddCampaignScreen({super.key});

  static String routeName = 'addCampaignScreen';

  @override
  State<AddCampaignScreen> createState() => _AddCampaignScreenState();
}

class _AddCampaignScreenState extends State<AddCampaignScreen> {
  late var titleController = TextEditingController();
  late var descriptionController = TextEditingController();
  String? _selectedCamp;
  String? _selectedCampId;
  List<CampType> listCamp = [];
  var _isLoading = false;

  List<Promoter> listPromoter = [];
  String? _selectedPromoter;
  String? _selectedPromoterId;

  Future<void> callApiAddCampaign() async {
    try {
      AddCampResponse data = await Provider.of<LeadsApi>(context, listen: false)
          .addCampaign(StorageHelper.getStringData(StorageHelper.userIdKey));
      if (data.status == "success") {
        setState(() {
          listCamp = data.data.allCampType;
          listPromoter = data.data.allPromoters;
        });
        return;
      }
    } catch (error) {
      print("callApiLeadsList : $error");
    }
  }


  Future<void> callApiSaveCampaign(String ctId,   String cpId,) async {
    setState(() {
      _isLoading = true;
    });
    try {
      CampaignLeadsResponse data =
      await Provider.of<LeadsApi>(context, listen: false).saveCampaign(
          StorageHelper.getStringData(StorageHelper.userIdKey),
          ctId,
          cpId,
          titleController.text,
          descriptionController.text);
      if (data.status == "success") {
        setState(() {
          titleController.text = "";
          descriptionController.text = "";
          _isLoading = false;
          _selectedPromoter = null;
          _selectedPromoterId = null;
          _selectedCampId = null;
          _selectedCamp = null;
          CommonFunctions.showWarningToast(data.message);
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiCampaignLeads : $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    callApiAddCampaign();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.addCampaign),
      backgroundColor: colorGaryBG,
      bottomNavigationBar: CommonButton(
        cornersRadius: 10,
        text: AppTags.save,
        onPressed: () {
          if(_selectedCamp == null){
            CommonFunctions.showWarningToast("Please select campaign");
          }else if(_selectedCampId != null && _selectedCampId == "3" && (_selectedPromoter == null || _selectedPromoter == "")){
            CommonFunctions.showWarningToast("Please select promoters");
          }else if(titleController.text == ""){
            CommonFunctions.showWarningToast("Please enter title");
          }else if(descriptionController.text == ""){
            CommonFunctions.showWarningToast("Please enter description");
          }else {
            callApiSaveCampaign(_selectedCampId!,_selectedPromoterId ?? "");
          }
        },
      ).paddingOnly(
        bottom: 30,
        left: 20,
        right: 20,
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                            hint: const CommonText('Select camp type',
                                size: 14, color: Colors.black54),
                            value: _selectedCamp,
                            icon: const Card(
                              elevation: 0.1,
                              color: colorWhite,
                              child: Icon(Icons.keyboard_arrow_down_outlined),
                            ),
                            underline: const SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCamp = null;
                                _selectedCamp = value.toString();
                                _selectedPromoter = null;
                                _selectedPromoterId = null;
                              });
                            },
                            isExpanded: true,
                            items: listCamp.map((cd) {
                              return DropdownMenuItem(
                                value: cd.ctId,
                                onTap: () {
                                  setState(() {
                                    _selectedCamp = cd.ctTitle;
                                    for (int i = 0; i < listCamp.length; i++) {
                                      if (listCamp[i].ctId == cd.ctId) {
                                        _selectedCampId = listCamp[i].ctId;
                                        print("_selectedCampId : ${_selectedCampId} : ${_selectedCamp}");
                                        break;
                                      }
                                    }
                                  });
                                },
                                child: Text(
                                  cd.ctTitle.toString(),
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
                      (_selectedCampId != null && _selectedCampId == "3") ?
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
                            hint: const CommonText('Select Promoters',
                                size: 14, color: Colors.black54),
                            value: _selectedPromoter,
                            icon: const Card(
                              elevation: 0.1,
                              color: colorWhite,
                              child:
                              Icon(Icons.keyboard_arrow_down_outlined),
                            ),
                            underline: const SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                _selectedPromoter = null;
                                _selectedPromoter = value.toString();
                              });
                            },
                            isExpanded: true,
                            items: listPromoter.map((cd) {
                              return DropdownMenuItem(
                                value: cd.cpId,
                                onTap: () {
                                  setState(() {
                                    _selectedPromoter = cd.promoterName;
                                    for (int i = 0;
                                    i < listPromoter.length;
                                    i++) {
                                      if (listPromoter[i].cpId == cd.cpId) {
                                        _selectedPromoterId =
                                            listPromoter[i].cpId;
                                        break;
                                      }
                                    }
                                  });
                                },
                                child: Text(
                                  cd.promoterName.toString(),
                                  style: const TextStyle(
                                    color: colorBlack,
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                          : const SizedBox(),
                      gap(10.0),
                      CustomTextField(
                        hintText: 'Title',
                        isReadonly: false,
                        controller: titleController,
                        keyboardType: TextInputType.name,
                        onSave: (value) {
                          titleController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        hintText: 'Description',
                        isReadonly: false,
                        controller: descriptionController,
                        keyboardType: TextInputType.name,
                        onSave: (value) {
                          descriptionController.text = value as String;
                        },
                      ),
                      gap(30.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
