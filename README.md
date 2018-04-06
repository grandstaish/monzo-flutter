# Monzo-Flutter

An unofficial Android/iOS client for [Monzo][monzo] built using Flutter.

## Credentials
In order to build this project, you will need to create:

* A [non-confidential Monzo client][monzo-client].

Then, create a `client.properties` file in the `android/` directory that defines the following properties:

```properties
redirect.scheme=https
redirect.host=yourhost.com
redirect.path=-magic-link
```

You'll also need to add a `keys.dart` file to the `lib/` directory of this project.
This file contains the oauth client id, client secret, and redirect URL necessary to communicate with the Monzo APIs.
Inside the file you'll need to define three constants:
```dart
const String CLIENT_ID = 'your oauth client id';
const String CLIENT_SECRET = 'your oauth client secret';
const String REDIRECT_URL = 'https://yourhost.com/-magic-link';
```

[monzo]: https://monzo.com/
[monzo-client]: https://developers.monzo.com/
