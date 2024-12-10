import "package:flutter/material.dart";
import "package:movies_api/details_screen.dart";
import "package:movies_api/models/movie.dart";
import "package:movies_api/widgets/constants.dart";

class MovieSlider extends StatelessWidget {
  const MovieSlider({
    super.key,
    required this.snapshot,
    required this.onFavoriteToggle,
    required this.isFavorite,
  });

  final AsyncSnapshot snapshot;
  final Function(Movie) onFavoriteToggle;
  final bool Function(Movie) isFavorite;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final movie = snapshot.data![index];
          final favorite = isFavorite(movie);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(movie: movie),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'movie_${movie.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 200,
                        width: 150,
                        child: Image.network(
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          '${Constants.imagePath}${movie.posterPath}',
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                      color: favorite ? Colors.red : Colors.white,
                    ),
                    onPressed: () => onFavoriteToggle(movie),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
