import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final lovedCats = Provider.of<CatProvider>(context).lovedCats;
    final filteredCats = lovedCats
        .where((cat) => cat['name']
        .toLowerCase()
        .contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: const Text(
            'FAVOURITE', // Changed title here
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
      body: lovedCats.isEmpty
          ? const Center(
        child: Text(
          'No favourites yet.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search bar
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
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
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 16),
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
              filteredCats.isEmpty
                  ? const Center(
                child: Text(
                  "We couldn't find any results. Try a different search.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              )
                  : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 156 / 199, // Adjust this as needed
                ),
                itemCount: filteredCats.length, // Number of cards
                itemBuilder: (context, index) {
                  final cat = filteredCats[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFFE5E5E5), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // Cat image
                          Image.asset(
                            cat['image'], // Replace with your asset path
                            width: 130,
                            height: 130,
                          ),
                          const SizedBox(height: 8),
                          // Title and Icon Row
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  cat['name'],
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
                                  'assets/loved.png', // Changed to loved.png
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          // Subtitle
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              cat['origin'],
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
