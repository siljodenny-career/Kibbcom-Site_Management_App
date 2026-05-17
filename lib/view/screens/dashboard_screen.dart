import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:site_dashboard/view/widgets/appbar_widget.dart';
import 'package:site_dashboard/view/widgets/loading_widget.dart';
import 'package:site_dashboard/view/widgets/status_summary_cards.dart';
import '../../viewmodel/site_provider.dart';
import '../../viewmodel/search_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/site_card.dart';
import '../widgets/search_bar.dart';
import 'site_detail_sheet.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final siteState     = ref.watch(siteProvider);
    final filteredSites = ref.watch(filteredSitesProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: const KibbcomAppBar(showDashboardMenu: false,),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Site Dashboard',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28)),
                  const SizedBox(height: 4),
                  Text('Monitor and manage operational sites',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const StatusSummaryCards(),
            const SiteSearchBar(),
            if (!siteState.isLoading)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Text(
                  '${filteredSites.length} site${filteredSites.length == 1 ? '' : 's'} found',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            const SizedBox(height: 8),
            Expanded(
              child: siteState.isLoading
                  ? const SingleChildScrollView(physics: NeverScrollableScrollPhysics(),child: LoadingWidget())
                  : filteredSites.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.search_off, color: AppTheme.textSecondary, size: 48),
                              const SizedBox(height: 12),
                              Text('No sites match your search',
                                  style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 24),
                          itemCount: filteredSites.length,
                          itemBuilder: (context, index) {
                            final site = filteredSites[index];
                            return SiteCard(
                              site: site,
                              index: index,
                              onTap: () => SiteDetailSheet.show(context, site),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
