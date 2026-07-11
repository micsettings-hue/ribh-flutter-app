import React, { createContext, useMemo, useState } from "react";
import { View } from "react-native";
import { useFonts } from "expo-font";
import * as SplashScreen from "expo-splash-screen";

import { buildTheme, fontsToLoad, Theme, ThemeMode } from "./tokens";

SplashScreen.preventAutoHideAsync().catch(() => {
  // No-op: splash screen may already be hidden in some environments (e.g. web).
});

type ThemeContextValue = Theme & { setMode: (mode: ThemeMode) => void };

export const ThemeContext = createContext<ThemeContextValue>({
  ...buildTheme("light"),
  setMode: () => {},
});

export function ThemeProvider({ children }: { children: React.ReactNode }) {
  const [fontsLoaded, fontError] = useFonts(fontsToLoad);
  const [mode, setMode] = useState<ThemeMode>("light");
  const ready = fontsLoaded || !!fontError;

  const value = useMemo(() => ({ ...buildTheme(mode), setMode }), [mode]);

  if (!ready) {
    return null;
  }

  return (
    <View style={{ flex: 1 }} onLayout={() => SplashScreen.hideAsync().catch(() => {})}>
      <ThemeContext.Provider value={value}>{children}</ThemeContext.Provider>
    </View>
  );
}
