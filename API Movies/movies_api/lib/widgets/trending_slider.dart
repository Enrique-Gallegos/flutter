import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_api/details_screen.dart';
import 'package:movies_api/models/movie.dart';
import 'package:movies_api/widgets/constants.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({
    super.key,
    required this.snapshot,
    required this.onFavoriteToggle,
    required this.isFavorite,
  });

  final AsyncSnapshot snapshot;
  final Function(Movie)
      onFavoriteToggle; // Asegúrate de incluir este parámetro.
  final bool Function(Movie) isFavorite;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data!.length,
        options: CarouselOptions(
          height: 300,
          autoPlay: true,
          viewportFraction: 0.55,
          enlargeCenterPage: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          pageSnapping: true,
          autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          final movie = snapshot.data![itemIndex];
          final isFav = isFavorite(movie);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(movie: movie),
                ),
              );
            },
            child: Stack(
              children: [
                Hero(
                  tag: 'movie_${movie.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: 300,
                      width: 200,
                      child: Image.network(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        '${Constants.imagePath}${movie.posterPath}',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.white,
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
