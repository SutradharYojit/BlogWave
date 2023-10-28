import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({
    super.key,
    required this.imgUrl,       // The URL of the image to be loaded
    required this.errorWidget,   // Widget to display in case of loading error
  });

  final String imgUrl;        // URL of the image to be loaded
  final Widget errorWidget;   // Widget to display in case of loading error

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(       // Use CachedNetworkImage to load and cache the network image
      imageUrl: imgUrl,              // Provide the image URL
      fit: BoxFit.cover,             // Set the fit mode for the image
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(value: downloadProgress.progress),  // Show a progress indicator while loading
      ),
      errorWidget: (context, url, error) => errorWidget,  // Display the specified error widget on loading error
    );
  }
}

