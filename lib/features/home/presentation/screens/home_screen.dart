import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
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
              backgroundImage: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuA32sXnGRUu_8OjzgGk600wwkCvbAxk4FucpjfLdVnYmm0LmCrhtlO2tze9eT54awOs5yKnAM77mXYZo-iQXlpo4N3ir8VzcVI_1r_C-Vg3U0l_bYpeiNudP0yHnDPtqSn3yDbcNTAdkDJ2cslsaM8AplIHgmBUmvym-amIFn3IPRzU5sxKaKlFCqbBayJlYizz10cXlAgdhOjQZL_Hoz7BmW__0xP7rvvXUTo62pzucrYJ6PcQPuoPft16MGybUHNs4v6qLB1gbatn'),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hi, Upendra', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary)),
              Text('Good Morning', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7))),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
        IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
        IconButton(icon: const Icon(Icons.qr_code_scanner, color: Colors.white), onPressed: () {}),
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
          image: NetworkImage('https://images.unsplash.com/photo-1557683316-973673baf926?q=80&w=600&auto=format&fit=crop'),
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
            Text('10% Cashback', style: theme.textTheme.titleLarge?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('On internet bill payments', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white)),
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
            color: colorScheme.primary.withOpacity(0.3),
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
                  Text('TOTAL BALANCE', style: TextStyle(color: colorScheme.onPrimary.withOpacity(0.7), fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text('NPR 45,280.50', style: TextStyle(color: colorScheme.onPrimary, fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.visibility, color: colorScheme.onPrimary.withOpacity(0.7), size: 20),
                        onPressed: () {
                      context.push('/utility');
                    },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.stars, color: Color(0xFF75ff69), size: 16),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('FONEPOINTS', style: TextStyle(color: colorScheme.onPrimary.withOpacity(0.7), fontSize: 8, fontWeight: FontWeight.bold)),
                        Text('1,240', style: TextStyle(color: colorScheme.onPrimary, fontSize: 14, fontWeight: FontWeight.bold)),
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
              _buildBalanceAction(context, Icons.account_balance_wallet, 'Load Money', '/load_money'),
              _buildBalanceAction(context, Icons.send, 'Send Money', '/payment_details'),
              _buildBalanceAction(context, Icons.account_balance, 'Bank Transfer', '/bank_transfer'),
              _buildBalanceAction(context, Icons.payments, 'Remittance', '/remittance'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceAction(BuildContext context, IconData icon, String label, String? route) {
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
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 10, fontWeight: FontWeight.w500)),
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
        _buildUtilityItem(context, Icons.account_balance, 'Govt. Payment', '/govt_payment'),
        _buildUtilityItem(context, Icons.school, 'Education Fee', '/education_fee'),
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
        _buildUtilityItem(context, Icons.flight_takeoff, 'Airlines', '/flight_booking', color: const Color(0xFF396668)),
        _buildUtilityItem(context, Icons.hotel, 'Hotels', '/travel_hub', color: const Color(0xFF396668)),
        _buildUtilityItem(context, Icons.directions_bus, 'Bus Ticket', '/travel_hub', color: const Color(0xFF396668)),
        _buildUtilityItem(context, Icons.movie, 'Movies', '/travel_hub', color: const Color(0xFF396668)),
      ],
      onViewAll: () => context.push('/travel_hub'),
    );
  }

  Widget _buildGridSection(BuildContext context, {required String title, required List<Widget> items, VoidCallback? onViewAll}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: onViewAll ?? () {}, 
              child: const Text('View All', style: TextStyle(fontWeight: FontWeight.bold))
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
            children: items.map((e) => SizedBox(width: MediaQuery.of(context).size.width / 4 - 24, child: e)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildGridItem(BuildContext context, IconData icon, String label, {Color? color, bool isMore = false}) {
    final iconColor = color ?? Theme.of(context).colorScheme.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isMore ? Theme.of(context).colorScheme.surfaceContainerHigh : Colors.white,
            shape: BoxShape.circle,
            boxShadow: isMore ? null : [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: isMore ? Theme.of(context).colorScheme.onSurfaceVariant : iconColor),
        ),
        const SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }
  
  Widget _buildUtilityItem(BuildContext context, IconData icon, String label, String? route, {Color? color}) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          context.push(route);
        }
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
            const Text('Recent Transactions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: const Text('History', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        _buildTransactionItem(
          context,
          icon: Icons.smartphone,
          title: 'Mobile Topup - 9801XXXXXX',
          date: 'July 27, 2023 • 10:24 AM',
          amount: '- NPR 100.00',
          isNegative: true,
        ),
        const SizedBox(height: 12),
        _buildTransactionItem(
          context,
          icon: Icons.download_done,
          title: 'Load from NIC Asia Bank',
          date: 'July 26, 2023 • 03:15 PM',
          amount: '+ NPR 5,000.00',
          isNegative: false,
        ),
      ],
    );
  }
  
  Widget _buildTransactionItem(BuildContext context, {required IconData icon, required String title, required String date, required String amount, required bool isNegative}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isNegative ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1) : const Color(0xFF396668).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: isNegative ? Theme.of(context).colorScheme.primary : const Color(0xFF396668)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(date, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isNegative ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('Success', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
