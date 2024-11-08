import 'package:app_smartkho/data/models/transaction_model.dart';
import 'package:app_smartkho/data/services/transaction_service.dart';

class TransactionRepository {
  final TransactionService _service = TransactionService();

  Future<List<TransactionModel>> getTransactions() async {
    final data = await _service.getAllTransactions();
    return data?.map((e) => TransactionModel.fromJson(e)).toList() ?? [];
  }
}
