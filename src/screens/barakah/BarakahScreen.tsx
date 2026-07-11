import React from "react";
import { Pressable, Text, View } from "react-native";
import Svg, { Circle } from "react-native-svg";
import { LinearGradient } from "expo-linear-gradient";
import { useNavigation } from "@react-navigation/native";

import { useTheme } from "@/theme";
import { useApp } from "@/state/AppState";
import { tk } from "@/utils/format";
import { Screen, HRow } from "@/components/chrome";
import { Card, Kicker, Sec, FootDis, IconSq, BodyText } from "@/components/ui";
import { useSheet } from "@/components/Sheet";
import { useToast } from "@/components/Toast";
import { GiveCustomSheet, InfoSheet } from "@/sheets/sheets";

const FEED = [
  {
    ic: "file",
    t: "AAOIFI publishes revised guidance on agency-based investment",
    s: "News · 3 min",
    sheet: {
      title: "AAOIFI publishes revised guidance on agency-based investment",
      sub: "News · why it matters to your Wakalah campaign · 3 min",
    },
  },
  {
    ic: "trend",
    t: "Bangladesh sukuk market grows 22% year on year",
    s: "News · why local halal instruments matter · 4 min",
    sheet: {
      title: "Bangladesh sukuk market grows 22% year on year",
      sub: "Local halal instruments are deepening. More sukuk means more asset-backed choices for BD investors.",
    },
  },
  {
    ic: "book",
    t: "Tip: pay yourself first, the halal way",
    s: "1 data point · 1 hadith · 1 action · 2 min",
    sheet: {
      title: "Pay yourself first, the halal way",
      sub: "Set your saving aside the moment income arrives, before spending finds it. Even ৳10 a day compounds into discipline.",
    },
  },
];

