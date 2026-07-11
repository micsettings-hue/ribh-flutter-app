import React from "react";
import { Pressable, StyleProp, Text, TextStyle, View, ViewStyle } from "react-native";

import { useTheme } from "@/theme";
import { Icon } from "./Icon";

// Flat card: transparent with a hairline bottom border (prototype v0.7 style).
// Solid card: elevated white/dark card with border and radius.
export function Card({
  solid,
  children,
  onPress,
  style,
}: {
  solid?: boolean;
  children: React.ReactNode;
  onPress?: () => void;
  style?: StyleProp<ViewStyle>;
}) {
  const t = useTheme();
  const base: ViewStyle = solid
    ? {
        backgroundColor: t.colors.card,
        borderWidth: 1,
        borderColor: t.colors.line,
        borderRadius: t.radii.xl,
        padding: 16,
        marginBottom: t.spacing.md,
      }
    : {
        paddingVertical: 16,
        borderBottomWidth: 1,
        borderBottomColor: t.colors.line,
      };
  if (onPress) {
    return (
      <Pressable onPress={onPress} style={({ pressed }) => [base, pressed && { opacity: 0.85 }, style]}>
        {children}
      </Pressable>
    );
  }
  return <View style={[base, style]}>{children}</View>;
}

// The ".k" kicker: small uppercase tracked label.
export function Kicker({ children, color, style }: { children: React.ReactNode; color?: string; style?: StyleProp<TextStyle> }) {
  const t = useTheme();
  return (
    <Text
      style={[
        {
          fontFamily: t.fonts.bodySemi,
          fontSize: 10.5,
          letterSpacing: 1.4,
          textTransform: "uppercase",
          color: color ?? t.colors.inkSoft,
        },
        style,
      ]}
    >
      {children}
    </Text>
  );
}

// "h3.sec" section title.
export function Sec({ children, style }: { children: React.ReactNode; style?: StyleProp<TextStyle> }) {
  const t = useTheme();
  return (
    <Text style={[{ fontFamily: t.fonts.display, fontSize: 16, color: t.colors.ink, marginTop: 2, marginBottom: 10 }, style]}>
      {children}
    </Text>
  );
}

export function Pill({ kind, label }: { kind: "open" | "matured" | "recovery" | "contract"; label: string }) {
  const t = useTheme();
  const dark = t.mode === "dark";
  const styles: Record<string, { color: string; bg: string; borderColor?: string }> = {
    open: { color: dark ? "#7fe0b8" : "#0a5c40", bg: dark ? "#123a2c" : "#d6f2e6" },
    matured: { color: dark ? "#e8c877" : "#6a5a2a", bg: t.colors.goldSoft },
    recovery: { color: t.colors.danger, bg: t.colors.dangerSoft },
    contract: { color: t.colors.inkSoft, bg: "transparent", borderColor: t.colors.line },
  };
  const s = styles[kind];
  return (
    <View
      style={{
        alignSelf: "flex-start",
        backgroundColor: s.bg,
        borderRadius: 999,
        paddingHorizontal: 8,
        paddingVertical: 3,
        borderWidth: s.borderColor ? 1 : 0,
        borderColor: s.borderColor,
      }}
    >
      <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 10, color: s.color }}>{label}</Text>
    </View>
  );
}

export function Btn({
  kind = "pri",
  label,
  icon,
  onPress,
  disabled,
  style,
}: {
  kind?: "pri" | "ghost";
  label: string;
  icon?: string;
  onPress?: () => void;
  disabled?: boolean;
  style?: StyleProp<ViewStyle>;
}) {
  const t = useTheme();
  const pri = kind === "pri";
  const bg = pri ? (disabled ? (t.mode === "dark" ? "#22503F" : "#A9D8C6") : t.colors.teal) : t.colors.card;
  const fg = pri ? (disabled && t.mode === "dark" ? "#6F9A89" : t.colors.white) : t.colors.teal;
  return (
    <Pressable
      onPress={disabled ? undefined : onPress}
      style={({ pressed }) => [
        {
          flexDirection: "row",
          alignItems: "center",
          justifyContent: "center",
          gap: 8,
          borderRadius: 15,
          paddingVertical: 15,
          minHeight: 48,
          backgroundColor: bg,
          borderWidth: pri ? 0 : 1.5,
          borderColor: t.colors.line,
        },
        pressed && !disabled && { opacity: 0.88 },
        style,
      ]}
    >
      {icon ? <Icon name={icon} size={16} color={fg} /> : null}
      <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 14, color: fg }}>{label}</Text>
    </Pressable>
  );
}

