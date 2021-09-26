import 'package:flutter/material.dart';
import 'package:google_auth_demo/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            //
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('${authProvider.userModel.picture}'),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text("${authProvider.userModel.name}"),
            SizedBox(
              height: 15,
            ),
            Text("${authProvider.userModel.email}")
          ],
        ),
      ),
    );
  }
}
