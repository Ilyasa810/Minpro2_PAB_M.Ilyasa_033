import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/team_provider.dart';
import '../../providers/theme_provider.dart';
import 'team_detail_page.dart';
import 'team_form_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _initialFromName(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    return trimmed.substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    final appBarBackground = Theme.of(context).colorScheme.surface;
    final appBarForeground = Theme.of(context).colorScheme.onSurface;
    final accentColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Tim Sepakbola'),
        backgroundColor: appBarBackground,
        foregroundColor: appBarForeground,
        actions: [
          IconButton(
            tooltip: isDarkMode ? 'Aktifkan Light Mode' : 'Aktifkan Dark Mode',
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
          ),
        ],
      ),
      body: Consumer<TeamProvider>(
        builder: (context, teamProvider, child) {
          final teams = teamProvider.teams;

          if (teamProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (teamProvider.errorMessage != null && teams.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      teamProvider.errorMessage!,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context.read<TeamProvider>().fetchTeams(),
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (teams.isEmpty) {
            return const Center(
              child: Text(
                'Anda punya tim favorit ?.\nSilakan tambah tim pertama!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: accentColor,
                    child: Text(
                      _initialFromName(team.name),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    team.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text('${team.stadion} - ${team.favoritePlayer}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blueGrey),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamFormPage(team: team),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: team.id == null
                            ? null
                            : () {
                                _showDeleteDialog(context, team.id!, team.name);
                              },
                      ),
                    ],
                  ),
                  onTap: () {
                    if (team.id == null) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeamDetailPage(teamId: team.id!),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TeamFormPage(),
            ),
          );
        },
        backgroundColor: accentColor,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, int id, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Tim'),
        content: Text('Apakah Anda yakin ingin menghapus $name?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              final provider = context.read<TeamProvider>();
              final success = await provider.deleteTeam(id);
              if (!context.mounted) return;

              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    success
                        ? '$name berhasil dihapus'
                        : (provider.errorMessage ?? 'Gagal menghapus $name'),
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
