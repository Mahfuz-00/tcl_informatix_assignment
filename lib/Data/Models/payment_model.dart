// --------------
// Payment and approval flow model
// --------------
import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Payment {
  final String paymentId;
  final int amount;
  final String requestedBy;
  final String requestDate;
  final List<Invoice> invoices;
  final ApprovalFlow approvalFlow;

  Payment({
    required this.paymentId,
    required this.amount,
    required this.requestedBy,
    required this.requestDate,
    required this.invoices,
    required this.approvalFlow,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Invoice {
  final String invoiceId;
  final String vendor;
  final int amount;

  Invoice({
    required this.invoiceId,
    required this.vendor,
    required this.amount,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}

@JsonSerializable()
class ApprovalFlow {
  final String approvedBy;
  final String approvedDate;
  final String status;

  ApprovalFlow({
    required this.approvedBy,
    required this.approvedDate,
    required this.status,
  });

  factory ApprovalFlow.fromJson(Map<String, dynamic> json) => _$ApprovalFlowFromJson(json);
  Map<String, dynamic> toJson() => _$ApprovalFlowToJson(this);
}