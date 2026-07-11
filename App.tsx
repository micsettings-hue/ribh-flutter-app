import React from "react";
import { StatusBar } from "expo-status-bar";
import { SafeAreaProvider } from "react-native-safe-area-context";

import { ThemeProvider, useTheme } from "@/theme";
import { AppStateProvider } from "@/state/AppState";
import { ToastProvider } from "@/components/Toast";
import { SheetProvider } from "@/components/Sheet";
import { RootNavigator } from "@/navigation/RootNavigator";

function ThemedApp() {
  const t = useTheme();
  return (
    <>
      <StatusBar style={t.mode === "dark" ? "light" : "dark"} />
      <SheetProvider>
        <ToastProvider>
          <RootNavigator />
        </ToastProvider>
      </SheetProvider>
    </>
  );
}

export default function App() {
  return (
    <SafeAreaProvider>
      <ThemeProvider>
        <AppStateProvider>
          <ThemedApp />
        </AppStateProvider>
      </ThemeProvider>
    </SafeAreaProvider>
  );
}
