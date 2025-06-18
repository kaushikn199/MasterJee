class PaySlipResponse {
  final String? status;
  final String? message;
  final List<PaySlipData>? data;
  final bool? result;

  PaySlipResponse({
    this.status,
    this.message,
    this.data,
    this.result,
  });

  factory PaySlipResponse.fromJson(Map<String, dynamic> json) {
    return PaySlipResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PaySlipData.fromJson(e))
          .toList(),
      result: json['result'] as bool?,
    );
  }
}

class PaySlipData {
  final String? id;
  final String? staffId;
  final String? basic;
  final String? totalAllowance;
  final String? totalDeduction;
  final String? leaveDeduction;
  final String? tax;
  final String? netSalary;
  final String? status;
  final String? month;
  final String? year;
  final String? paymentMode;
  final String? linkedLedgerBank;
  final String? bankName;
  final String? transactionId;
  final String? paymentDate;
  final String? remark;
  final String? generatedBy;
  final String? createdAt;
  final String? paymentModes;

  PaySlipData({
    this.id,
    this.staffId,
    this.basic,
    this.totalAllowance,
    this.totalDeduction,
    this.leaveDeduction,
    this.tax,
    this.netSalary,
    this.status,
    this.month,
    this.year,
    this.paymentMode,
    this.linkedLedgerBank,
    this.bankName,
    this.transactionId,
    this.paymentDate,
    this.remark,
    this.generatedBy,
    this.createdAt,
    this.paymentModes,
  });

  factory PaySlipData.fromJson(Map<String, dynamic> json) {
    return PaySlipData(
      id: json['id'] as String?,
      staffId: json['staff_id'] as String?,
      basic: json['basic'] as String?,
      totalAllowance: json['total_allowance'] as String?,
      totalDeduction: json['total_deduction'] as String?,
      leaveDeduction: json['leave_deduction'] as String?,
      tax: json['tax'] as String?,
      netSalary: json['net_salary'] as String?,
      status: json['status'] as String?,
      month: json['month'] as String?,
      year: json['year'] as String?,
      paymentMode: json['payment_mode'] as String?,
      linkedLedgerBank: json['linked_ledger_bank'] as String?,
      bankName: json['bank_name'] as String?,
      transactionId: json['transaction_id'] as String?,
      paymentDate: json['payment_date'] as String?,
      remark: json['remark'] as String?,
      generatedBy: json['generated_by'] as String?,
      createdAt: json['created_at'] as String?,
      paymentModes: json['payment_modes'] as String?,
    );
  }
}
