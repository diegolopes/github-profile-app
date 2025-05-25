class GithubUser {
  final String login;
  final int id;
  final String avatarUrl;
  final String htmlUrl;
  final String name;
  final String company;
  final String blog;
  final String location;
  final String email;
  final String bio;
  final int publicRepos;
  final int followers;
  final int following;

  GithubUser({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.name,
    required this.company,
    required this.blog,
    required this.location,
    required this.email,
    required this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  factory GithubUser.fromJson(Map<String, dynamic> json) {
    return GithubUser(
      login: json['login'] ?? '',
      id: json['id'] ?? 0,
      avatarUrl: json['avatar_url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
      name: json['name'] ?? '',
      company: json['company'] ?? '',
      blog: json['blog'] ?? '',
      location: json['location'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'] ?? '',
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
    );
  }
}