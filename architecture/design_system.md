# EpayNepal — Design System

> Extracted from Stitch design exports and existing Flutter `core/theme/` implementation.

---

## 1. Color Palette

### Primary (Emerald Green)
| Token | Hex | Usage |
|-------|-----|-------|
| `primary` | `#006E0D` | Main brand color, CTAs, active states |
| `onPrimary` | `#FFFFFF` | Text/icons on primary backgrounds |
| `primaryContainer` | `#37C837` | Balance card gradient end, highlights |
| `onPrimaryContainer` | `#004D06` | Text on primary container |
| `primaryFixed` | `#75FF69` | Reward/points accent |
| `primaryFixedDim` | `#54E24E` | Inverse primary, dark mode primary |
| `inversePrimary` | `#54E24E` | Dark theme primary |

### Secondary (Warm Neutral)
| Token | Hex | Usage |
|-------|-----|-------|
| `secondary` | `#5E5F58` | Subtle UI elements, secondary text |
| `onSecondary` | `#FFFFFF` | Text on secondary |
| `secondaryContainer` | `#E4E3DA` | Card backgrounds, dividers |

### Tertiary (Teal)
| Token | Hex | Usage |
|-------|-----|-------|
| `tertiary` | `#396668` | Travel section, secondary CTA |
| `onTertiary` | `#FFFFFF` | Text on tertiary |
| `tertiaryContainer` | `#88B6B8` | Teal card backgrounds |

### Error
| Token | Hex | Usage |
|-------|-----|-------|
| `error` | `#BA1A1A` | Error states, failed transactions |
| `onError` | `#FFFFFF` | Text on error |
| `errorContainer` | `#FFDAD6` | Error backgrounds |

### Surface / Background
| Token | Hex | Usage |
|-------|-----|-------|
| `background` | `#FAFAF2` | Page background |
| `surface` | `#FAFAF2` | Card surface |
| `surfaceContainerLowest` | `#FFFFFF` | Elevated cards |
| `surfaceContainerLow` | `#F4F4EC` | Grid section backgrounds |
| `surfaceContainer` | `#EEEEE6` | Standard containers |
| `surfaceContainerHigh` | `#E8E9E1` | Raised containers |
| `surfaceContainerHighest` | `#E3E3DB` | Highest elevation |
| `onSurface` | `#1A1C18` | Primary text |
| `onSurfaceVariant` | `#3D4A39` | Secondary text |
| `outline` | `#6D7B68` | Borders, dividers |
| `outlineVariant` | `#BCCBB4` | Subtle borders |

### Dark Mode
| Token | Hex |
|-------|-----|
| `surface` | `#121411` |
| `background` | `#1A1C18` |
| `onSurface` | `#E3E3DB` |
| `primary` | `#54E24E` |
| `onPrimary` | `#004D06` |
| `surfaceVariant` | `#3D4A39` |

---

## 2. Typography

**Font Family:** Google Fonts — **Inter**

| Style | Size | Weight | Spacing | Usage |
|-------|------|--------|---------|-------|
| Display Large | 57px | Bold (700) | -0.25 | Hero numbers |
| Display Medium | 45px | Bold (700) | 0 | Large balance |
| Display Small | 36px | Bold (700) | 0 | Section headers |
| Headline Large | 32px | Bold (700) | 0 | Page titles |
| Headline Medium | 28px | SemiBold (600) | 0 | Section titles |
| Headline Small | 24px | SemiBold (600) | 0 | Card titles |
| Title Large | 22px | SemiBold (600) | 0 | App bar titles |
| Title Medium | 16px | SemiBold (600) | 0.15 | List item titles |
| Title Small | 14px | SemiBold (600) | 0.1 | Subtitles |
| Label Large | 14px | SemiBold (600) | 0.1 | Button text |
| Label Medium | 12px | SemiBold (600) | 0.5 | Tags, badges |
| Label Small | 11px | SemiBold (600) | 0.5 | Captions |
| Body Large | 16px | Regular (400) | 0.5 | Primary body text |
| Body Medium | 14px | Regular (400) | 0.25 | Secondary body text |
| Body Small | 12px | Regular (400) | 0.4 | Tertiary text |

