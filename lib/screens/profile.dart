import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: const Text(
            'PROFILE',  // Changed title here
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF3669C9),
            ),
          ),
          centerTitle: true,
          toolbarHeight: 80.0,
          backgroundColor: Colors.white,
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Center the image button horizontally
            Center(
              child: Stack(
                alignment: Alignment.bottomRight, // Align the icon to the bottom right
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40), // Corner radius
                    child: Material(
                      elevation: 5, // Optional: Adds a shadow effect
                      child: InkWell(
                        onTap: () {
                          // Handle button press
                          print('Image button pressed!');
                        },
                        child: Container(
                          width: 200, // Width of the button
                          height: 200, // Height of the button
                          child: Image.asset(
                            'assets/pp.jpg', // Image source
                            fit: BoxFit.cover, // Cover the button area
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Pencil icon
                  Container(
                    margin: const EdgeInsets.all(8.0), // Margin for spacing
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.7), // Background color
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit, // Pencil icon
                        color: Colors.white, // Icon color
                      ),
                      onPressed: () {
                        // Handle icon press
                        print('Edit button pressed!');
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), // Space between image and text
            const Center( // Center the text horizontally
              child: Text(
                'Muhammad Fajar Agus Saputra', // Title
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4), // Space between title and subtitle
            const Center( // Center the subtitle horizontally
              child: Text(
                'muhfajarags@gmail.com', // Subtitle
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey, // Subtitle color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}