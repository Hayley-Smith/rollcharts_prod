class Roll {
  final String rollId;
  final String result;
  final String rollName;
  final DateTime createdAt = DateTime.now();

  Roll({
    required this.rollId,
    required this.result,
    required this.rollName,
  });
}
