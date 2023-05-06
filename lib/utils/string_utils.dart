class StringUtils {
  static String formattedMoney(int expense) {
    final formated = expense.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');

    return formated;
  }
}
