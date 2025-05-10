import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  void _navigateTo(BuildContext context, Widget page) {
    setState(() => _isDrawerOpen = false);
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Drawer with Fade-In'),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: _toggleDrawer,
            ),
          ),
          body: const Center(child: Text('Home Page')),
        ),

        AnimatedOpacity(
          opacity: _isDrawerOpen ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child:
              _isDrawerOpen
                  ? GestureDetector(
                    onTap: _toggleDrawer,
                    child: Container(color: Colors.black54),
                  )
                  : const SizedBox.shrink(),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: 0,
          bottom: 0,
          left: _isDrawerOpen ? 0 : -250,
          child: AnimatedOpacity(
            opacity: _isDrawerOpen ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Material(
              elevation: 8,
              child: Container(
                width: 250,
                color: Colors.white,
                child: Column(
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/bue.png',
                          ), // bue logo for header
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Bue Menu",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.home),
                            title: const Text("Home"),
                            onTap: () => _navigateTo(context, const HomePage()),
                          ),
                          ListTile(
                            leading: const Icon(Icons.settings),
                            title: const Text("Settings"),
                            onTap:
                                () =>
                                    _navigateTo(context, const SettingsPage()),
                          ),
                          ListTile(
                            leading: const Icon(Icons.info),
                            title: const Text("About Us"),
                            onTap:
                                () => _navigateTo(context, const AboutPage()),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.logout, color: Colors.red),
                        label: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.red),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          minimumSize: const Size.fromHeight(40),
                        ),
                        onPressed: () {
                          setState(() => _isDrawerOpen = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Logged out")),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: const Center(child: Text("Settings Page")),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Us")),
      body: const Center(child: Text("About Us Page")),
    );
  }
}
