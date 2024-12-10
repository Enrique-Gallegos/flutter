import 'package:flutter/material.dart';
import 'package:movies_api/details_screen.dart';
import '../models/movie.dart';
import '../widgets/constants.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key, required this.favorites});
  final List<Movie> favorites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.transparent,
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet.'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final movie = favorites[index];
                return ListTile(
                  leading: Image.network(
                    '${Constants.imagePath}${movie.posterPath}',
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
