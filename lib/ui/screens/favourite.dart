import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meowpedia/core/utils/search.dart';
import '../widgets/cat_card.dart';
import '../widgets/search_field.dart';
import '../../providers/cat_provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    final catProvider = Provider.of<CatProvider>(context, listen: false);
    catProvider.fetchLovedCats();
  }

  @override
  Widget build(BuildContext context) {
    final catProvider = Provider.of<CatProvider>(context);
    final filteredCats = filterDataByQuery(
      data: catProvider.lovedCats,
      query: searchQuery,
      key: 'name',
    );

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
      body: catProvider.lovedCats.isEmpty
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
                    InputField(
                      hintText: 'Search Cat Breeds',
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
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
                              final isLoved = catProvider.isLoved(cat['no']);

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
