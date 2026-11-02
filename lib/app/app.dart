import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/authentication/presentation/bloc/auth_cubit.dart';
import '../features/cart/presentation/bloc/cart_cubit.dart';
import '../graphql/local_link.dart';
import 'router.dart';

class App extends StatelessWidget {
  const App({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => GraphQLClient(link: LocalLink(), cache: GraphQLCache()),
      // Above the router so app-wide state outlives page navigation.
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider(create: (_) => AuthCubit(prefs)),
        ],
        child: MaterialApp.router(
          title: 'Checkout',
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          ),
          routerConfig: router,
        ),
      ),
    );
  }
}
