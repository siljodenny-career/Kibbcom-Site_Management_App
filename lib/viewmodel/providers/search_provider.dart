import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/models/site_model.dart';
import 'site_provider.dart';

final searchQueryProvider = StateProvider<String>((_) => '');

final filteredSitesProvider = Provider<List<SiteModel>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase().trim();
  final state = ref.watch(siteProvider);

  if (state.isLoading) return [];
  if (query.isEmpty) return state.sites;

  return state.sites
      .where((s) => s.name.toLowerCase().contains(query))
      .toList();
});
