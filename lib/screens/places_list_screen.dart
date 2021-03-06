import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: const Center(child: Text('No places yet. Add some!')),
                builder: (context, greatPlaces, child) => greatPlaces
                        .places.isEmpty
                    ? child!
                    : ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(greatPlaces.places[index].image)),
                          title: Text(greatPlaces.places[index].title),
                          subtitle: Text(greatPlaces
                              .places[index].location!.address as String),
                          onTap: () {
                            // go to details page...
                          },
                        ),
                        itemCount: greatPlaces.places.length,
                      ),
              ),
      ),
    );
  }
}
