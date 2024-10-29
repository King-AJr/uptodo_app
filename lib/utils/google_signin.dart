import 'package:google_sign_in/google_sign_in.dart';

Future<Map<String, dynamic>?> googleSignIn() async {
  // Initialize GoogleSignIn with the scopes you want:
  print('called google sign in');
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  var googleUser = await googleSignIn.signIn();

  if (googleUser != null) {
    final userInfo = {
      'id': googleUser.id,
      'email': googleUser.email,
      'name': googleUser.displayName,
      'photoUrl': googleUser.photoUrl,
    };

    return userInfo;
  }

  return null;
}
