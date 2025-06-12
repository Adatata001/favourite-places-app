import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpapp/providers/user_places.dart';
import 'package:fpapp/screens/add_place.dart';
import 'package:fpapp/widgets/places_list.dart';


class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState () => _PlacesScreenState();
}



class _PlacesScreenState extends ConsumerState<PlacesScreen> {

  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(context) {
   final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => AddPlaceScreen(),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot)
            =>snapshot.connectionState == ConnectionState.waiting 
            ? Center(
              child: CircularProgressIndicator(),
            )
            : PlacesList(
                places: userPlaces,
              ),
          ),
        ),
      );
    }
}