export function BarakahScreen() {
  const t = useTheme();
  const app = useApp();
  const nav = useNavigation<any>();
  const { openSheet } = useSheet();
  const toast = useToast();

  const done = app.s.habits.filter((h) => h.done).length;
  const score = Math.min(100, Math.round(30 + done * 8 + Math.min(20, app.s.streak / 4) + Math.min(10, app.s.given / 300)));
  const tasPct = app.s.tas / 100;

  return (
    <Screen>
      <HRow label="Faith and giving" title="Barakah" onAvatar={() => nav.navigate("MeTab", { screen: "Me" })} />

      <Card solid style={{ alignItems: "center" }}>
        <Kicker style={{ alignSelf: "flex-start" }}>Barakah score</Kicker>
        <View style={{ width: 120, height: 120, marginTop: 6, marginBottom: 2 }}>
          <Svg width={120} height={120} viewBox="0 0 120 120" style={{ transform: [{ rotate: "-90deg" }] }}>
            <Circle cx={60} cy={60} r={52} stroke={t.colors.mint} strokeWidth={8} fill="none" />
            <Circle
              cx={60}
              cy={60}
              r={52}
              stroke={t.colors.teal}
              strokeWidth={8}
              fill="none"
              strokeLinecap="round"
              strokeDasharray={327}
              strokeDashoffset={327 - (327 * score) / 100}
            />
          </Svg>
          <View style={{ position: "absolute", top: 0, left: 0, right: 0, bottom: 0, alignItems: "center", justifyContent: "center" }}>
            <Text style={{ fontFamily: t.fonts.display, fontSize: 28, color: t.colors.ink }}>{score}</Text>
            <Text style={{ fontFamily: t.fonts.body, fontSize: 9, color: t.colors.inkSoft, textTransform: "uppercase", letterSpacing: 0.7 }}>
              consistency
            </Text>
          </View>
        </View>
        <FootDis>
          Measures your habit consistency and good done: streaks, sadaqah, trees. It never measures worship itself.
        </FootDis>
      </Card>

      <LinearGradient
        colors={["#123A2E", "#0A2B21"]}
        start={{ x: 0, y: 0 }}
        end={{ x: 0.8, y: 1 }}
        style={{ borderRadius: 22, padding: 17, marginBottom: 13, alignItems: "center" }}
      >
        <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 10, letterSpacing: 1.2, textTransform: "uppercase", color: "#7FD3B2", marginBottom: 9 }}>
          Morning adhkar · after Fajr
        </Text>
        <Text style={{ fontSize: 21, lineHeight: 38, color: "#E7F4EE", textAlign: "center" }}>سُبْحَانَ اللَّهِ وَبِحَمْدِهِ</Text>
        <Text style={{ fontFamily: t.fonts.body, fontSize: 11, color: "#9FC6B6", marginTop: 7, lineHeight: 16, textAlign: "center" }}>
          SubhanAllahi wa bihamdih. "Glory be to Allah and praise Him." Recite 100 times for sins to be erased, though they be
          like the foam of the sea.
        </Text>
        <Pressable
          onPress={() => {
            const next = Math.min(100, app.s.tas + 1);
            app.set("tas", next);
            if (next === 100) {
              if (!app.s.habits.find((h) => h.id === "azkar")?.done) app.toggleHabit("azkar");
              toast("100 complete, may it be heavy on the scale");
            }
          }}
          style={{ width: 96, height: 96, marginTop: 14 }}
        >
          <Svg width={96} height={96} viewBox="0 0 96 96" style={{ transform: [{ rotate: "-90deg" }] }}>
            <Circle cx={48} cy={48} r={43} stroke="#20503F" strokeWidth={5} fill="none" />
            <Circle
              cx={48}
              cy={48}
              r={43}
              stroke="#2FBD8C"
              strokeWidth={5}
              fill="none"
              strokeLinecap="round"
              strokeDasharray={270}
              strokeDashoffset={270 - 270 * tasPct}
            />
          </Svg>
          <View style={{ position: "absolute", top: 0, left: 0, right: 0, bottom: 0, alignItems: "center", justifyContent: "center" }}>
            <Text style={{ fontFamily: t.fonts.display, fontSize: 24, color: "#E7F4EE" }}>{app.s.tas}</Text>
            <Text style={{ fontFamily: t.fonts.body, fontSize: 8.5, color: "#9FC6B6", textTransform: "uppercase", letterSpacing: 0.7 }}>
              of 100 · tap
            </Text>
          </View>
        </Pressable>
      </LinearGradient>

      <Card>
        <Kicker>Daily sadaqah</Kicker>
        <Sec>Give before the day gives to you</Sec>
        <View style={{ flexDirection: "row", gap: 8, marginTop: 4 }}>
          {[10, 20, 50].map((a) => (
            <Pressable
              key={a}
              onPress={() => {
                app.give(a);
                toast(tk(a) + " given. May it be accepted");
              }}
              style={{
                flex: 1,
                alignItems: "center",
                paddingVertical: 12,
                borderRadius: 11,
                borderWidth: 1.5,
                borderColor: t.colors.line,
                backgroundColor: t.colors.mintSoft,
              }}
            >
              <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12.5, color: t.colors.teal }}>{tk(a)}</Text>
            </Pressable>
          ))}
          <Pressable
            onPress={() => openSheet(<GiveCustomSheet />)}
            style={{
              flex: 1,
              alignItems: "center",
              paddingVertical: 12,
              borderRadius: 11,
              borderWidth: 1.5,
              borderColor: t.colors.line,
              backgroundColor: t.colors.mintSoft,
            }}
          >
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12.5, color: t.colors.teal }}>Other</Text>
          </Pressable>
        </View>
        <View style={{ flexDirection: "row", gap: 9, marginTop: 11 }}>
          {[
            ["Given this year", tk(app.s.given)],
            ["Meals funded", String(app.s.meals)],
          ].map(([l, v]) => (
            <View key={l} style={{ flex: 1, backgroundColor: t.colors.mintSoft, borderWidth: 1, borderColor: t.colors.line, borderRadius: 11, paddingVertical: 9, paddingHorizontal: 11 }}>
              <Text style={{ fontFamily: t.fonts.body, fontSize: 9.5, color: t.colors.inkSoft, textTransform: "uppercase", letterSpacing: 0.5 }}>{l}</Text>
              <Text style={{ fontFamily: t.fonts.display, fontSize: 16, color: t.colors.teal, marginTop: 1 }}>{v}</Text>
            </View>
          ))}
        </View>
      </Card>

      <Card>
        <Kicker>Knowledge Hub</Kicker>
        <View style={{ marginTop: 8 }}>
          {FEED.map((f, i) => (
            <Pressable
              key={i}
              onPress={() =>
                openSheet(
                  <InfoSheet
                    title={f.sheet.title}
                    sub={f.sheet.sub}
                    items={[
                      { ic: "file", bold: "Why it matters", text: "· plain-language context for your halal portfolio." },
                      { ic: "check", bold: "One action", text: "· read the per-contract Shariah note before your next commitment." },
                    ]}
                  />
                )
              }
              style={{
                flexDirection: "row",
                gap: 11,
                paddingVertical: 12,
                borderBottomWidth: i < FEED.length - 1 ? 1 : 0,
                borderBottomColor: t.colors.mintSoft,
                alignItems: "flex-start",
              }}
            >
              <IconSq name={f.ic} size={40} iconSize={16} radius={12} color={t.colors.teal} />
              <View style={{ flex: 1 }}>
                <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12, color: t.colors.ink, lineHeight: 16 }}>{f.t}</Text>
                <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft, marginTop: 2 }}>{f.s}</Text>
              </View>
            </Pressable>
          ))}
        </View>
      </Card>

      <Card>
        <Kicker>This month's habits</Kicker>
        <Sec>July consistency</Sec>
        <View style={{ flexDirection: "row", flexWrap: "wrap", gap: 7 }}>
          {Array.from({ length: 30 }, (_, idx) => {
            const d = idx + 1;
            const today = 7;
            const filled = (d < today && d % 4 !== 0) || (d === today && done === 5);
            return (
              <View
                key={d}
                style={{ width: 22, height: 22, borderRadius: 11, backgroundColor: filled ? t.colors.green : t.colors.mint }}
              />
            );
          })}
        </View>
        <FootDis left>
          A dot fills green when you complete all five daily activities. Today updates live from your checklist.
        </FootDis>
      </Card>

      <Card
        onPress={() =>
          openSheet(
            <InfoSheet
              title="Ribh Welfare"
              sub="The non-profit arm of Ribh Capital Group. It researches and builds halal financial literacy across the Muslim population, so people can tell real halal finance from what only looks halal."
              items={[
                { ic: "graduation", bold: "Literacy programs", text: "· free lessons, khutbah resources, and workshops on riba-free finance." },
                { ic: "file", bold: "Research", text: "· plain-language explainers on contracts, Zakat, and inheritance." },
                { ic: "users", bold: "Community", text: "· Qard Hasan hardship support, with published accounts." },
              ]}
              footer="4,100 people taught · 36 free lessons"
            />
          )
        }
      >
        <Kicker>Ribh Welfare</Kicker>
        <Sec style={{ marginBottom: 2 }}>Financial literacy for the ummah</Sec>
        <BodyText>Ribh Capital Group's non-profit arm, researching and building halal financial literacy.</BodyText>
      </Card>
    </Screen>
  );
}
