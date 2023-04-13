import 'package:flutter/material.dart';


const primaryColor = Color(0xFF1A2025);

class MesLikes extends StatelessWidget {
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
          title: Text('Mes likes'),
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
                      'images/like.png',
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text("Vous n’avez encore pas liké de contenu.\n\n"
                      "Cliquez sur le coeur pour en rajouter.",textAlign: TextAlign.center,
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