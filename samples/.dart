import 'dart:async';
import 'package:http/http.dart' as http;

const Duration delay = const Duration(milliseconds: 200);

// This function doesn't use async / await; just the
// standard Future API
Future loadLastName(String firstName) {
  return new Future.delayed(delay).then((_) {
    return firstName + 'son';
  });
}

// Marking a function with 'async' will return a future
// that completes with the returned value.
// This function is equivalent to [loadLastName]
Future loadLastName2(String firstName) async {
  await new Future.delayed(delay);

  return firstName + 'son';
}

main() async {
  // 'await' will suspend execution of the function until the
  // future completes:
  var gregsLastName = await loadLastName('greg');
  var stevesLastName = await loadLastName2('steve');

  print('greg $gregsLastName');
  print('steve $stevesLastName');
}