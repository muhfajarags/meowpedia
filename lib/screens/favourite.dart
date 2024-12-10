import 'package:flutter/material.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search bar
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
              // Grid of cards
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 156 / 199, // Adjust this as needed
                ),
                itemCount: 2, // Number of cards
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFFE5E5E5), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // Cat image
                          Image.asset(
                            'assets/cat.png', // Replace with your asset path
                            width: 130,
                            height: 130,
                          ),
                          const SizedBox(height: 8),
                          // Title and Icon Row
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'British Short Hair',
                                  style: TextStyle(
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
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Inggris',
                              style: TextStyle(
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
