import 'package:flutter/material.dart';

class CompanyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: BorderSide.strokeAlignCenter,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('EK APPZONE'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Company Logo
              Image.asset(
                'assets/images/logo.png', // Replace with your logo image path
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 20),
              const Text(
                  "This App is related To knitting production calculations. "),
              const Text(
                  "Let us know your custom requirements we will build app on your requests"),
              // Contact Details
              const Text(
                'Contact Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text('Address: Nawalapitiya 20650'),
              const Text('Phone: +94782694957'),
              const Text('Website: www.ekappzone.com'),
              const SizedBox(height: 20),
              // Styled Email
              const Text(
                'Email: ekappzone@gmail.com',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),
              RichText(
                text: const TextSpan(
                  text: 'info@', // Prefix text
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: 'ekappzone.com', // Email domain
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
