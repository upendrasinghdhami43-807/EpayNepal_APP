---
name: Emerald Wallet
colors:
  surface: '#fafaf2'
  surface-dim: '#dadad3'
  surface-bright: '#fafaf2'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f4f4ec'
  surface-container: '#eeeee6'
  surface-container-high: '#e8e9e1'
  surface-container-highest: '#e3e3db'
  on-surface: '#1a1c18'
  on-surface-variant: '#3d4a39'
  inverse-surface: '#2f312c'
  inverse-on-surface: '#f1f1e9'
  outline: '#6d7b68'
  outline-variant: '#bccbb4'
  surface-tint: '#006e0d'
  primary: '#006e0d'
  on-primary: '#ffffff'
  primary-container: '#37c837'
  on-primary-container: '#004d06'
  inverse-primary: '#54e24e'
  secondary: '#5e5f58'
  on-secondary: '#ffffff'
  secondary-container: '#e4e3da'
  on-secondary-container: '#64655e'
  tertiary: '#396668'
  on-tertiary: '#ffffff'
  tertiary-container: '#88b6b8'
  on-tertiary-container: '#18484a'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#75ff69'
  primary-fixed-dim: '#54e24e'
  on-primary-fixed: '#002201'
  on-primary-fixed-variant: '#005307'
  secondary-fixed: '#e4e3da'
  secondary-fixed-dim: '#c8c7bf'
  on-secondary-fixed: '#1b1c17'
  on-secondary-fixed-variant: '#474741'
  tertiary-fixed: '#bcebed'
  tertiary-fixed-dim: '#a0cfd1'
  on-tertiary-fixed: '#002021'
  on-tertiary-fixed-variant: '#1f4d50'
  background: '#fafaf2'
  on-background: '#1a1c18'
  surface-variant: '#e3e3db'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 57px
    fontWeight: '400'
    lineHeight: 64px
    letterSpacing: -0.25px
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
  headline-md:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
  title-lg:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '500'
    lineHeight: 28px
  title-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: 0.15px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: 0.5px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0.25px
  label-lg:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.1px
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  margin-mobile: 16px
  margin-desktop: 24px
  gutter: 12px
  stack-sm: 8px
  stack-md: 16px
  stack-lg: 24px
---

## Brand & Style

The brand personality is **reliable, efficient, and forward-thinking**. As a financial tool, the design system must prioritize trust and clarity above all else. By leveraging **Modern Material 3** principles, the design system creates a highly functional environment that feels native to the Android ecosystem while maintaining a distinct, high-end fintech aesthetic.

The visual style is **Corporate / Modern** with a focus on:
- **Clarity:** Uncluttered layouts that make financial data easy to scan.
- **Trust:** A stable green primary color that signals success and growth.
- **Depth:** Subtle use of Material 3's tonal elevation system to separate transaction details from the background.
- **Modernity:** High-radius corners (24dp) that soften the interface and make it feel more approachable and contemporary compared to legacy banking apps.

## Colors

The palette is anchored by a vibrant **Success Green (#37C837)**, used strategically for primary actions and positive financial indicators (like credits). 

In **Light Mode**, the system uses a warm neutral background to reduce eye strain, with high-contrast text for maximum readability. 
In **Dark Mode**, the design system shifts to a deep "charcoal-green" slate, maintaining the primary green's vibrancy while ensuring all transaction text meets AA accessibility standards. 

Secondary colors are used for "Container" roles—providing subtle backgrounds for cards and input fields that distinguish them from the main page surface without relying on heavy borders.

## Typography

This design system utilizes **Inter** for its exceptional legibility at small sizes—crucial for dense transaction histories. 

- **Numerical Data:** Currency amounts use `title-lg` or `headline-md` to ensure they are the first thing a user sees.
- **Hierarchy:** We use Font Weight (Semibold/600) rather than color alone to distinguish between merchant names and transaction types.
- **Labels:** Small metadata like "Transaction ID" uses `label-lg` in a medium-grey secondary color to maintain clear information architecture without cluttering the view.

## Layout & Spacing

This design system follows a **Fluid Grid** model optimized for Android handheld devices.

- **Margins:** A strict 16px side margin ensures content doesn't bleed into screen edges or interfere with system gestures.
- **Vertical Rhythm:** Components are stacked using an 8px base unit. Card-to-card spacing is typically 12px to allow for a dense yet readable list of transactions.
- **Sectioning:** Large 24px gaps are used to separate logical groups, such as the "Wallet Header" from the "Transaction List."
- **Mobile-First:** On wider screens (tablets), cards transition from full-width to a 2-column masonry or grid layout to prevent line lengths from becoming unreadable.

## Elevation & Depth

Depth is communicated through **Tonal Layers** and **Ambient Shadows**, strictly following the Material 3 elevation spec:

- **Level 0 (Surface):** The lowest layer, using the primary background color.
- **Level 1 (Cards):** Transaction cards use a subtle +5% tonal tint of the primary color or a soft #000000 @ 8% shadow with a 4px blur.
- **Level 2 (Floating Action Buttons):** The "Scan QR" or "Done" buttons use a more pronounced shadow (12px blur) to appear "closer" to the user and encourage interaction.
- **Glassmorphism:** Reserved exclusively for the Top App Bar and Bottom Navigation when content scrolls beneath them, using a 12px backdrop blur and 85% opacity.

## Shapes

The shape language is defined by **High-Radius Geometry**.

- **Large Components (Cards, Modals):** These use a 24dp (1.5rem) radius. This creates the "pill-box" container look requested, which feels friendly and modern.
- **Medium Components (Buttons, Input Fields):** These use a 16dp (1rem) radius.
- **Small Components (Chips, Status Tags):** These are fully rounded (pill-shaped) to distinguish them as interactive or status-indicating elements.

## Components

### Buttons
- **Primary:** Filled buttons using `#37C837` with white or deep-green text. 24dp height for "Done" actions, spanning the full container width.
- **Secondary:** Outlined buttons with a 1px border for "Redo" or "View Details" actions.

### Cards
- **Transaction Card:** White (Light) or Dark Grey (Dark) background, 24dp corner radius. Includes a left-aligned icon container (40x40dp) with a 12dp radius.
- **Balance Card:** High-contrast container using the Primary color to anchor the home screen.

### Inputs
- **Search Bar:** Pill-shaped (fully rounded) with a subtle "Surface Container" fill. Includes a leading magnifying glass icon.
- **Status Chips:** Small containers for "Complete" or "Pending." Use low-saturation green for "Complete" to avoid competing with primary buttons.

### Lists
- Grouped by date (e.g., "Mon, Jul 27") using `label-lg` caps for headers. Individual items use clear horizontal dividers only if cards are not used.

### Bottom Navigation
- Uses the Material 3 active-state pill indicator. Icons are 24x24dp with `label-sm` text below.