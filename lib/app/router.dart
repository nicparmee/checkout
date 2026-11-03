import 'package:checkout/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:go_router/go_router.dart';

import '../features/catalog/presentation/pages/catalog_page.dart';
import '../features/checkout/presentation/pages/order_page.dart';
import '../features/checkout/presentation/pages/summary_page.dart';

final router = GoRouter(
  initialLocation: '/catalog',
  onException: (_, _, router) => router.go('/catalog'),
  routes: [
    GoRoute(path: '/', redirect: (_, _) => '/catalog'),
    GoRoute(path: '/catalog', builder: (_, _) => const CatalogPage()),
    GoRoute(path: '/summary', builder: (_, _) => const SummaryPage()),
    GoRoute(path: '/sign-in', builder: (_, _) => const SignInPage()),
    GoRoute(
      path: '/order/:orderId',
      builder: (_, state) =>
          OrderPage(orderId: state.pathParameters['orderId']!),
    ),
  ],
);
