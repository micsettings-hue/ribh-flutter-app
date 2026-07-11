import React, { createContext, useCallback, useContext, useState } from "react";
import { KeyboardAvoidingView, Platform, Pressable, ScrollView, View } from "react-native";

import { useTheme } from "@/theme";

type SheetContextValue = {
  openSheet: (node: React.ReactNode) => void;
  closeSheet: () => void;
};

const SheetContext = createContext<SheetContextValue>({ openSheet: () => {}, closeSheet: () => {} });

export function useSheet() {
  return useContext(SheetContext);
}

// Bottom sheet rendered above the navigator; content is any React node.
export function SheetProvider({ children }: { children: React.ReactNode }) {
  const t = useTheme();
  const [content, setContent] = useState<React.ReactNode>(null);

  const openSheet = useCallback((node: React.ReactNode) => setContent(node), []);
  const closeSheet = useCallback(() => setContent(null), []);

  return (
    <SheetContext.Provider value={{ openSheet, closeSheet }}>
      <View style={{ flex: 1 }}>
        {children}
        {content ? (
          <View style={{ position: "absolute", top: 0, left: 0, right: 0, bottom: 0 }}>
            <Pressable style={{ flex: 1, backgroundColor: "rgba(8,30,23,0.45)" }} onPress={closeSheet} />
            <KeyboardAvoidingView behavior={Platform.OS === "ios" ? "padding" : undefined}>
              <View
                style={{
                  backgroundColor: t.colors.card,
                  borderTopLeftRadius: 30,
                  borderTopRightRadius: 30,
                  maxHeight: 640,
                }}
              >
                <View
                  style={{
                    width: 40,
                    height: 4,
                    borderRadius: 99,
                    backgroundColor: t.colors.line,
                    alignSelf: "center",
                    marginTop: 10,
                    marginBottom: 2,
                  }}
                />
                <ScrollView
                  contentContainerStyle={{ paddingHorizontal: 20, paddingTop: 12, paddingBottom: 30 }}
                  keyboardShouldPersistTaps="handled"
                >
                  {content}
                </ScrollView>
              </View>
            </KeyboardAvoidingView>
          </View>
        ) : null}
      </View>
    </SheetContext.Provider>
  );
}
