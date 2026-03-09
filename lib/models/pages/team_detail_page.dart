import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/team_provider.dart';
import 'team_form_page.dart';

class TeamDetailPage extends StatelessWidget {
  final int teamId;

  const TeamDetailPage({super.key, required this.teamId});

  String _initialFromName(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    return trimmed.substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final appBarBackground = Theme.of(context).colorScheme.surface;
    final appBarForeground = Theme.of(context).colorScheme.onSurface;
    final accentColor = Theme.of(context).colorScheme.primary;

    return Consumer<TeamProvider>(
      builder: (context, teamProvider, child) {
        final team = teamProvider.getTeamById(teamId);

        if (team == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Detail Tim'),
              backgroundColor: appBarBackground,
              foregroundColor: appBarForeground,
            ),
            body: const Center(
              child: Text('Tim tidak ditemukan'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Detail Tim'),
            backgroundColor: appBarBackground,
            foregroundColor: appBarForeground,
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeamFormPage(team: team),
                    ),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: accentColor,
                    child: Text(
                      _initialFromName(team.name),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    team.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),
                _buildDetailCard(
                  context: context,
                  icon: Icons.location_city,
                  label: 'Stadion',
                  value: team.stadion,
                ),
                const SizedBox(height: 16),
                _buildDetailCard(
                  context: context,
                  icon: Icons.person,
                  label: 'Pemain Favorit',
                  value: team.favoritePlayer,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
