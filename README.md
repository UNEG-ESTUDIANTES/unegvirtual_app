# Setup

## Requirements

-   Access to [UNEG Virtual API](https://github.com/UNEG-ESTUDIANTES/unegvirtual-api).
-   Install [Flutter](https://docs.flutter.dev/get-started/install).
-   Install [Flutter Version Management](https://fvm.app/docs/getting_started/installation).

## Run the project

1. Run `fvm install`.
2. Create an `.env` file containing the values based on `.env.example`.
3. Run `fvm flutter pub get` to install the dependencies.
4. Run `fvm dart run build_runner build --delete-conflicting-outputs` to generate files.
5. Run `fvm flutter run`.

## Test

-   Run `fvm flutter test`.
