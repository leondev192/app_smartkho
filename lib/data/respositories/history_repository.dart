// repositories/history_repository.dart

import 'package:app_smartkho/data/models/transaction_model.dart';
import 'package:app_smartkho/data/services/history_service.dart';

class HistoryRepository {
  final HistoryService _historyService = HistoryService();

  Future<List<TransactionModel>?> getTransactions() async {
    return await _historyService.fetchTransactions();
  }
}
