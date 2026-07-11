import React from "react";
import { Pressable, ScrollView, Text, View } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { LinearGradient } from "expo-linear-gradient";
import { useNavigation } from "@react-navigation/native";

import { useTheme } from "@/theme";
import { Icon } from "./Icon";

export function Screen({ children }: { children: React.ReactNode }) {
  const t = useTheme();
  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: t.colors.paper }} edges={["top"]}>
      <ScrollView
        contentContainerStyle={{ paddingHorizontal: 20, paddingTop: 16, paddingBottom: 40 }}
        showsVerticalScrollIndicator={false}
        keyboardShouldPersistTaps="handled"
      >
        {children}
      </ScrollView>
    </SafeAreaView>
  );
}

export function Avatar({ onPress }: { onPress?: () => void }) {
  const t = useTheme();
  return (
    <Pressable onPress={onPress}>
      <LinearGradient
        colors={[t.colors.green, t.colors.tealDeep]}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
        style={{ width: 40, height: 40, borderRadius: 14, alignItems: "center", justifyContent: "center" }}
      >
        <Text style={{ fontFamily: t.fonts.display, fontSize: 17, color: t.colors.white }}>M</Text>
      </LinearGradient>
    </Pressable>
  );
}

// Screen header: small label over a display-weight title, avatar (and optional bell) on the right.
export function HRow({
  label,
  title,
  hijri,
  onBell,
  bellDot,
  onAvatar,
}: {
  label: string;
  title: string;
  hijri?: string;
  onBell?: () => void;
  bellDot?: boolean;
  onAvatar?: () => void;
}) {
  const t = useTheme();
  return (
    <View style={{ flexDirection: "row", alignItems: "center", justifyContent: "space-between", marginBottom: 14 }}>
      <View>
        <Text style={{ fontFamily: t.fonts.body, fontSize: 13, color: t.colors.inkSoft }}>{label}</Text>
        <Text style={{ fontFamily: t.fonts.display, fontSize: 21, color: t.colors.ink, letterSpacing: -0.3 }}>
          {title}
        </Text>
        {hijri ? (
          <Text style={{ fontFamily: t.fonts.bodyMedium, fontSize: 10.5, color: t.colors.inkSoft, marginTop: 1 }}>
            {hijri}
          </Text>
        ) : null}
      </View>
      <View style={{ flexDirection: "row", gap: 8, alignItems: "center" }}>
        {onBell ? (
          <Pressable
            onPress={onBell}
            style={{
              width: 44,
              height: 44,
              borderRadius: 14,
              backgroundColor: t.colors.card,
              borderWidth: 1,
              borderColor: t.colors.line,
              alignItems: "center",
              justifyContent: "center",
            }}
          >
            <Icon name="bell" size={20} color={t.colors.ink} />
            {bellDot ? (
              <View
                style={{
                  position: "absolute",
                  top: 8,
                  right: 9,
                  width: 8,
                  height: 8,
                  borderRadius: 4,
                  backgroundColor: "#E05A4A",
                }}
              />
            ) : null}
          </Pressable>
        ) : null}
        <Avatar onPress={onAvatar} />
      </View>
    </View>
  );
}

export function BackBtn({ label }: { label: string }) {
  const t = useTheme();
  const navigation = useNavigation();
  return (
    <Pressable
      onPress={() => navigation.goBack()}
      style={{ flexDirection: "row", alignItems: "center", gap: 6, paddingVertical: 8, marginBottom: 10, alignSelf: "flex-start" }}
    >
      <Icon name="chevl" size={15} color={t.colors.teal} />
      <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 13, color: t.colors.teal }}>{label}</Text>
    </Pressable>
  );
}
