List<Map<String, dynamic>> filterDataByQuery({
  required List<Map<String, dynamic>> data,
  required String query,
  required String key,
}) {
  if (query.isEmpty) return data;

  return data
      .where((item) =>
          item[key]?.toString().toLowerCase().contains(query.toLowerCase()) ??
          false)
      .toList();
}
