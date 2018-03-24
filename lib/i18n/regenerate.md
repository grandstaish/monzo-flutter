## Regenerating the i18n files

The files in this directory are based on ../lib/strings.dart which defines all of the localizable
strings used by the Monzo app. The Monzo app uses the
[Dart `intl` package](https://github.com/dart-lang/intl).

Rebuilding everything requires two steps.

With the project root as the current directory, generate `intl_messages.arb` from
`lib/strings.dart`:

```
flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/i18n lib/strings.dart
```

This file can be used to create a translation for each supported language using tools such as
[Google Translator Toolkit](https://translate.google.com/toolkit/). Name the translation files in
the format `monzo_<locale>.arb`.

Next generate a `monzo_messages_<locale>.dart` for each `monzo_<locale>.arb` file and
`monzo_messages_all.dart`, which imports all of the messages files:

```
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n \
   --generated-file-prefix=monzo_ --no-use-deferred-loading lib/*.dart lib/i18n/monzo_*.arb
```

The `Strings` class uses the generated `initializeMessages()` function (`monzo_messages_all.dart`)
to load the localized messages and `Intl.message()` to look them up.
