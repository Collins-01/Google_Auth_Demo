import 'package:flutter/foundation.dart';
import 'package:google_auth_demo/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class AuthProvider extends ChangeNotifier {
  UserModel? _userModel;
  UserModel get userModel => _userModel!;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  fb.FirebaseAuth _firebaseAuth = fb.FirebaseAuth.instance;
  bool _isSignIn = false;
  bool get isSignIn => _isSignIn;
  bool _loadingUser = true;
  bool get loadingUser => _loadingUser;

  signInGoogle() async {
    // var credentials=await GoogleSignInAcco
    try {
      _isSignIn = true;
      notifyListeners();
      await _googleSignIn.signOut();
      GoogleSignInAccount? _signInAccount = await _googleSignIn.signIn();

      GoogleSignInAuthentication _signInAuthentication =
          await _signInAccount!.authentication;

      final fb.AuthCredential credential = fb.GoogleAuthProvider.credential(
        idToken: _signInAuthentication.idToken,
        accessToken: _signInAuthentication.accessToken,
      );

      fb.UserCredential result =
          await _firebaseAuth.signInWithCredential(credential);

      if (result.user != null) {
        _loadingUser = false;
        _userModel = UserModel(
          email: result.user!.email,
          name: result.user!.displayName,
          picture: result.user!.photoURL,
        );
      }
      _loadingUser = true;
      _isSignIn = false;
      notifyListeners();
    } catch (e) {
      print("Error------$e");
      _isSignIn = false;
      notifyListeners();
    }
  }
}
