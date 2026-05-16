import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/models/site_model.dart';
import '../../model/services/site_service.dart';

class SiteState {
  final List<SiteModel> sites;
  final bool isLoading;

  const SiteState({this.sites = const [], this.isLoading = true});

  SiteState copyWith({List<SiteModel>? sites, bool? isLoading}) {
    return SiteState(
      sites: sites ?? this.sites,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  //Count getters for site statuses
  int get activeCount =>
      sites.where((s) => s.status == SiteStatus.active).length;

  int get maintenanceCount =>
      sites.where((s) => s.status == SiteStatus.maintenance).length;
}

class SiteNotifier extends StateNotifier<SiteState> {
  final SiteService _service;

  SiteNotifier(this._service) : super(const SiteState()) {
    _loadSites();
  }

  Future<void> _loadSites() async {
    state = state.copyWith(isLoading: true);
    final sites = await _service.mockApiResponse();
    state = state.copyWith(sites: sites, isLoading: false);
  }

  void toggleStatus(String siteId) {
    final updated = state.sites.map((site) {
      if (site.id == siteId) {
        final newStatus = site.status == SiteStatus.active
            ? SiteStatus.maintenance
            : SiteStatus.active;
        return site.copyWith(status: newStatus);
      }
      return site;
    }).toList();
    state = state.copyWith(sites: updated);
  }
}

final siteServiceProvider = Provider((_) => SiteService());

final siteProvider = StateNotifierProvider<SiteNotifier, SiteState>((ref) {
  return SiteNotifier(ref.watch(siteServiceProvider));
});
