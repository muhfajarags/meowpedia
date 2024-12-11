import 'package:flutter/material.dart';
import 'detail_info.dart';

class Home extends StatelessWidget {
  final List<Map<String, String>> catBreeds = [
    {
      'name': 'British Short Hair',
      'origin': 'Inggris',
      'image': 'assets/cat.png', // Update the image path as necessary
    },
    {
      'name': 'Persian',
      'origin': 'Iran',
      'image': 'assets/cat.png', // Update the image path as necessary
    },
    {
      'name': 'Siamese',
      'origin': 'Thailand',
      'image': 'assets/cat.png', // Update the image path as necessary
    },
    {
      'name': 'Maine Coon',
      'origin': 'Amerika Serikat',
      'image': 'assets/cat.png', // Update the image path as necessary
    },
    {
      'name': 'Ragdoll',
      'origin': 'Amerika Serikat',
      'image': 'assets/cat.png', // Update the image path as necessary
    },
    {
      'name': 'Bengal',
      'origin': 'Amerika Serikat',
      'image': 'assets/cat.png', // Update the image path as necessary
    },
    {
      'name': 'Sphynx',
      'origin': 'Kanada',
      'image': 'assets/cat.png', // Update the image path as necessary
    },
    {
      'name': 'Scottish Fold',
      'origin': 'Skotlandia',
      'image': 'assets/cat.png', // Update the image path as necessary
    },
    {
      'name': 'Norwegian Forest Cat',
      'origin': 'Norwegia',
      'image': 'assets/cat.png', // Update the image path as necessary
    },
  ];

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: const Text(
            'MEOWPEDIA',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF3669C9),
            ),
          ),
          centerTitle: true,
          toolbarHeight: 80.0,
          backgroundColor: Colors.white,
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.1),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search Cat Breeds',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFC4C5C4),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: const Color(0xFFF2F2F2),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 156 / 199,
                ),
                itemCount: catBreeds.length,
                itemBuilder: (context, index) {
                  final breed = catBreeds[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailInfo(
                            title: breed['name']!,
                            subtitle: breed['origin']!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFFE5E5E5), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.asset(
                              breed['image']!,
                              width: 130,
                              height: 130,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    breed['name']!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width: 17,
                                  height: 15,
                                  child: Image.asset(
                                    'assets/unlove.png',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                breed['origin']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF3669C9),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
