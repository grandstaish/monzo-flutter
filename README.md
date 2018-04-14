# Monzo-Flutter

An unofficial Android/iOS client for [Monzo][monzo] built using Flutter.

## Building
In order to build this project, you will need to create a [non-confidential Monzo client][monzo-client].

Then, create a `keys.dart` file to the `lib/` directory of this project.
This file contains your oauth client id and client secret necessary to communicate with the Monzo APIs.
Inside the file you'll need to define two constants:
```dart
const String CLIENT_ID = 'your oauth client id';
const String CLIENT_SECRET = 'your oauth client secret';
```

You'll also want to add the following environment variables:
```
export FLUTTER_ROOT=`pwd`/Sources/flutter
export PATH=$PATH:$FLUTTER_ROOT/bin
export PATH=$PATH:$FLUTTER_ROOT/bin/cache/dart-sdk/bin
```

Finally, run the following command to auto-generate code on the fly:
```
pub run build_runner watch
```

[monzo]: https://monzo.com/
[monzo-client]: https://developers.monzo.com/
