import 'package:flutter/material.dart';
import '../data/mock_assets.dart';
import '../models/asset.dart';
import '../widgets/asset_card.dart';
import '../widgets/shimmer_card.dart';
import 'package:go_router/go_router.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  bool _isLoading = true;
  List<Asset> _assets = const [];

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() {
        _assets = mockAssets;
        _isLoading = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() {
        _assets = mockAssets;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;
            final crossAxisCount = isTablet ? 2 : 1;

            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  title: const Text('Browse'),
                  centerTitle: false,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: _isLoading
                      ? SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: isTablet ? 0.72 : 0.68,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => const ShimmerCard(),
                            childCount: 4,
                          ),
                        )
                      : SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: isTablet ? 0.72 : 0.68,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final asset = _assets[index];
                              return AssetCard(
                                asset: asset,
                                onTap: () => context.push(
                                  '/asset/${asset.id}',
                                  extra: asset,
                                ),
                              );
                            },
                            childCount: _assets.length,
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
