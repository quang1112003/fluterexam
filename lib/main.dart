import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Destination {
  final String title;
  final String imageUrl;

  Destination({required this.title, required this.imageUrl});
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0; // Current selected index, initially set to 0

  final List<Destination> destinations = [
    Destination(title: 'Hoi An', imageUrl: 'assets/hoian.jpg'),
    Destination(title: 'Sapa', imageUrl: 'assets/sapa.jpg'),
    Destination(title: 'Sai Gon', imageUrl: 'assets/saigon.jpg'),
    Destination(title: 'Ha Long', imageUrl: 'assets/halong.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 180,
          backgroundColor: Colors.purple,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi guys!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Where are you going next',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search), // Search icon on the left
                            SizedBox(width: 8), // Add some space between icon and text
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RectangleIconContainer(
                      icon: Icons.hotel,
                      backgroundColor: Colors.orange.shade50,
                      label: 'Hotel',
                    ),
                    RectangleIconContainer(
                      icon: Icons.flight,
                      backgroundColor: Colors.red.shade100,
                      label: 'Flight',
                    ),
                    RectangleIconContainer(
                      icon: Icons.all_inclusive,
                      backgroundColor: Colors.green.shade100,
                      label: 'All',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Popular Destinations',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 400,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: destinations.length,
                  itemBuilder: (context, index) {
                    return DestinationItem(
                      destination: destinations[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, // Set the current index
          selectedItemColor: Colors.purple, // Selected item color
          items: [
            // Define the bottom navigation bar items
            BottomNavigationBarItem(
              icon: Icon(Icons.home), // Home icon
              label: 'Home', // Label for Home
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search), // Search icon
              label: 'Search', // Label for Search
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business), // Case icon
              label: 'Case', // Label for Case
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person), // Person icon
              label: 'Person', // Label for Person
            ),
          ],
          onTap: (index) {
            // Handle item taps to change the current index
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class RectangleIconContainer extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final String label;

  RectangleIconContainer({
    required this.icon,
    required this.backgroundColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor;

    // Set the icon color based on the backgroundColor
    if (backgroundColor == Colors.orange.shade50) {
      iconColor = Colors.orange;
    } else if (backgroundColor == Colors.red.shade100) {
      iconColor = Colors.red;
    } else if (backgroundColor == Colors.green.shade100) {
      iconColor = Colors.green;
    } else {
      iconColor = Colors.white;
    }

    return Column(
      children: [
        Container(
          width: 100,
          height: 80,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Icon(
              icon,
              color: iconColor, // Use the calculated icon color
              size: 28,
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class DestinationItem extends StatelessWidget {
  final Destination destination;

  DestinationItem({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(destination.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          Positioned(
            left: 8,
            bottom: 40,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '4.0',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
