import 'package:intl/intl.dart';
import '../interfaces/formatting_service.dart';

class FormattingService implements IFormattingService {
  final NumberFormat _formatter = NumberFormat('#,###', 'es_CO');

  @override
  String formatPrice(int price) {
    return '\$${_formatter.format(price)} COP';
  }

  @override
  String formatCurrency(double amount) {
    return '\$${_formatter.format(amount.round())} COP';
  }
}