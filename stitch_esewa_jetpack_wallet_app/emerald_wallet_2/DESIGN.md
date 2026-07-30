---
name: Emerald Wallet
colors:
  surface: '#131313'
  surface-dim: '#131313'
  surface-bright: '#393939'
  surface-container-lowest: '#0e0e0e'
  surface-container-low: '#1c1b1b'
  surface-container: '#201f1f'
  surface-container-high: '#2a2a2a'
  surface-container-highest: '#353534'
  on-surface: '#e5e2e1'
  on-surface-variant: '#bccbb4'
  inverse-surface: '#e5e2e1'
  inverse-on-surface: '#313030'
  outline: '#879580'
  outline-variant: '#3d4a39'
  surface-tint: '#54e24e'
  primary: '#58e551'
  on-primary: '#003a03'
  primary-container: '#37c837'
  on-primary-container: '#004d06'
  inverse-primary: '#006e0d'
  secondary: '#7dffa2'
  on-secondary: '#003918'
  secondary-container: '#05e777'
  on-secondary-container: '#00622e'
  tertiary: '#60e19a'
  on-tertiary: '#00391f'
  tertiary-container: '#3fc580'
  on-tertiary-container: '#004d2c'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#75ff69'
  primary-fixed-dim: '#54e24e'
  on-primary-fixed: '#002201'
  on-primary-fixed-variant: '#005307'
  secondary-fixed: '#62ff96'
  secondary-fixed-dim: '#00e475'
  on-secondary-fixed: '#00210b'
  on-secondary-fixed-variant: '#005226'
  tertiary-fixed: '#7afbb1'
  tertiary-fixed-dim: '#5cde97'
  on-tertiary-fixed: '#002110'
  on-tertiary-fixed-variant: '#00522f'
  background: '#131313'
  on-background: '#e5e2e1'
  surface-variant: '#353534'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 57px
    fontWeight: '700'
    lineHeight: 64px
    letterSpacing: -0.25px
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
  title-lg:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '500'
    lineHeight: 28px
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
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.1px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.5px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 8px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  gutter: 16px
  margin-mobile: 16px
  margin-desktop: 32px
---

## Brand & Style

The brand personality is professional, secure, and high-performance. It targets sophisticated cryptocurrency users who value both aesthetic precision and functional clarity. This design system adopts a **Corporate Modern** style with a deep focus on **Dark Mode Architecture**. 

The UI evokes an emotional response of trust and technological prowess. It leverages a rigorous grid-based structure, high-legibility typography, and subtle tonal depth to create an environment that feels premium yet utilitarian. Every element is designed to minimize cognitive load while emphasizing the "Emerald" brand through strategic hits of high-vibrancy color against low-vibration surfaces.

## Colors

The palette is anchored by "Emerald Green" (#37C837), specifically tuned for maximum "pop" against dark backgrounds without causing eye strain. 

- **Primary**: Used for key actions, status indicators, and branding moments.
- **Surface Strategy**: Follows Material 3 tonal elevation. The base background is `#121212`. As elements rise in hierarchy (elevation), the surface color becomes lighter using charcoal-grey overlays rather than pure black.
- **Accessibility**: All interactive primary-colored elements must maintain a contrast ratio of at least 3:1 against dark surfaces. Text on primary colors should use `#000000` for optimal legibility.
- **Functional Colors**: Success (Emerald Primary), Warning (Amber #FFB300), and Error (Coral #FF5252).

## Typography

This design system utilizes **Inter** exclusively to ensure a systematic and utilitarian feel across all platforms. 

- **Weights**: Use `SemiBold` (600) for headlines to create a strong visual anchor. Use `Medium` (500) for labels and navigation items. Use `Regular` (400) for all body text.
- **Numerical Data**: For wallet balances and transaction amounts, use `Medium` or `SemiBold` weight to ensure prominence. 
- **Tracking**: Tighten letter-spacing slightly for larger headlines (`-2%`) and increase it for small labels (`+5%`) to enhance readability at small scales.

## Layout & Spacing

The system is built on a strict **8dp grid**. All dimensions, padding, and margins must be multiples of 8 (or 4 for micro-adjustments).

- **Grid Model**: A fluid grid system is preferred. Mobile layouts should utilize a 4-column grid with 16dp margins. Tablet/Desktop should scale to a 12-column grid.
- **Container Alignment**: Use 24dp for horizontal padding on major screen containers to create a spacious, high-end feel.
- **Vertical Rhythm**: Maintain consistent vertical spacing between sections (e.g., 32dp between card groups, 8dp between a label and its input field).

## Elevation & Depth

Visual hierarchy is managed through **Tonal Layering** in dark mode and **Ambient Shadows** in light mode.

- **Dark Mode**: Avoid physical shadows. Instead, use surface color steps. A FAB (Floating Action Button) or Modal should sit on a `surface-container-high` (`#2C2C2C`) background to appear "closer" to the user than the base background.
- **Light Mode**: Use soft, multi-layered shadows. 
    - *Level 1 (Cards)*: `box-shadow: 0 2px 4px rgba(0,0,0,0.05)`.
    - *Level 2 (Modals/Popups)*: `box-shadow: 0 10px 20px rgba(0,0,0,0.1)`.
- **Interactions**: On press/tap, elements should "sink" visually by reducing their elevation (dark mode) or shadow spread (light mode).

## Shapes

The design system uses a distinctive **Large Radius** approach for primary containers to soften the technical nature of the app.

- **Primary Containers**: Large cards and bottom sheets must use a **24dp corner radius** (`rounded-xl`).
- **Standard Components**: Buttons and input fields use an **8dp corner radius** (`rounded-md`) to maintain a professional, structured look.
- **Small Elements**: Chips and tags use a **16dp or pill-shaped radius** to differentiate them from actionable buttons.

## Components

### Buttons
- **Primary**: Solid Emerald (`#37C837`) with black text. 8dp radius. 
- **Secondary**: Outlined Emerald with 1.5px border.
- **States**: 
  - *Pressed*: Overlay of 12% black on primary color.
  - *Disabled*: 12% white opacity on surface, 38% text opacity.
  - *Loading*: Replace label with a 20dp circular progress indicator.

### Input Fields
- **Style**: Filled style with a bottom-only border or a subtle container (`surface-container`). 
- **Active State**: 2px Emerald bottom border and floating label in Emerald.
- **Icons**: Use **Material Symbols (Outlined)** at 24dp.

### Cards
- Card containers should use the 24dp radius. In dark mode, cards use the `surface-container` (`#242424`) color with no border. In light mode, use a white background with a subtle 1px border (`#E0E0E0`).

### Lists
- Use 72dp height for standard list items (avatar + two lines of text). 
- Use a 16dp horizontal inset for dividers, which should be low-contrast (`#FFFFFF` at 8% opacity).

### Selection Controls
- **Checkboxes/Radios**: Emerald primary color when selected.
- **Switch**: Use a "Thumb" color of Emerald and a "Track" of `surface-container-high`.