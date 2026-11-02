# checkout

assignment: checkout experience. built with flutter for web


This application follows a clean architecture pattern with domain driven design principles using a folder structure of:

```
lib/
├── app/                         app widget, router, dependency setup
├── graphql/
│   ├── schema.graphql           GraphQL schema (the contract every query is checked against)
│   └── local_link.dart          in-app data source that resolves GraphQL operations (no backend)
├── shared/                      widgets and layout used across features
└── features/
    └── <feature>/               e.g. catalog, cart, checkout, authentication
        ├── domain/
        │   ├── entities/        plain Dart business objects (e.g. Product)
        │   └── repositories/    abstract repository interfaces
        ├── data/
        │   ├── models/          GraphQL operations (.graphql) and their generated models
        │   ├── datasources/     talk to the GraphQL client, return generated models
        │   └── repositories/    implement domain repositories, map models → entities
        └── presentation/
            ├── bloc/            cubits/blocs and their states
            ├── pages/           routed screens
            └── widget/          feature-specific widgets
```

### Dependency rule

`presentation` and `data` both depend on `domain`; `domain` depends on neither.

```
presentation ──► domain ◄── data
```

- Cubits depend only on the abstract repository and entities, never on `data/` or GraphQL types.
- Nothing outside `data/` imports a `*.graphql.dart` file.
- Pages wire the concrete pieces together, e.g.
  `CatalogCubit(CatalogRepositoryImpl(CatalogRemoteDataSource(client)))`.

## Data

Data is kept local to the repo. Each feature's GraphQL operations live in its `data/models/` folder, and are resolved in-app by `LocalLink` against in-memory data.
Swapping `LocalLink` for an `HttpLink` would point the app at a real server without changing any feature code.

Typed models are generated with [graphql_codegen](https://pub.dev/packages/graphql_codegen) from `schema.graphql` and the `.graphql` operation files:

```
dart run build_runner build   # one-off
dart run build_runner watch   # regenerate on change
```

## State management

The state management is Bloc ([flutter_bloc](https://pub.dev/packages/flutter_bloc)).