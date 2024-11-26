import 'package:flutter/material.dart';

class DetailInfo extends StatelessWidget {
  final String title;
  final String subtitle;

  const DetailInfo({
    super.key, 
    required this.title, 
    required this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold, // Menjadikan teks pada AppBar bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF3669C9),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center( // Menggunakan Center untuk memusatkan Card
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9, // Mengatur lebar Card menjadi 90% dari layar
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Mengatur latar belakang menjadi putih
                border: Border.all(color: const Color(0xFFE5E5E5), width: 2), // Menambahkan border dalam 2px berwarna E5E5E5
                borderRadius: BorderRadius.circular(8), // Menambahkan sudut yang membulat
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Mengatur agar teks dalam Card align kiri
                children: [
                  AspectRatio(
                    aspectRatio: 1, // Mengatur agar tinggi sama dengan lebar
                    child: Image.asset(
                      'assets/cat.png',
                      width: double.infinity, // Mengatur lebar gambar agar mengikuti lebar Container
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Mengatur agar teks tetap align kiri
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0), // Menambahkan padding left 15px
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0), // Menambahkan padding left 15px
                          child: Text(
                            subtitle,
                            style: const TextStyle(
                              fontSize: 18, // Mengubah ukuran font menjadi 18px
                              fontWeight: FontWeight.bold, // Menjadikan teks bold
                              color: Colors.grey, // Anda bisa mengubah warna sesuai kebutuhan
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0), // Menambahkan padding left 15px
                          child: Text("Hasil / Keaslian: Alami"),
                        ),
                        const SizedBox(height: 4),
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0), // Menambahkan padding left 15px
                          child: Text("Body type: Cobby"),
                        ),
                        const SizedBox(height: 4),
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0), // Menambahkan padding left 15px
                          child: Text("Panjang Bulu: Short"),
                        ),
                        const SizedBox(height: 4),
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0), // Menambahkan padding left 15px
                          child: Text("Warna: Solid"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}