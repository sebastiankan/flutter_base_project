import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, this.urlString, this.size = const Size(56, 56)})
      : super(key: key);
  final String? urlString;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        width: size.width,
        height: size.height,
        fit: BoxFit.cover,
        imageUrl: urlString ??
            "https://lh3.googleusercontent.com/ogw/ADea4I4JoeYqWkwciBxESvUGXnlYxSE3nr_fEqX3w_qGWA=s192-c-mo",
        placeholder: (context, url) => CircularProgressIndicator(strokeWidth: 2.5,),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
