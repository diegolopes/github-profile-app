import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart'; // <-- Add this import
import 'services/github_service.dart';
import 'pages/profile_page.dart';
import 'pages/history_page.dart';
import 'pages/about_page.dart';
import 'models/github_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pesquisa de usuários do Github',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final GithubService _githubService = GithubService();
  bool _isLoading = false;
  final List<GithubUser> _history = []; // Use GithubUser type

  Future<void> _searchUser({String? username}) async {
    final userToSearch = username ?? _controller.text.trim();
    if (userToSearch.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _githubService.fetchUser(userToSearch);
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        // Remove any previous entry for this user
        _history.removeWhere((u) => u.login == user.login);
        _history.insert(0, user); // Store the user object
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(user: user),
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisa - Github'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero, // <-- Remove default margin
              padding: EdgeInsets.zero, // <-- Remove default padding
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1488590528505-98d2b5aba04b',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(16.0), // Optional: add padding only to the text
                      child: Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black54,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Histórico'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryPage(
                      history: _history,
                      onSelect: (username) {
                        _controller.text = username;
                        _searchUser(username: username);
                      },
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sair'),
              onTap: () {
                Navigator.pop(context);
                SystemNavigator.pop(); // <-- Exit the app
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FaIcon(
              FontAwesomeIcons.github,
              size: 80,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                    hintText: 'ex: octocat',
                    hintStyle: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    ),
                  labelText: 'Digite o nome do usuário',

                ),
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                    onPressed: _searchUser,
                    icon: const Icon(Icons.search),
                    label: const Text('Pesquisar'),
                  ),
          ],
        ),
      ),
    );
  }
}

