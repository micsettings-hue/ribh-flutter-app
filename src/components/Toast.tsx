import React, { createContext, useCallback, useContext, useRef, useState } from "react";
import { Animated, Text, View } from "react-native";

import { useTheme } from "@/theme";

const ToastContext = createContext<(msg: string) => void>(() => {});

export function useToast() {
  return useContext(ToastContext);
}

export function ToastProvider({ children }: { children: React.ReactNode }) {
  const t = useTheme();
  const [msg, setMsg] = useState("");
  const opacity = useRef(new Animated.Value(0)).current;
  const timer = useRef<ReturnType<typeof setTimeout> | null>(null);

  const show = useCallback(
    (m: string) => {
      setMsg(m);
      if (timer.current) clearTimeout(timer.current);
      Animated.timing(opacity, { toValue: 1, duration: 200, useNativeDriver: true }).start();
      timer.current = setTimeout(() => {
        Animated.timing(opacity, { toValue: 0, duration: 250, useNativeDriver: true }).start();
      }, 2100);
    },
    [opacity]
  );

  return (
    <ToastContext.Provider value={show}>
      <View style={{ flex: 1 }}>
        {children}
        <Animated.View
          pointerEvents="none"
          style={{
            position: "absolute",
            bottom: 96,
            alignSelf: "center",
            maxWidth: "90%",
            opacity,
            backgroundColor: "#0C2C22",
            borderRadius: 999,
            paddingHorizontal: 17,
            paddingVertical: 11,
          }}
        >
          <Text numberOfLines={1} style={{ fontFamily: t.fonts.bodyMedium, fontSize: 12, color: "#E7F4EE" }}>
            {msg}
          </Text>
        </Animated.View>
      </View>
    </ToastContext.Provider>
  );
}
