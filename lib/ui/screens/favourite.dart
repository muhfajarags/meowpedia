import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  String searchQuery = '';
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child("favourites");
  List<Map<String, dynamic>> lovedCats = [];
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchLovedCats();
  }

  Future<void> _fetchLovedCats() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final snapshot = await _databaseReference.child(user.uid).get();
      if (snapshot.exists) {
        final data = snapshot.value as List<dynamic>;
        setState(() {
          lovedCats = data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
          errorMessage = null;
        });
      } else {
        setState(() {
          lovedCats = [];
          errorMessage = "No favourites found.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching favourites: $e';
      });
      print('Error fetching favourites: $e');
    }
  }

  Future<void> _toggleLove(Map<String, dynamic> cat) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      setState(() {
        if (lovedCats.any((item) => item['no'] == cat['no'])) {
          lovedCats.removeWhere((item) => item['no'] == cat['no']);
        } else {
          lovedCats.add(cat);
        }
      });
      await _databaseReference.child(user.uid).set(lovedCats);
    } catch (e) {
      print('Error toggling love state: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredCats = lovedCats
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
            'FAVOURITE',
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
      body: lovedCats.isEmpty && errorMessage != null
          ? Center(
              child: Text(
                errorMessage!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            )
          : lovedCats.isEmpty
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
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 156 / 199,
                                ),
                                itemCount: filteredCats.length,
                                itemBuilder: (context, index) {
                                  final cat = filteredCats[index];
                                  final isLoved = lovedCats
                                      .any((item) => item['no'] == cat['no']);

                                  return GestureDetector(
                                    onTap: () => _toggleLove(cat),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFFE5E5E5),
                                            width: 2),
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
