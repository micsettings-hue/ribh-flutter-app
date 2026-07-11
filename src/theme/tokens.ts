// Palette lifted from the v8.0 prototype (docs/ribh-app-prototype-v8.html).
import {
  HankenGrotesk_400Regular,
  HankenGrotesk_500Medium,
  HankenGrotesk_600SemiBold,
  HankenGrotesk_700Bold,
} from "@expo-google-fonts/hanken-grotesk";
import { Inter_400Regular, Inter_500Medium, Inter_600SemiBold, Inter_700Bold } from "@expo-google-fonts/inter";
import {
  AnekBangla_400Regular,
  AnekBangla_500Medium,
  AnekBangla_600SemiBold,
} from "@expo-google-fonts/anek-bangla";

export type Palette = {
  teal: string;
  tealDeep: string;
  green: string;
  mint: string;
  mintSoft: string;
  gold: string;
  goldSoft: string;
  ink: string;
  inkSoft: string;
  line: string;
  paper: string;
  card: string;
  danger: string;
  dangerSoft: string;
  amber: string;
  amberSoft: string;
  heroFrom: string;
  heroMid: string;
  heroTo: string;
  white: string;
};

export const lightPalette: Palette = {
  teal: "#0FA67A",
  tealDeep: "#06342A",
  green: "#14C48A",
  mint: "#C8F5E2",
  mintSoft: "#EAFBF3",
  gold: "#C99A2E",
  goldSoft: "#F6EDD4",
  ink: "#0B1A15",
  inkSoft: "#4C6960",
  line: "#D6ECE2",
  paper: "#FBFDFC",
  card: "#FFFFFF",
  danger: "#C2412E",
  dangerSoft: "#FBEBE7",
  amber: "#8C5E0E",
  amberSoft: "#FBF1DC",
  heroFrom: "#052B22",
  heroMid: "#0A5743",
  heroTo: "#0FA67A",
  white: "#FFFFFF",
};

export const darkPalette: Palette = {
  teal: "#18C48A",
  tealDeep: "#0FA67A",
  green: "#3FE0A8",
  mint: "#123A2C",
  mintSoft: "#0C2A20",
  gold: "#E0B84B",
  goldSoft: "#38300F",
  ink: "#E8F7EF",
  inkSoft: "#8FB6A6",
  line: "#1C4133",
  paper: "#05130D",
  card: "#0E241B",
  danger: "#E88C7A",
  dangerSoft: "#38201A",
  amber: "#E0B84B",
  amberSoft: "#332912",
  heroFrom: "#052B22",
  heroMid: "#0A5743",
  heroTo: "#0FA67A",
  white: "#FFFFFF",
};

export const spacing = { xs: 4, sm: 8, md: 13, lg: 18, xl: 26 } as const;

export const radii = { sm: 10, md: 14, lg: 16, xl: 20, hero: 22, full: 999 } as const;

export const fonts = {
  display: "HankenGrotesk_500Medium",
  displaySemi: "HankenGrotesk_600SemiBold",
  displayBold: "HankenGrotesk_700Bold",
  body: "Inter_400Regular",
  bodyMedium: "Inter_500Medium",
  bodySemi: "Inter_600SemiBold",
  bodyBold: "Inter_700Bold",
  bangla: "AnekBangla_400Regular",
} as const;

export const fontsToLoad = {
  HankenGrotesk_400Regular,
  HankenGrotesk_500Medium,
  HankenGrotesk_600SemiBold,
  HankenGrotesk_700Bold,
  Inter_400Regular,
  Inter_500Medium,
  Inter_600SemiBold,
  Inter_700Bold,
  AnekBangla_400Regular,
  AnekBangla_500Medium,
  AnekBangla_600SemiBold,
};

export type ThemeMode = "light" | "dark";

export type Theme = {
  mode: ThemeMode;
  colors: Palette;
  spacing: typeof spacing;
  radii: typeof radii;
  fonts: typeof fonts;
};

export function buildTheme(mode: ThemeMode): Theme {
  return {
    mode,
    colors: mode === "dark" ? darkPalette : lightPalette,
    spacing,
    radii,
    fonts,
  };
}
