// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
  paymentId: json['paymentId'] as String,
  amount: (json['amount'] as num).toInt(),
  requestedBy: json['requestedBy'] as String,
  requestDate: json['requestDate'] as String,
  invoices: (json['invoices'] as List<dynamic>)
      .map((e) => Invoice.fromJson(e as Map<String, dynamic>))
      .toList(),
  approvalFlow: ApprovalFlow.fromJson(
    json['approvalFlow'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
  'paymentId': instance.paymentId,
  'amount': instance.amount,
  'requestedBy': instance.requestedBy,
  'requestDate': instance.requestDate,
  'invoices': instance.invoices.map((e) => e.toJson()).toList(),
  'approvalFlow': instance.approvalFlow.toJson(),
};

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
  invoiceId: json['invoiceId'] as String,
  vendor: json['vendor'] as String,
  amount: (json['amount'] as num).toInt(),
);

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
  'invoiceId': instance.invoiceId,
  'vendor': instance.vendor,
  'amount': instance.amount,
};

ApprovalFlow _$ApprovalFlowFromJson(Map<String, dynamic> json) => ApprovalFlow(
  approvedBy: json['approvedBy'] as String,
  approvedDate: json['approvedDate'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$ApprovalFlowToJson(ApprovalFlow instance) =>
    <String, dynamic>{
      'approvedBy': instance.approvedBy,
      'approvedDate': instance.approvedDate,
      'status': instance.status,
    };
