import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/ui_feedback.dart';
import '../../../../core/widgets/cards/transaction_tile.dart';
import '../../../demo_settings/data/demo_settings_store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isBalanceVisible = true;

  String _displayBalance() {
    final shouldUseMockBalance =
        DemoSettingsStore.demoModeEnabled &&
        DemoSettingsStore.mockBalanceEnabled;

    final balance = shouldUseMockBalance
        ? DemoSettingsStore.mockBalance
        : 45280.50;

    if (!_isBalanceVisible) {
      return 'NPR XXXX.XX';
    }

    final fixed = balance.toStringAsFixed(2);
    final parts = fixed.split('.');
    final wholeWithCommas = parts[0].replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => ',',
    );
    return 'NPR $wholeWithCommas.${parts[1]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildBalanceCard(context),
                  const SizedBox(height: 24),
                  _buildPromoBanner(context),
                  const SizedBox(height: 24),
                  _buildUtilityPayments(context),
                  const SizedBox(height: 24),
                  _buildTravelsTicketing(context),
                  const SizedBox(height: 24),
                  _buildRecentTransactions(context),
                  const SizedBox(height: 100), // padding for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return SliverAppBar(
      pinned: true,
      expandedHeight: 80,
      backgroundColor: colorScheme.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      title: Row(
        children: [
          GestureDetector(
            onTap: () => context.push('/kyc_dashboard'),
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuA32sXnGRUu_8OjzgGk600wwkCvbAxk4FucpjfLdVnYmm0LmCrhtlO2tze9eT54awOs5yKnAM77mXYZo-iQXlpo4N3ir8VzcVI_1r_C-Vg3U0l_bYpeiNudP0yHnDPtqSn3yDbcNTAdkDJ2cslsaM8AplIHgmBUmvym-amIFn3IPRzU5sxKaKlFCqbBayJlYizz10cXlAgdhOjQZL_Hoz7BmW__0xP7rvvXUTo62pzucrYJ6PcQPuoPft16MGybUHNs4v6qLB1gbatn',
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, Upendra',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Text(
                'Good Morning',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimary.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () => UiFeedback.comingSoon(context, 'Global search'),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () =>
              UiFeedback.comingSoon(context, 'Notifications center'),
        ),
        IconButton(
          icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
          onPressed: () => context.push('/scan_qr'),
        ),
      ],
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: colorScheme.surfaceContainerHighest,
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1557683316-973673baf926?q=80&w=600&auto=format&fit=crop',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '10% Cashback',
              style: theme.textTheme.titleLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'On internet bill payments',
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOTAL BALANCE',
                    style: TextStyle(
                      color: colorScheme.onPrimary.withValues(alpha: 0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        _displayBalance(),
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                          _isBalanceVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: colorScheme.onPrimary.withValues(alpha: 0.7),
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _isBalanceVisible = !_isBalanceVisible;
                          });
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.stars, color: Color(0xFF75ff69), size: 16),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'FONEPOINTS',
                          style: TextStyle(
                            color: colorScheme.onPrimary.withValues(alpha: 0.7),
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '1,240',
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBalanceAction(
                context,
                Icons.account_balance_wallet,
                'Load Money',
                '/load_money',
              ),
              _buildBalanceAction(
                context,
                Icons.send,
                'Send Money',
                '/payment_details',
              ),
              _buildBalanceAction(
                context,
                Icons.account_balance,
                'Bank Transfer',
                '/bank_transfer',
              ),
              _buildBalanceAction(
                context,
                Icons.payments,
                'Remittance',
                '/remittance',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceAction(
    BuildContext context,
    IconData icon,
    String label,
    String? route,
  ) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          context.push(route);
        }
      },
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUtilityPayments(BuildContext context) {
    return _buildGridSection(
      context,
      title: 'Utility & Bill Payments',
      items: [
        _buildUtilityItem(context, Icons.smartphone, 'Topup & Data', '/topup'),
        _buildUtilityItem(context, Icons.bolt, 'Electricity', '/electricity'),
        _buildUtilityItem(context, Icons.water_drop, 'Khanepani', null),
        _buildUtilityItem(context, Icons.router, 'Internet', '/internet'),
        _buildUtilityItem(context, Icons.flight, 'Airlines', '/flight_booking'),
        _buildUtilityItem(
          context,
          Icons.account_balance,
          'Govt. Payment',
          '/govt_payment',
        ),
        _buildUtilityItem(
          context,
          Icons.school,
          'Education Fee',
          '/education_fee',
        ),
        _buildUtilityItem(context, Icons.confirmation_number, 'Events', null),
      ],
      onViewAll: () => context.push('/utility'),
    );
  }

  Widget _buildTravelsTicketing(BuildContext context) {
    return _buildGridSection(
      context,
      title: 'Travels & Ticketing',
      items: [
        _buildUtilityItem(
          context,
          Icons.flight_takeoff,
          'Airlines',
          '/flight_booking',
          color: const Color(0xFF396668),
        ),
        _buildUtilityItem(
          context,
          Icons.hotel,
          'Hotels',
          '/travel_hub',
          color: const Color(0xFF396668),
        ),
        _buildUtilityItem(
          context,
          Icons.directions_bus,
          'Bus Ticket',
          '/travel_hub',
          color: const Color(0xFF396668),
        ),
        _buildUtilityItem(
          context,
          Icons.movie,
          'Movies',
          '/travel_hub',
          color: const Color(0xFF396668),
        ),
      ],
      onViewAll: () => context.push('/travel_hub'),
    );
  }

  Widget _buildGridSection(
    BuildContext context, {
    required String title,
    required List<Widget> items,
    VoidCallback? onViewAll,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: onViewAll ?? () {},
              child: const Text(
                'View All',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Wrap(
            spacing: 16,
            runSpacing: 24,
            alignment: WrapAlignment.spaceAround,
            children: items
                .map(
                  (e) => SizedBox(
                    width: MediaQuery.of(context).size.width / 4 - 24,
                    child: e,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    IconData icon,
    String label, {
    Color? color,
    bool isMore = false,
  }) {
    final iconColor = color ?? Theme.of(context).colorScheme.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isMore
                ? Theme.of(context).colorScheme.surfaceContainerHigh
                : Colors.white,
            shape: BoxShape.circle,
            boxShadow: isMore
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Icon(
            icon,
            color: isMore
                ? Theme.of(context).colorScheme.onSurfaceVariant
                : iconColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildUtilityItem(
    BuildContext context,
    IconData icon,
    String label,
    String? route, {
    Color? color,
  }) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          context.push(route);
          return;
        }
        UiFeedback.comingSoon(context, label);
      },
      child: _buildGridItem(context, icon, label, color: color),
    );
  }

  Widget _buildRecentTransactions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
              onPressed: () => context.go('/statement'),
              child: Text(
                'History',
                style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        ),
        TransactionTile(
          title: 'Mobile Topup - 9801XXXXXX',
          subtitle: 'Ncell Topup',
          date: DateTime.now().subtract(const Duration(hours: 2)),
          amount: 100.00,
          isCredit: false,
          icon: Icons.smartphone,
        ),
        TransactionTile(
          title: 'Load from NIC Asia Bank',
          subtitle: 'Bank Transfer',
          date: DateTime.now().subtract(const Duration(days: 1)),
          amount: 5000.00,
          isCredit: true,
          icon: Icons.download_done,
        ),
      ],
    );
  }
}
