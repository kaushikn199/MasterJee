class CommunicationLogs {
  String? status;
  String? message;
  List<Data>? data;
  bool? result;

  CommunicationLogs({this.status, this.message, this.data, this.result});

  CommunicationLogs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['result'] = result;
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? templateId;
  dynamic emailTemplateId;
  String? smsTemplateId;
  String? sendThrough;
  String? message;
  String? sendMail;
  String? sendSms;
  String? isGroup;
  String? isIndividual;
  String? isClass;
  String? isSchedule;
  dynamic sent;
  dynamic scheduleDateTime;
  String? groupList;
  String? userList;
  String? scheduleClass;
  String? scheduleSection;
  String? createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.title,
        this.templateId,
        this.emailTemplateId,
        this.smsTemplateId,
        this.sendThrough,
        this.message,
        this.sendMail,
        this.sendSms,
        this.isGroup,
        this.isIndividual,
        this.isClass,
        this.isSchedule,
        this.sent,
        this.scheduleDateTime,
        this.groupList,
        this.userList,
        this.scheduleClass,
        this.scheduleSection,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    templateId = json['template_id'];
    emailTemplateId = json['email_template_id'];
    smsTemplateId = json['sms_template_id'];
    sendThrough = json['send_through'];
    message = json['message'];
    sendMail = json['send_mail'];
    sendSms = json['send_sms'];
    isGroup = json['is_group'];
    isIndividual = json['is_individual'];
    isClass = json['is_class'];
    isSchedule = json['is_schedule'];
    sent = json['sent'];
    scheduleDateTime = json['schedule_date_time'];
    groupList = json['group_list'];
    userList = json['user_list'];
    scheduleClass = json['schedule_class'];
    scheduleSection = json['schedule_section'];
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['template_id'] = templateId;
    data['email_template_id'] = emailTemplateId;
    data['sms_template_id'] = smsTemplateId;
    data['send_through'] = sendThrough;
    data['message'] = message;
    data['send_mail'] = sendMail;
    data['send_sms'] = sendSms;
    data['is_group'] = isGroup;
    data['is_individual'] = isIndividual;
    data['is_class'] = isClass;
    data['is_schedule'] = isSchedule;
    data['sent'] = sent;
    data['schedule_date_time'] = scheduleDateTime;
    data['group_list'] = groupList;
    data['user_list'] = userList;
    data['schedule_class'] = scheduleClass;
    data['schedule_section'] = scheduleSection;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}


class NoticeLogs {
  String? status;
  String? message;
  List<NoticeData>? data;
  bool? result;

  NoticeLogs({this.status, this.message, this.data, this.result});

  NoticeLogs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NoticeData>[];
      json['data'].forEach((v) {
        data!.add(new NoticeData.fromJson(v));
      });
    }
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['result'] = result;
    return data;
  }
}

class NoticeData {
  String? id;
  String? title;
  String? publishDate;
  String? date;
  String? attachment;
  String? message;
  String? visibleStudent;
  String? visibleStaff;
  String? visibleParent;
  String? createdBy;
  String? createdId;
  String? isActive;
  String? createdAt;
  dynamic updatedAt;

  NoticeData(
      {this.id,
        this.title,
        this.publishDate,
        this.date,
        this.attachment,
        this.message,
        this.visibleStudent,
        this.visibleStaff,
        this.visibleParent,
        this.createdBy,
        this.createdId,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  NoticeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    publishDate = json['publish_date'];
    date = json['date'];
    attachment = json['attachment'];
    message = json['message'];
    visibleStudent = json['visible_student'];
    visibleStaff = json['visible_staff'];
    visibleParent = json['visible_parent'];
    createdBy = json['created_by'];
    createdId = json['created_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['publish_date'] = publishDate;
    data['date'] = date;
    data['attachment'] = attachment;
    data['message'] = message;
    data['visible_student'] = visibleStudent;
    data['visible_staff'] = visibleStaff;
    data['visible_parent'] = visibleParent;
    data['created_by'] = createdBy;
    data['created_id'] = createdId;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
