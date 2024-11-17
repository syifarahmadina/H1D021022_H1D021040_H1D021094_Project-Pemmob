import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int id; // Receiving the id of the selected item

  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulating a list of kos to fetch data from
    final List<Map<String, dynamic>> _kosList = [
      {
        'id': 1,
        'imageUrl': 'https://via.placeholder.com/150',
        'namaKos': 'Wisma Damai 1',
        'hargaKos': 'Rp 4.500.000 / tahun',
        'facilities': ['AC', 'Kasur', 'Lemari', 'Kamar Mandi Luar'],
        'isFavourite': false,
      },
      {
        'id': 2,
        'imageUrl': 'https://via.placeholder.com/150',
        'namaKos': 'Wisma Damai 2',
        'hargaKos': 'Rp 7.500.000 / tahun',
        'facilities': ['Kasur', 'Lemari', 'Kamar Mandi Dalam'],
        'isFavourite': true,
      },
      {
        'id': 3,
        'imageUrl': 'https://via.placeholder.com/150',
        'namaKos': 'RKP',
        'hargaKos': 'Rp 400.000 / bulan',
        'facilities': ['AC', 'Kasur', 'Kamar Mandi Luar'],
        'isFavourite': false,
      },
    ];

    // Find the item by id
    final kos = _kosList.firstWhere((kos) => kos['id'] == id);

    return Scaffold(
      appBar: AppBar(
        title: Text(kos['namaKos']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Image.network(kos['imageUrl']),
            const SizedBox(height: 16),
            // Name
            Text(
              kos['namaKos'],
              style: Theme.of(context).textTheme.headlineSmall, // Updated
            ),
            const SizedBox(height: 8),
            // Price
            Text(
              kos['hargaKos'],
              style: Theme.of(context).textTheme.bodyLarge, // Updated
            ),
            const SizedBox(height: 16),
            // Facilities
            Text(
              'Facilities:',
              style: Theme.of(context).textTheme.bodyLarge, // Updated
            ),
            const SizedBox(height: 8),
            Text(kos['facilities'].join(', ')),
            const SizedBox(height: 16),
            // Favourite status
            Text(
              'Favourite: ${kos['isFavourite'] ? 'Yes' : 'No'}',
              style: Theme.of(context).textTheme.bodyLarge, // Updated
            ),
          ],
        ),
      ),
    );
  }
}
