import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/asset.dart';
import '../theme/app_theme.dart';
import 'availability_bar.dart';

class AssetCard extends StatefulWidget {
  final Asset asset;
  final VoidCallback onTap;

  const AssetCard({super.key, required this.asset, required this.onTap});

  @override
  State<AssetCard> createState() => _AssetCardState();
}

class _AssetCardState extends State<AssetCard> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails _) {
    setState(() => _scale = 0.98);
  }

  void _onTapUp(TapUpDetails _) {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => _scale = 1.0);
    });
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final asset = widget.asset;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero image — 4:3 ratio
              Hero(
                tag: 'asset-image-${asset.id}',
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: asset.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.shimmerBase,
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.shimmerBase,
                        child: const Icon(Icons.broken_image,
                            color: AppColors.textTertiary),
                      ),
                    ),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category overline
                    Text(
                      asset.category.toUpperCase(),
                      style: tt.labelLarge,
                    ),
                    const SizedBox(height: 4),
                    // Asset name
                    Text(
                      asset.name,
                      style: tt.headlineLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    // Price per share
                    Text(
                      asset.formattedPricePerShare,
                      style: tt.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    // Availability bar
                    AvailabilityBar(ratio: asset.availabilityRatio),
                    const SizedBox(height: 8),
                    // Shares caption
                    Text(
                      '${asset.availableShares} of ${asset.totalShares} shares available',
                      style: tt.labelMedium,
                    ),
                    const SizedBox(height: 2),
                    // Co-owners + total price
                    Text(
                      '${asset.coOwners} co-owners · ${asset.formattedTotalPrice} total',
                      style: tt.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
