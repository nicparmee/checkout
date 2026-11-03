# SOLUTION

Adhering to the brief and best practises for flutter this application follows:

Domain driven design principles, treating the domain layer as the source of truth to govern the rest of the system.

This application improves on the DDD principle by incorporating a clean architecture pattern, to separate the layers of the project, and keep the different layers modular and not intertwined. This provides for a well structured system that can easily adapt to any changes to models in the system and allows for an easily scalable system. 


The folder structure that is used to emphasize the system design:

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

Typed models are generated with [graphql_codegen](https://pub.dev/packages/graphql_codegen) from `schema.graphql` and the `.graphql` operation files, so GraphQL code generation keeps the data layer type-safe:

```
dart run build_runner build   # one-off
dart run build_runner watch   # regenerate on change
```

## State management

The state management is Bloc ([flutter_bloc](https://pub.dev/packages/flutter_bloc)).

Domain driven architecture - the domain layer defines the application

Clean architecture pattern distincally separating the ui from the functionality, as well as the components so any component can be swapped out or updated without needing to be replaced all over the application


## Payment Process

As the payment process is the most critical process in the application extra redundancy has been put in place to prevent any failure or critical errors on the users experience.

1st:
-   The payments button immediatly changes state once clicked to unclickable to prevent double clicking.

2nd
- Bloc is used for the state management for the order page and droppable is applied to the processing of payment, so only one event can be fired off at a time. So until it receives a response the user cannot click the button again

3rd
- To prevent both 1 and 2 being ignored by the user refreshing the page. The order page first fetches the payment state based on the order Id before displaying a "clickable" pay button based on the orders payment state.

4th
- Finally for a completely robust payment feature an Idempotency key is used which is sent to the backend/payment* system on payment so that they can track that a payment has been initiated with that ID and another can't be initiated while that key is being used.


## Trade offs

One trade-off was choosing to empty the cart as soon as the user clicks "Pay". If the user leaves the page before the payment state has finished updating, this could cause some confusion, since their cart will already be empty. However, I felt this was the better option, as it avoids leaving items in the cart that may have already been paid for. But on a UX this is not a perfect solution as if the payment fails and the user goes back to restart the order their cart will be empty. Due to time limitations I thought this execution would surfice for the assignment.


## AI Usage

AI was used on this project - claude was used opus 5.5 was used in conjecture for coding and ideating. Other AI's and general internet sources were used for research purposes.

Two prompts used with AI and the process that followed

- The user needs to be logged in to place the order, this is going to be a simple process in this app lets add a cubit to authentication which says if the user is logged in or out - it does not need to survive a refresh and every sign in attempt will be successful so build a simple sign in page that always works and updates the users sign in state.

(Was further worked on and updated to keep this data preserved with localStorage)

--------------------------------


Setting up the catalog page (boiler plate code)

- Ok so lets talk about the catalog page we should have the item I have identified (image, item name and description) pulled from graphql and shown on the page. Lets set that up

(Noticed files weren't in the correct folder - followed up with)

- Why didin't you put catalog_cubit in the bloc folder? 
(To get it's reasoning and to update based on this)

[Ideally I would of setup an Agend.md file for structure etc on a larger project]