import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../models/asset.dart';
import '../theme/app_theme.dart';
import '../widgets/availability_bar.dart';

class DetailScreen extends StatefulWidget {
  final Asset asset;

  const DetailScreen({super.key, required this.asset});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final List<Animation<double>> _sectionFades;

  // Number of staggered content sections
  static const int _sectionCount = 5;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _sectionFades = List.generate(_sectionCount, (i) {
      final start = i * 0.15;
      final end = (start + 0.4).clamp(0.0, 1.0);
      return CurvedAnimation(
        parent: _fadeController,
        curve: Interval(start, end, curve: Curves.easeOut),
      );
    });

    // Delay for hero animation to settle
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asset = widget.asset;
    final screenHeight = MediaQuery.of(context).size.height;
    final expandedHeight = screenHeight * 0.56;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero SliverAppBar
          SliverAppBar(
            expandedHeight: expandedHeight,
            pinned: true,
            backgroundColor: AppColors.surface,
            surfaceTintColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: _BackButton(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'asset-image-${asset.id}',
                child: CachedNetworkImage(
                  imageUrl: asset.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.shimmerBase,
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.shimmerBase,
                    child: const Icon(Icons.broken_image,
                        color: AppColors.textTertiary, size: 48),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section 0: Category + name + artist
                  _FadeSection(
                    animation: _sectionFades[0],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          asset.category.toUpperCase(),
                          style: tt.labelLarge,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          asset.name,
                          style: tt.displayLarge,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'by ${asset.artist}',
                          style: tt.bodySmall,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Section 1: Price
                  _FadeSection(
                    animation: _sectionFades[1],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          asset.formattedPricePerShare,
                          style: tt.displayMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Total value: ${asset.formattedTotalPrice}',
                          style: tt.bodySmall,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Section 2: Availability
                  _FadeSection(
                    animation: _sectionFades[2],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Availability',
                          style: tt.headlineMedium,
                        ),
                        const SizedBox(height: 12),
                        AvailabilityBar(
                          ratio: asset.availabilityRatio,
                          mode: AvailabilityBarMode.detail,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${asset.availableShares} of ${asset.totalShares} shares available',
                          style: tt.labelMedium?.copyWith(
                              color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${asset.coOwners} co-owners',
                          style: tt.labelSmall,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Section 3: Description
                  _FadeSection(
                    animation: _sectionFades[3],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: tt.headlineMedium,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          asset.description,
                          style: tt.bodyLarge,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Section 4: Details
                  _FadeSection(
                    animation: _sectionFades[4],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Details',
                          style: tt.headlineMedium,
                        ),
                        const SizedBox(height: 12),
                        _DetailRow(label: 'Medium', value: asset.medium),
                        const Divider(
                            color: AppColors.divider, height: 1, thickness: 1),
                        _DetailRow(
                            label: 'Dimensions', value: asset.dimensions),
                        const Divider(
                            color: AppColors.divider, height: 1, thickness: 1),
                        _DetailRow(
                            label: 'Year', value: asset.year.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.85),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => context.pop(),
        padding: EdgeInsets.zero,
        iconSize: 22,
      ),
    );
  }
}

class _FadeSection extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _FadeSection({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: tt.bodyMedium?.copyWith(color: AppColors.textSecondary)),
          Text(value, style: tt.bodyMedium),
        ],
      ),
    );
  }
}