---

## 3. Spacing Scale

Based on 4px grid:

| Token | Value | Usage |
|-------|-------|-------|
| `xs` | 4px | Icon-to-text gap |
| `sm` | 8px | Compact element spacing |
| `md` | 12px | Standard element spacing |
| `lg` | 16px | Section padding, screen horizontal margins |
| `xl` | 20px | Card padding |
| `xxl` | 24px | Section spacing |
| `xxxl` | 32px | Major section breaks |

---

## 4. Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| `sm` | 8px | Small buttons, tags |
| `md` | 12px | Input fields, status badges |
| `lg` | 16px | Action buttons, grid items |
| `xl` | 24px | Cards, containers, sheets |
| `full` | 999px | Circular elements, pills |

---

## 5. Elevation / Shadows

| Level | Shadow | Usage |
|-------|--------|-------|
| Level 0 | None | Flat surfaces |
| Level 1 | `0 2px 5px rgba(0,0,0,0.05)` | Grid item icons |
| Level 2 | `0 5px 10px primary/0.3` | Balance card |
| Level 3 | `0 8px 16px rgba(0,0,0,0.1)` | Floating elements |

---

## 6. Component Specifications

### Balance Card
- Gradient: `primary` → `primaryContainer` (topLeft → bottomRight)
- Border radius: 24px
- Padding: 20px
- Shadow: Level 2 with primary color
- Balance text: 24px bold white
- Action icons: 48×48px, white/15% opacity background, 16px radius

### Transaction Tile
- Background: white
- Border: 1px `outlineVariant/30%`
- Border radius: 24px
- Padding: 16px
- Icon container: 44×44px, themed background, 16px radius
- Title: 14px bold
- Date: 12px `onSurfaceVariant`
- Amount: 14px bold, error for debit / primary for credit

### Utility Grid
- Background: `surfaceContainerLow`
- Border radius: 24px
- Padding: 20px
- Items: 4 columns
- Icon container: 48×48px circle, white background, subtle shadow
- Label: 11px medium, center-aligned

### Primary Button (CustomButton)
- Background: `primary`
- Text: white, 14px semibold
- Border radius: 16px
- Height: 48px minimum
- Full width in forms

### Text Input (CustomTextField)
- Border: 1px `outline`
- Focus border: 2px `primary`
- Border radius: 12px
- Padding: 16px horizontal
- Label: 12px `onSurfaceVariant`

### App Bar
- Background: `primary`
- Shape: rounded bottom corners (24px radius)
- Title: white, 18px bold
- Actions: white icons

### Bottom Navigation
- 4 tabs + center floating QR button
- Active: `primary` color
- Inactive: `onSurfaceVariant`
- Center FAB: 56px, `primary` background, QR icon

---

## 7. Icon System

Material Icons (Flutter built-in):
- Navigation: `home`, `receipt_long`, `headset_mic`, `grid_view`
- Actions: `send`, `account_balance_wallet`, `account_balance`, `payments`
- Utility: `smartphone`, `bolt`, `water_drop`, `router`, `flight`
- Status: `check_circle`, `error`, `info`, `warning`
- QR: `qr_code_scanner`, `qr_code`

---

## 8. Animation Guidelines

- **Page transitions:** Fade + slide (300ms, easeInOut)
- **Balance visibility toggle:** Instant
- **Loading states:** Circular progress indicator with primary color
- **Pull-to-refresh:** Standard Material refresh indicator
- **Micro-interactions:** Ripple on tap (Material default)
- **Card hover/press:** Scale 0.98 on press (100ms)

---

## 9. Responsive Breakpoints

| Breakpoint | Width | Target |
|-----------|-------|--------|
| Mobile S | 320px | Small phones |
| Mobile M | 375px | Standard phones |
| Mobile L | 425px | Large phones |
| Tablet | 768px | Admin dashboard minimum |

Mobile app is designed mobile-first. Admin panel is responsive down to tablet width.
