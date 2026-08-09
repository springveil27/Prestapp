import 'dart:io';
import 'package:flutter/material.dart';

class ImagenArticulo extends StatelessWidget {
  final String? rutaImagen;
  final double width;
  final double height;
  final double borderRadius;
  final BoxFit fit;

  const ImagenArticulo({
    super.key,
    required this.rutaImagen,
    required this.width,
    required this.height,
    this.borderRadius = 12,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    Widget placeholder() => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: radius,
          ),
          child: Icon(
            Icons.image_not_supported,
            color: Colors.grey[400],
          ),
        );

    if (rutaImagen == null || rutaImagen!.isEmpty) {
      return placeholder();
    }

    final file = File(rutaImagen!);
    if (!file.existsSync()) {
      return placeholder();
    }

    return ClipRRect(
      borderRadius: radius,
      child: Image.file(
        file,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => placeholder(),
      ),
    );
  }
}
