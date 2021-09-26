import 'package:flutter/material.dart';
import 'package:google_auth_demo/UI/home_page.dart';
import 'package:google_auth_demo/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider provider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: provider.isSignIn
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: TextButton(
                  onPressed: () {
                    Future.microtask(() => provider.signInGoogle());
                    if (provider.loadingUser == false) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => HomePage()));
                    }
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        
                        content: Text(
                          "User Value is Null",
                        ),
                      ),
                    );
                  },
                  child: Text("Sign In with GoogleF")),
            ),
    );
  }
}
