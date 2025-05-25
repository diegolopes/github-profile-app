import 'package:flutter/material.dart';
import '../models/github_user.dart';

class HistoryPage extends StatelessWidget {
  final List<GithubUser> history; // List of GithubUser objects
  final void Function(String username) onSelect;

  const HistoryPage({super.key, required this.history, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de pesquisa')),	
      body: history.isEmpty
          ? const Center(child: Text('Nenhum histórico ainda.'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final user = history[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                  title: Text(user.login),
                  subtitle: Text(user.bio.isNotEmpty ? user.bio : 'Sem descrição'),
                  onTap: () {
                    Navigator.pop(context);
                    onSelect(user.login);
                  },
                );
              },
            ),
    );
  }
}