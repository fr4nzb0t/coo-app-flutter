import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'models/asset.dart';
import 'screens/browse_screen.dart';
import 'screens/detail_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const CoownableApp());
}

class CoownableApp extends StatelessWidget {
  const CoownableApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Coownable',
      theme: AppTheme.lightTheme(),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return _AppShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const BrowseScreen(),
        ),
        GoRoute(
          path: '/asset/:id',
          builder: (context, state) {
            final asset = state.extra as Asset;
            return DetailScreen(asset: asset);
          },
        ),
        GoRoute(
          path: '/portfolio',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Portfolio'),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Profile'),
        ),
      ],
    ),
  ],
);

class _AppShell extends StatefulWidget {
  final Widget child;

  const _AppShell({required this.child});

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  int _selectedIndex = 0;

  static const List<String> _routes = ['/', '/portfolio', '/profile'];

  void _onDestinationSelected(int index) {
    setState(() => _selectedIndex = index);
    GoRouter.of(context).go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Browse',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Portfolio',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
