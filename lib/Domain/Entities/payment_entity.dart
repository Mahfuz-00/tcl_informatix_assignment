// --------------
// Payment entity
// --------------

class PaymentEntity {
  final String paymentId;
  final int amount;
  final String requestedBy;
  final String requestDate;
  final List<InvoiceEntity> invoices;
  final ApprovalEntity approvalFlow;

  PaymentEntity({
    required this.paymentId,
    required this.amount,
    required this.requestedBy,
    required this.requestDate,
    required this.invoices,
    required this.approvalFlow,
  });
}

// --------------
// Invoice entity
// --------------
class InvoiceEntity {
  final String invoiceId;
  final String vendor;
  final int amount;

  InvoiceEntity({
    required this.invoiceId,
    required this.vendor,
    required this.amount,
  });
}


// --------------
// Approval entity
// --------------
class ApprovalEntity {
  final String approvedBy;
  final String approvedDate;
  final String status;

  ApprovalEntity({
    required this.approvedBy,
    required this.approvedDate,
    required this.status,
  });
}