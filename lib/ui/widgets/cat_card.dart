import 'package:flutter/material.dart';

class CatCard extends StatelessWidget {
  final Map<String, dynamic> cat;
  final bool isLoved;
  final VoidCallback onFavoriteToggle;

  const CatCard({
    super.key,
    required this.cat,
    required this.isLoved,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFavoriteToggle,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
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
                    isLoved ? Icons.favorite : Icons.favorite_border,
                    color: isLoved ? Colors.red : Colors.grey,
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
  }
}
