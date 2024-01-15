Item? firstWhereOrNull<Item, List extends Iterable<Item>>(
  List list,
  bool Function(Item element) callback,
) {
  try {
    final Item value = list.firstWhere(callback);

    return value;
  } catch (_) {
    return null;
  }
}
