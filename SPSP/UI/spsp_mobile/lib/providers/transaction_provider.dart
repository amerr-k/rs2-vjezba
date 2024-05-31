import 'package:flutter/material.dart';
import 'package:spsp_mobile/models/paypal/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> transactions = [];
  bool _isPaymentProcessed = false;

  void setTransactions(List<Transaction> newTransactions) {
    transactions = newTransactions;
    notifyListeners();
  }

  void setIsPaymentProcessed(bool isPaymentProcessed) {
    _isPaymentProcessed = isPaymentProcessed;
    notifyListeners();
  }
}
