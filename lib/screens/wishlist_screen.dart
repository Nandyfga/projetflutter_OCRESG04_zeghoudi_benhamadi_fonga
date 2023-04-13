import 'package:flutter/material.dart';

const primaryColor = Color(0xFF1A2025);

class Wishlist extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ma page d\'application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Ma liste de souhaits'),
          backgroundColor: primaryColor,
        ),
        body: Container(
          color: Color(0xff1A2025),
          child: Center(
              child:
              Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Center (

                    child : Image.asset(
                      'images/wishlist.png',
                    ),

                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text("Vous n’avez encore pas liké de contenu.\n\n"
                      "Cliquez sur l'étoile pour en rajouter.",textAlign: TextAlign.center,
                    style : TextStyle(
                      color: Colors.white,
                      fontFamily: "Proxima Nova",
                      fontSize: 15.27,
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}