export function ProgressBar({
  pct,
  height = 5,
  bad,
  style,
}: {
  pct: number;
  height?: number;
  bad?: boolean;
  style?: StyleProp<ViewStyle>;
}) {
  const t = useTheme();
  return (
    <View style={[{ height, backgroundColor: t.colors.mint, borderRadius: 999, overflow: "hidden" }, style]}>
      <View
        style={{
          width: `${Math.min(100, Math.max(0, pct))}%`,
          height: "100%",
          backgroundColor: bad ? t.colors.danger : t.colors.green,
          borderRadius: 999,
        }}
      />
    </View>
  );
}

// The ".sw2" pill switch.
export function Sw2({ on, onToggle }: { on: boolean; onToggle: () => void }) {
  const t = useTheme();
  return (
    <Pressable
      onPress={onToggle}
      style={{
        width: 42,
        height: 24,
        borderRadius: 99,
        backgroundColor: on ? t.colors.teal : t.colors.line,
        justifyContent: "center",
      }}
    >
      <View
        style={{
          width: 18,
          height: 18,
          borderRadius: 9,
          backgroundColor: t.colors.white,
          marginLeft: on ? 21 : 3,
        }}
      />
    </Pressable>
  );
}

// Square mint icon tile used across lists.
export function IconSq({
  name,
  size = 36,
  iconSize = 17,
  color,
  bg,
  radius = 13,
}: {
  name: string;
  size?: number;
  iconSize?: number;
  color?: string;
  bg?: string;
  radius?: number;
}) {
  const t = useTheme();
  return (
    <View
      style={{
        width: size,
        height: size,
        borderRadius: radius,
        backgroundColor: bg ?? t.colors.mint,
        alignItems: "center",
        justifyContent: "center",
      }}
    >
      <Icon name={name} size={iconSize} color={color ?? (t.mode === "dark" ? t.colors.green : t.colors.tealDeep)} />
    </View>
  );
}

// ".foot-dis" footer disclaimer.
export function FootDis({ children, left }: { children: React.ReactNode; left?: boolean }) {
  const t = useTheme();
  return (
    <Text
      style={{
        fontFamily: t.fonts.body,
        fontSize: 9.5,
        color: t.colors.inkSoft,
        textAlign: left ? "left" : "center",
        lineHeight: 15,
        marginTop: 8,
        paddingHorizontal: left ? 0 : 8,
      }}
    >
      {children}
    </Text>
  );
}

// ".seeall" header row: kicker on the left, teal link on the right.
export function SeeAll({ label, linkLabel, onPress }: { label: string; linkLabel?: string; onPress?: () => void }) {
  const t = useTheme();
  return (
    <View style={{ flexDirection: "row", justifyContent: "space-between", alignItems: "baseline", marginBottom: 9 }}>
      <Kicker>{label}</Kicker>
      {linkLabel ? (
        <Pressable onPress={onPress} hitSlop={8}>
          <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 11, color: t.colors.teal }}>{linkLabel}</Text>
        </Pressable>
      ) : null}
    </View>
  );
}

export function Empty({ children }: { children: React.ReactNode }) {
  const t = useTheme();
  return (
    <Text
      style={{
        fontFamily: t.fonts.body,
        fontSize: 12,
        color: t.colors.inkSoft,
        textAlign: "center",
        lineHeight: 19,
        paddingVertical: 26,
        paddingHorizontal: 12,
      }}
    >
      {children}
    </Text>
  );
}

// Small body text helpers.
export function BodyText({ children, style }: { children: React.ReactNode; style?: StyleProp<TextStyle> }) {
  const t = useTheme();
  return <Text style={[{ fontFamily: t.fonts.body, fontSize: 11.5, color: t.colors.inkSoft, lineHeight: 17 }, style]}>{children}</Text>;
}
