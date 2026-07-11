import React from "react";
import { Pressable, Text, View } from "react-native";

import { useTheme } from "@/theme";
import { Goal } from "@/state/AppState";
import { tk } from "@/utils/format";
import { IconSq, ProgressBar } from "./ui";

export function GoalRow({ goal, onPress, last }: { goal: Goal; onPress: () => void; last?: boolean }) {
  const t = useTheme();
  const pct = Math.min(100, Math.round((goal.saved / goal.target) * 100));
  return (
    <Pressable
      onPress={onPress}
      style={{
        flexDirection: "row",
        alignItems: "center",
        gap: 12,
        paddingVertical: 11,
        borderBottomWidth: last ? 0 : 1,
        borderBottomColor: t.colors.mintSoft,
      }}
    >
      <IconSq name={goal.ic} size={38} iconSize={17} radius={12} />
      <View style={{ flex: 1, minWidth: 0 }}>
        <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12.5, color: t.colors.ink }}>{goal.t}</Text>
        <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft, marginTop: 1 }}>
          {tk(goal.saved)} of {tk(goal.target)}
        </Text>
        <ProgressBar pct={pct} height={6} style={{ marginTop: 6 }} />
      </View>
      <Text style={{ fontFamily: t.fonts.bodyBold, fontSize: 11, color: t.colors.teal }}>{pct}%</Text>
    </Pressable>
  );
}
