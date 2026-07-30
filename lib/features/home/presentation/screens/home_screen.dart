import 'package:flutter/material.dart';

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
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      title: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Hi, Upendra', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('Good Morning', style: TextStyle(fontSize: 12, color: Colors.white70)),
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

  Widget _buildBalanceCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF006e0d), Color(0xFF37c837)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
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
                  const Text('TOTAL BALANCE', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text('NPR 45,280.50', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.visibility, color: Colors.white70, size: 20),
                        onPressed: () {},
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
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.stars, color: Color(0xFF75ff69), size: 16),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text('FONEPOINTS', style: TextStyle(color: Colors.white70, fontSize: 8, fontWeight: FontWeight.bold)),
                        Text('1,240', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
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
              _buildBalanceAction(Icons.account_balance_wallet, 'Load Money'),
              _buildBalanceAction(Icons.send, 'Send Money'),
              _buildBalanceAction(Icons.account_balance, 'Bank Transfer'),
              _buildBalanceAction(Icons.payments, 'Remittance'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildUtilityPayments(BuildContext context) {
    return _buildGridSection(
      context,
      title: 'Utility & Bill Payments',
      items: [
        _buildGridItem(context, Icons.smartphone, 'Topup & Data'),
        _buildGridItem(context, Icons.bolt, 'Electricity'),
        _buildGridItem(context, Icons.water_drop, 'Khanepani'),
        _buildGridItem(context, Icons.wifi, 'Internet'),
        _buildGridItem(context, Icons.account_balance, 'Govt. Payment'),
        _buildGridItem(context, Icons.traffic, 'Traffic Fine'),
        _buildGridItem(context, Icons.school, 'Education'),
        _buildGridItem(context, Icons.arrow_forward, 'More', isMore: true),
      ],
    );
  }

  Widget _buildTravelsTicketing(BuildContext context) {
    return _buildGridSection(
      context,
      title: 'Travels & Ticketing',
      items: [
        _buildGridItem(context, Icons.flight_takeoff, 'Airlines', color: const Color(0xFF396668)),
        _buildGridItem(context, Icons.hotel, 'Hotels', color: const Color(0xFF396668)),
        _buildGridItem(context, Icons.directions_bus, 'Bus Ticket', color: const Color(0xFF396668)),
        _buildGridItem(context, Icons.movie, 'Movies', color: const Color(0xFF396668)),
      ],
    );
  }

  Widget _buildGridSection(BuildContext context, {required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: const Text('View All', style: TextStyle(fontWeight: FontWeight.bold))),
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
