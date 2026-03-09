import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/team.dart';

class TeamProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  static const String _tableName = 'daftartim';
  static const String _idColumn = 'id';
  static const String _nameColumn = 'namatim';
  static const String _stadionColumn = 'stadion';
  static const String _favoritePlayerColumn = 'pemainfavorit';
  final List<Team> _teams = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Team> get teams => List.unmodifiable(_teams);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Team? getTeamById(int id) {
    try {
      return _teams.firstWhere((team) => team.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> fetchTeams() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _supabase
          .from(_tableName)
          .select()
          .order(_nameColumn, ascending: true);

      _teams
        ..clear()
        ..addAll((response as List).map((item) => Team.fromMap(item)));
    } catch (e) {
      _errorMessage = _buildErrorMessage('mengambil data tim', e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // CREATE: Tambah data tim baru ke Supabase.
  Future<bool> addTeam(Team team) async {
    _errorMessage = null;
    notifyListeners();

    try {
      await _insertTeam(team);
      await fetchTeams();
      return true;
    } catch (e) {
      _errorMessage = _buildErrorMessage('menambah tim', e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTeam(Team team) async {
    _errorMessage = null;
    notifyListeners();

    try {
      if (team.id == null) {
        _errorMessage = 'ID tim tidak valid untuk update.';
        notifyListeners();
        return false;
      }

      await _updateTeam(team);
      await fetchTeams();
      return true;
    } catch (e) {
      _errorMessage = _buildErrorMessage('memperbarui tim', e);
      notifyListeners();
      return false;
    }
  }

  // DELETE: Hapus data tim berdasarkan id di Supabase.
  Future<bool> deleteTeam(int id) async {
    _errorMessage = null;
    notifyListeners();

    try {
      await _supabase.from(_tableName).delete().eq(_idColumn, id);
      await fetchTeams();
      return true;
    } catch (e) {
      _errorMessage = _buildErrorMessage('menghapus tim', e);
      notifyListeners();
      return false;
    }
  }

  Future<void> _insertTeam(Team team) async {
    final basePayload = <String, dynamic>{
      _nameColumn: team.name,
      _stadionColumn: team.stadion,
      _favoritePlayerColumn: team.favoritePlayer,
    };
    await _insertWithOwnerFallback(basePayload);
  }

  Future<void> _insertWithOwnerFallback(Map<String, dynamic> basePayload) async {
    try {
      await _supabase.from(_tableName).insert(basePayload);
      return;
    } on PostgrestException catch (e) {
      final userId = _supabase.auth.currentUser?.id;
      if (e.code != '42501' || userId == null) {
        rethrow;
      }
    }

    final userId = _supabase.auth.currentUser!.id;
    const ownerColumns = ['user_id', 'owner_id', 'created_by'];
    PostgrestException? lastError;

    for (final column in ownerColumns) {
      try {
        await _supabase.from(_tableName).insert({
          ...basePayload,
          column: userId,
        });
        return;
      } on PostgrestException catch (e) {
        lastError = e;
        final missingColumn = e.code == 'PGRST204';
        if (missingColumn) {
          continue;
        }
      }
    }

    if (lastError != null) {
      throw lastError;
    }
  }

  Future<void> _updateTeam(Team team) async {
    await _supabase
        .from(_tableName)
        .update({
          _nameColumn: team.name,
          _stadionColumn: team.stadion,
          _favoritePlayerColumn: team.favoritePlayer,
        })
        .eq(_idColumn, team.id!);
  }

  String _buildErrorMessage(String action, Object error) {
    if (error is PostgrestException) {
      if (error.code == '42501') {
        return 'Gagal $action: akses ditolak oleh kebijakan RLS Supabase. '
            'Pastikan table "$_tableName" punya policy untuk role authenticated/anon '
            'atau user yang sedang login.';
      }
      if (error.code == 'PGRST204') {
        return 'Gagal $action: ada nama kolom yang tidak cocok dengan tabel Supabase.';
      }
      return 'Gagal $action: ${error.message} (code: ${error.code})';
    }

    return 'Gagal $action: $error';
  }
}
