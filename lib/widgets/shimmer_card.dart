import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_theme.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      child: Shimmer.fromColors(
        baseColor: AppColors.shimmerBase,
        highlightColor: AppColors.shimmerHighlight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder — 4:3 ratio
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.shimmerBase,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category overline
                  _shimmerBox(width: 80, height: 12),
                  const SizedBox(height: 8),
                  // Title
                  _shimmerBox(width: double.infinity, height: 20),
                  const SizedBox(height: 6),
                  _shimmerBox(width: 160, height: 20),
                  const SizedBox(height: 10),
                  // Price
                  _shimmerBox(width: 120, height: 15),
                  const SizedBox(height: 14),
                  // Availability bar
                  _shimmerBox(width: double.infinity, height: 4),
                  const SizedBox(height: 8),
                  // Shares caption
                  _shimmerBox(width: 140, height: 12),
                  const SizedBox(height: 4),
                  // Co-owners caption
                  _shimmerBox(width: 180, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.shimmerBase,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
