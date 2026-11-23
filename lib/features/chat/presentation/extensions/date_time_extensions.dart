/// Форматирование [DateTime] для отображения в UI.
extension DateTimeFormatting on DateTime {
  /// Возвращает время в формате ЧЧ:ММ.
  String get formattedTime =>
      '${hour.toString().padLeft(2, '0')}:'
      '${minute.toString().padLeft(2, '0')}';
}
