# Monzo-Flutter

An unofficial Android/iOS client for [Monzo][monzo] built using Flutter.

## Credentials
In order to build this project, you will need to create:

* A [non-confidential Monzo client][monzo-client].

Then, create a `keys.dart` file to the `lib/` directory of this project.
This file contains your oauth client id and client secret necessary to communicate with the Monzo APIs.
Inside the file you'll need to define two constants:
```dart
const String CLIENT_ID = 'your oauth client id';
const String CLIENT_SECRET = 'your oauth client secret';
```

[monzo]: https://monzo.com/
[monzo-client]: https://developers.monzo.com/
