Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  // Simulasi operasi yang lama
  return "Data dari internet";
}

void main() async {
  print("Mulai");
  String data = await fetchData();
  // Menunggu fetchData() selesai
  print(data); // Output: Data dari internet
  print("Selesai");
}