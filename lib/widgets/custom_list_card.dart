import 'package:flutter/material.dart';

class CustomListCard extends StatelessWidget {
  final String imageUrl;
  final String namaKos;
  final String hargaKos;
  final List<String> facilities;
  final VoidCallback onFavouriteToggle;
  final bool isFavourite;

  const CustomListCard({
    Key? key,
    required this.imageUrl,
    required this.namaKos,
    required this.hargaKos,
    required this.facilities,
    required this.onFavouriteToggle,
    required this.isFavourite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image as card header
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name of the kos and favorite icon in the same row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      namaKos,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: isFavourite ? Colors.red : Colors.grey,
                      ),
                      onPressed: onFavouriteToggle,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Price of the kos
                Text(
                  hargaKos,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),
                // Facilities chips
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: facilities
                      .map(
                        (facility) => Chip(
                      label: Text(facility),
                      backgroundColor: Colors.grey[200],
                    ),
                  )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
