import 'package:flutter/material.dart';

class FlightBookingScreen extends StatefulWidget {
  const FlightBookingScreen({super.key});

  @override
  State<FlightBookingScreen> createState() => _FlightBookingScreenState();
}

class _FlightBookingScreenState extends State<FlightBookingScreen> {
  bool isOneWay = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Book a Flight'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Segmented Toggle
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark 
                    ? colorScheme.surfaceContainerHighest 
                    : colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildToggleButton('One Way', isSelected: isOneWay, onTap: () => setState(() => isOneWay = true)),
                  ),
                  Expanded(
                    child: _buildToggleButton('Round Trip', isSelected: !isOneWay, onTap: () => setState(() => isOneWay = false)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Search Form
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark 
                    ? colorScheme.surfaceContainerHighest 
                    : colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // From / To with swap
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          _buildLocationField(context, 'From', 'Origin City', Icons.flight_takeoff),
                          const Divider(height: 32),
                          _buildLocationField(context, 'To', 'Destination City', Icons.flight_land),
                        ],
                      ),
                      Positioned(
                        right: 16,
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.swap_vert, color: colorScheme.onPrimaryContainer),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),

                  // Dates & Passengers
                  Row(
                    children: [
                      Expanded(
                        child: _buildSelectButton(context, 'Departure', 'Oct 24, 2023', Icons.calendar_month),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSelectButton(
                          context, 
                          'Return', 
                          isOneWay ? 'Add Return' : 'Oct 28, 2023', 
                          Icons.calendar_month,
                          opacity: isOneWay ? 0.5 : 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSelectButton(context, 'Passengers', '1 Adult, Economy', Icons.person),
                  const SizedBox(height: 24),

                  // Search Button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.search),
                        SizedBox(width: 8),
                        Text('Search Flights', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Popular Destinations
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Popular Destinations', style: theme.textTheme.titleMedium),
                TextButton(
                  onPressed: () {},
                  child: Text('See all', style: TextStyle(color: colorScheme.primary)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildDestinationCard(context, 'Paris', Colors.blueGrey)),
                const SizedBox(width: 16),
                Expanded(child: _buildDestinationCard(context, 'Tokyo', Colors.deepPurple)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, {required bool isSelected, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(28),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: theme.textTheme.titleSmall?.copyWith(
            color: isSelected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildLocationField(BuildContext context, String label, String hint, IconData icon) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: theme.textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant, letterSpacing: 1.2)),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(icon, color: colorScheme.secondary),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                style: theme.textTheme.titleMedium,
                decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectButton(BuildContext context, String label, String value, IconData icon, {double opacity = 1.0}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Opacity(
      opacity: opacity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: theme.textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant, letterSpacing: 1.2)),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark 
                    ? colorScheme.surfaceContainer 
                    : colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(value, style: theme.textTheme.titleSmall, overflow: TextOverflow.ellipsis),
                  ),
                  Icon(icon, color: colorScheme.secondary, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(BuildContext context, String title, Color color) {
    final theme = Theme.of(context);
    
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(12),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
