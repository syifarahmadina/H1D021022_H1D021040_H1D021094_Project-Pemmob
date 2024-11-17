import 'package:flutter/material.dart';
import 'package:techkost/widgets/custom_list_card.dart';
import 'detail_screen.dart'; // Import the DetailScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _kosList = [
    {
      'id': 1, // Add unique id
      'imageUrl': 'https://via.placeholder.com/150',
      'namaKos': 'Wisma Damai 1',
      'hargaKos': 'Rp 4.500.000 / tahun',
      'facilities': ['AC', 'Kasur', 'Lemari', 'Meja Belajar', 'Kamar Mandi Dalam'],
      'isFavourite': false,
    },
    {
      'id': 2, // Add unique id
      'imageUrl': 'https://via.placeholder.com/150',
      'namaKos': 'Wisma Damai 2',
      'hargaKos': 'Rp 7.500.000 / tahun',
      'facilities': ['Kasur', 'Lemari', 'Meja Belajar','Kamar Mandi Dalam'],
      'isFavourite': true,
    },
    {
      'id': 3, // Add unique id
      'imageUrl': 'https://via.placeholder.com/150',
      'namaKos': 'RKP',
      'hargaKos': 'Rp 400.000 / bulan',
      'facilities': ['AC', 'Kasur', 'Kamar Mandi Luar'],
      'isFavourite': false,
    },
  ];

  String _searchQuery = '';
  String _selectedFacility = 'All';
  String _selectedPriceFilter = 'Harga: Terendah ke Tinggi';
  final List<String> _availableFacilities = [
    'All',
    'AC',
    'Kasur',
    'Meja Belajar',
    'Lemari',
    'Kamar Mandi Dalam',
    'Kamar Mandi Luar',
  ];

  final List<String> _priceFilters = [
    'Harga: Terendah ke Tinggi',
    'Harga: Tertinggi ke Terendah',
  ];

  void _toggleFavourite(int index) {
    setState(() {
      _kosList[index]['isFavourite'] = !_kosList[index]['isFavourite'];
    });
  }

  List<Map<String, dynamic>> _getFilteredKosList() {
    // Filter kos list by search and selected facilities
    List<Map<String, dynamic>> filteredList = _kosList.where((kos) {
      final matchesSearch = kos['namaKos']
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      final matchesFacilities = _selectedFacility == 'All' ||
          kos['facilities'].contains(_selectedFacility);
      return matchesSearch && matchesFacilities;
    }).toList();

    // Apply price sorting
    if (_selectedPriceFilter == 'Harga: Terendah ke Tinggi') {
      filteredList.sort((a, b) {
        final priceA = int.parse(a['hargaKos'].replaceAll(RegExp(r'[^0-9]'), ''));
        final priceB = int.parse(b['hargaKos'].replaceAll(RegExp(r'[^0-9]'), ''));
        return priceA.compareTo(priceB);
      });
    } else if (_selectedPriceFilter == 'Harga: Tertinggi ke Terendah') {
      filteredList.sort((a, b) {
        final priceA = int.parse(a['hargaKos'].replaceAll(RegExp(r'[^0-9]'), ''));
        final priceB = int.parse(b['hargaKos'].replaceAll(RegExp(r'[^0-9]'), ''));
        return priceB.compareTo(priceA);
      });
    }

    return filteredList;
  }

  // Function to open bottom sheet for filters
  void _openFilterModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Facility Filter
              DropdownButton<String>(
                value: _selectedFacility,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedFacility = newValue!;
                  });
                  Navigator.pop(context); // Close the modal after selection
                },
                items: _availableFacilities
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              // Price Filter
              DropdownButton<String>(
                value: _selectedPriceFilter,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPriceFilter = newValue!;
                  });
                  Navigator.pop(context); // Close the modal after selection
                },
                items: _priceFilters
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredKosList = _getFilteredKosList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent, // Vibrant color for appbar
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: _openFilterModal,
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Search Bar
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search by Name',
                      labelStyle: TextStyle(color: Colors.deepPurpleAccent),
                      prefixIcon: Icon(Icons.search, color: Colors.deepPurpleAccent),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0xFFF5F5F5), // Soft background color for search bar
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // Filter Button (opens the modal)
                IconButton(
                  icon: Icon(Icons.filter_alt),
                  onPressed: _openFilterModal,
                  color: Colors.deepPurpleAccent,
                ),
              ],
            ),
          ),
          const Divider(),
          // List of Kos
          Expanded(
            child: ListView.builder(
              itemCount: filteredKosList.length,
              itemBuilder: (context, index) {
                final kos = filteredKosList[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to DetailScreen with the item's id
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(id: kos['id']),
                      ),
                    );
                  },
                  child: CustomListCard(
                    imageUrl: kos['imageUrl'],
                    namaKos: kos['namaKos'],
                    hargaKos: kos['hargaKos'],
                    facilities: List<String>.from(kos['facilities']),
                    isFavourite: kos['isFavourite'],
                    onFavouriteToggle: () =>
                        _toggleFavourite(_kosList.indexOf(kos)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
