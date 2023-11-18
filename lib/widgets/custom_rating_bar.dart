import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatefulWidget {
  final double initialValue;
  final void Function(double) ratingFunction;

  const CustomRatingBar({
    super.key, required this.initialValue, required this.ratingFunction,
  });

  @override
  State<CustomRatingBar> createState() => _CustomRatingBarState();


}
class _CustomRatingBarState extends State<CustomRatingBar> {
  double rating = 0.0;

  @override
  void initState() {
    super.initState();
    // Define o valor inicial com base no valor passado para o widget
    rating = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RatingBar(
        minRating: 0,
        maxRating: 5,
        initialRating: rating,
        allowHalfRating: true,
        onRatingUpdate: widget.ratingFunction,
        updateOnDrag: true,
        ratingWidget: RatingWidget(
          full: Icon(
            Icons.star,
            color: Theme.of(context).colorScheme.primary,
          ),
          empty: const Icon(
            Icons.star,
            color: Colors.grey,
          ),
          half: Icon(
            Icons.star_half,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

}
