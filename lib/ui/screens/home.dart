import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../providers/cat_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchQuery = '';
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child("kucing");
  List<Map<String, dynamic>> cats = [];
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCats();

    // Listen for authentication changes and update UI accordingly
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        Provider.of<CatProvider>(context, listen: false).fetchLovedCats();
      } else {
        setState(() {
          cats.clear(); // Clear the UI state when logged out
        });
      }
    });
  }

  Future<void> _fetchCats() async {
    try {
      final snapshot = await _databaseReference.get();
      if (snapshot.exists) {
        final data = snapshot.value as List<dynamic>;
        setState(() {
          cats = data.map((e) => Map<String, dynamic>.from(e as Map<Object?, Object?>)).toList();
          errorMessage = null; // Clear error message if successful
        });
      } else {
        setState(() {
          errorMessage = "No data found.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching cats: $e';
      });
      print('Error fetching cats: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final catProvider = Provider.of<CatProvider>(context);
    final filteredCats = cats
        .where((cat) => cat['name']
            .toString()
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

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
              if (errorMessage != null)
                Center(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                )
              else if (filteredCats.isEmpty)
                const Center(
                  child: Text(
                    "We couldn't find any results. Try a different search.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                )
              else
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 156 / 199,
                  ),
                  itemCount: filteredCats.length,
                  itemBuilder: (context, index) {
                    final cat = filteredCats[index];
                    final isLoved = catProvider.lovedCats
                        .any((favCat) => favCat['no'] == cat['no']);

                    return GestureDetector(
                      onTap: () {
                        if (isLoved) {
                          catProvider.removeLovedCat(cat);
                        } else {
                          catProvider.addLovedCat(cat);
                        }
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
                              Image.network(
                                cat['image'],
                                width: 130,
                                height: 130,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 8),
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
                                  Icon(
                                    isLoved
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isLoved
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
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
