import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meowpedia/core/utils/firebase_utils.dart';
import 'package:meowpedia/core/utils/search.dart';
import '../../providers/cat_provider.dart';
import '../widgets/cat_card.dart';
import '../widgets/search_field.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchQuery = '';
  List<Map<String, dynamic>> cats = [];
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCats();

    listenAuthStateChanges((user) {
      if (user == null) {
        setState(() {
          cats.clear(); 
        });
      } else {
        Provider.of<CatProvider>(context, listen: false).fetchLovedCats();
      }
    });
  }

  Future<void> _fetchCats() async {
    try {
      final data = await readData('kucing');
      if (data != null) {
        setState(() {
          cats = List<Map<String, dynamic>>.from(
              data.map((e) => Map<String, dynamic>.from(e)));
          errorMessage = null;
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
    final filteredCats = filterDataByQuery(
      data: cats,
      query: searchQuery,
      key: 'name',
    );

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
              InputField(
                hintText: 'Search Cat Breeds',
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
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

                    return CatCard(
                      cat: cat,
                      isLoved: isLoved,
                      onFavoriteToggle: () {
                        if (isLoved) {
                          catProvider.removeLovedCat(cat);
                        } else {
                          catProvider.addLovedCat(cat);
                        }
                      },
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
