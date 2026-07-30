import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_names.dart';

class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({super.key});

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Your All-in-One\nDigital Wallet',
      'description': 'Manage your digital assets securely with lightning-fast transactions and zero hidden fees.',
      'icon': 'account_balance_wallet',
    },
    {
      'title': 'Secure & Private\nTransactions',
      'description': 'Your money is safe with our advanced encryption and local-first architecture.',
      'icon': 'shield',
    },
    {
      'title': 'Pay Anywhere,\nAnytime',
      'description': 'Scan QR codes, pay bills, and transfer money instantly without limits.',
      'icon': 'qr_code_scanner',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.pushReplacementNamed(RouteNames.authHub);
    }
  }

  void _skip() {
    context.pushReplacementNamed(RouteNames.authHub);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Top Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _skip,
                    child: Text(
                      'Skip',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Illustration Canvas
            Expanded(
              flex: 5,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.dark 
                            ? colorScheme.surfaceContainerHighest 
                            : colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(24.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: _getIconForIndex(index, colorScheme),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Content Area (Bottom Sheet like)
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark 
                      ? colorScheme.surfaceContainerHighest 
                      : colorScheme.surfaceContainer,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 40,
                      offset: const Offset(0, -10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          _onboardingData[_currentPage]['title']!,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _onboardingData[_currentPage]['description']!,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    
                    // Navigation Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Pagination Dots
                        Row(
                          children: List.generate(
                            _onboardingData.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: 8),
                              height: 8,
                              width: _currentPage == index ? 32 : 8,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? colorScheme.primary
                                    : colorScheme.surfaceVariant,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                        
                        // Next Button
                        FloatingActionButton(
                          onPressed: _nextPage,
                          elevation: 2,
                          backgroundColor: colorScheme.primaryContainer,
                          foregroundColor: colorScheme.onPrimaryContainer,
                          child: const Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIconForIndex(int index, ColorScheme colorScheme) {
    IconData iconData;
    switch (index) {
      case 0:
        iconData = Icons.account_balance_wallet;
        break;
      case 1:
        iconData = Icons.security;
        break;
      case 2:
        iconData = Icons.qr_code_scanner;
        break;
      default:
        iconData = Icons.star;
    }
    
    return Icon(
      iconData,
      size: 120,
      color: colorScheme.primary,
    );
  }
}
