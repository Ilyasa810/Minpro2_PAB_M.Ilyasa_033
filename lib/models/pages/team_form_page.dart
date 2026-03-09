import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/team.dart';
import '../../providers/team_provider.dart';

class TeamFormPage extends StatefulWidget {
  final Team? team;

  const TeamFormPage({super.key, this.team});

  @override
  State<TeamFormPage> createState() => _TeamFormPageState();
}

class _TeamFormPageState extends State<TeamFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _stadionController;
  late TextEditingController _favoritePlayerController;
  bool _isSubmitting = false;

  bool get isEditing => widget.team != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.team?.name ?? '');
    _stadionController = TextEditingController(text: widget.team?.stadion ?? '');
    _favoritePlayerController = TextEditingController(
      text: widget.team?.favoritePlayer ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _stadionController.dispose();
    _favoritePlayerController.dispose();
    super.dispose();
  }

  Future<void> _saveTeam() async {
    if (!_formKey.currentState!.validate() || _isSubmitting) return;

    final provider = context.read<TeamProvider>();
    setState(() => _isSubmitting = true);

    bool success;

    if (isEditing) {
      final updatedTeam = widget.team!.copyWith(
        name: _nameController.text.trim(),
        stadion: _stadionController.text.trim(),
        favoritePlayer: _favoritePlayerController.text.trim(),
      );
      success = await provider.updateTeam(updatedTeam);
    } else {
      final newTeam = Team(
        id: null,
        name: _nameController.text.trim(),
        stadion: _stadionController.text.trim(),
        favoritePlayer: _favoritePlayerController.text.trim(),
      );
      success = await provider.addTeam(newTeam);
    }

    if (!mounted) return;

    setState(() => _isSubmitting = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? (isEditing ? 'Tim berhasil diperbarui' : 'Tim berhasil ditambahkan')
              : (provider.errorMessage ?? 'Terjadi kesalahan'),
        ),
      ),
    );

    if (success) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBarBackground = Theme.of(context).colorScheme.surface;
    final appBarForeground = Theme.of(context).colorScheme.onSurface;
    final accentColor = Theme.of(context).colorScheme.primary;
    final onAccentColor = Theme.of(context).colorScheme.onPrimary;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Tim' : 'Tambah Tim'),
        backgroundColor: appBarBackground,
        foregroundColor: appBarForeground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Tim',
                  hintText: 'Masukkan nama tim',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.sports_soccer),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tim tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stadionController,
                decoration: const InputDecoration(
                  labelText: 'Stadion',
                  hintText: 'Masukkan nama stadion',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Stadion tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _favoritePlayerController,
                decoration: const InputDecoration(
                  labelText: 'Pemain Favorit',
                  hintText: 'Masukkan nama pemain favorit',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pemain favorit tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveTeam,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: onAccentColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isSubmitting
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(onAccentColor),
                        ),
                      )
                    : Text(
                        isEditing ? 'Simpan Perubahan' : 'Tambah Tim',
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
