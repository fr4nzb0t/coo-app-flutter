class Asset {
  final String id;
  final String name;
  final String category;
  final int totalPriceNok;
  final int pricePerShareNok;
  final int totalShares;
  final int availableShares;
  final int coOwners;
  final String artist;
  final String imageUrl;
  final String description;
  final String medium;
  final String dimensions;
  final int year;

  const Asset({
    required this.id,
    required this.name,
    required this.category,
    required this.totalPriceNok,
    required this.pricePerShareNok,
    required this.totalShares,
    required this.availableShares,
    required this.coOwners,
    required this.artist,
    required this.imageUrl,
    required this.description,
    required this.medium,
    required this.dimensions,
    required this.year,
  });

  double get availabilityRatio => availableShares / totalShares;

  int get takenShares => totalShares - availableShares;

  /// Format price in Norwegian style: 25 000 NOK
  static String formatNok(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    final startIndex = str.length % 3;
    if (startIndex > 0) {
      buffer.write(str.substring(0, startIndex));
    }
    for (int i = startIndex; i < str.length; i += 3) {
      if (buffer.isNotEmpty) buffer.write('\u2009'); // thin space
      buffer.write(str.substring(i, i + 3));
    }
    return '${buffer.toString()} NOK';
  }

  String get formattedTotalPrice => formatNok(totalPriceNok);
  String get formattedPricePerShare => formatNok(pricePerShareNok);
}
