# checkout

assignment: checkout experience. built with flutter for web

## Running the app

Requires the Flutter SDK (Dart `^3.13.7`). Check your setup with `flutter doctor`.

```sh
flutter pub get
flutter run -d chrome
```

No backend is needed. GraphQL requests are answered in-app by `lib/graphql/local_link.dart`, and orders and sign-in are saved in browser storage so they survive a refresh.

## Trying the flow

1. Add services from the catalog, then open the cart.
2. Pick an appointment slot and place the order. You'll be asked to sign in first; any email and password work (can be blank as well).
3. On the order page, choose a saved card and pay within 2 minutes, before the order expires.
   - **Visa •••• 4242** succeeds.
   - **Mastercard •••• 0002** is declined, so you can test the retry path.

## Tests

```sh
flutter test
```

## Regenerating GraphQL code

The generated `*.graphql.dart` files are committed. Only regenerate after changing a `.graphql` file:

```sh
dart run build_runner build --delete-conflicting-outputs
```
