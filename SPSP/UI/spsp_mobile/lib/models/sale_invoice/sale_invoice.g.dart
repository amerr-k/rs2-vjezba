// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleInvoice _$SaleInvoiceFromJson(Map<String, dynamic> json) => SaleInvoice(
      id: json['id'] as int?,
      invoiceNumber: json['invoiceNumber'] as String?,
      saleDate: json['saleDate'] == null
          ? null
          : DateTime.parse(json['saleDate'] as String),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      totalAmountWithVAT: (json['totalAmountWithVAT'] as num).toDouble(),
      vat: (json['vat'] as num?)?.toDouble(),
      valid: json['valid'] as bool?,
      processed: json['processed'] as bool?,
      paymentGatewayData: json['paymentGatewayData'] == null
          ? null
          : PaymentGatewayData.fromJson(
              json['paymentGatewayData'] as Map<String, dynamic>),
      paymentGatewayDataId: json['paymentGatewayDataId'] as int?,
      orderId: json['orderId'] as int?,
      saleInvoiceItems: (json['saleInvoiceItems'] as List<dynamic>)
          .map((e) => SaleInvoiceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pdfInvoice: json['pdfInvoice'] as String?,
    );

Map<String, dynamic> _$SaleInvoiceToJson(SaleInvoice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoiceNumber': instance.invoiceNumber,
      'saleDate': instance.saleDate?.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'totalAmountWithVAT': instance.totalAmountWithVAT,
      'vat': instance.vat,
      'valid': instance.valid,
      'processed': instance.processed,
      'paymentGatewayDataId': instance.paymentGatewayDataId,
      'paymentGatewayData': instance.paymentGatewayData,
      'orderId': instance.orderId,
      'saleInvoiceItems': instance.saleInvoiceItems,
      'pdfInvoice': instance.pdfInvoice,
    };
