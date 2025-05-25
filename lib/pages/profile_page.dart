import 'package:flutter/material.dart';
import '../models/github_user.dart';

class ProfilePage extends StatelessWidget {
  final GithubUser user;

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GitHub Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            const SizedBox(height: 16),
            Text(
              user.name.isNotEmpty ? user.name : user.login,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '@${user.login}',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 12),
            if (user.bio.isNotEmpty)
              Text(
                user.bio,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatColumn(label: 'Repos', value: user.publicRepos),
                _StatColumn(label: 'Followers', value: user.followers),
                _StatColumn(label: 'Following', value: user.following),
              ],
            ),
            const SizedBox(height: 24),
            if (user.location.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, size: 18),
                  const SizedBox(width: 4),
                  Text(user.location),
                ],
              ),
            if (user.blog.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: InkWell(
                  onTap: () {
                    // Optionally, use url_launcher to open the blog link
                  },
                  child: Text(
                    user.blog,
                    style: const TextStyle(
                        color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final int value;

  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$value', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}