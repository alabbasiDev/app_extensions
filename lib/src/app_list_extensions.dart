
extension ListExtension<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  List<T>? reverseIf(bool condition) {
    return condition ? this?.reversed.toList() : this;
  }

  List<List<T>>? splitListIntoLists(int chunkSize) {
    if (isNullOrEmpty) {
      return null;
    }

    List<List<T>> chunks = [];
    List<T> list = this!;
    for (var i = 0; i < list.length; i += chunkSize) {
      int end = (i + chunkSize < list.length) ? i + chunkSize : list.length;
      chunks.add(list.sublist(i, end));
    }

    return chunks;
  }
}

extension FirstWhereExt<T> on List<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNULL(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
