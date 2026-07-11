import React from "react";
import { Pressable, ScrollView, Text, View } from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import Svg, { Polyline, Circle } from "react-native-svg";
import { useNavigation } from "@react-navigation/native";

import { useTheme } from "@/theme";
import { useApp } from "@/state/AppState";
import { CAMPS, PRAYERS, SPARK_DATA } from "@/state/data";
import { tk } from "@/utils/format";
import { Screen, HRow } from "@/components/chrome";
import { Icon } from "@/components/Icon";
import { Card, Kicker, Sec, Pill, ProgressBar, FootDis, SeeAll, IconSq } from "@/components/ui";
import { GoalRow } from "@/components/GoalRow";
import { useSheet } from "@/components/Sheet";
import { useToast } from "@/components/Toast";
import { DepositSheet, WithdrawSheet, NotifsSheet, QiblaSheet, KycSheet, InfoSheet } from "@/sheets/sheets";

function Sparkline() {
  const max = Math.max(...SPARK_DATA);
  const min = Math.min(...SPARK_DATA);
  const W = 300;
  const H = 38;
  const pad = 3;
  const pts = SPARK_DATA.map((v, i) => {
    const x = pad + i * ((W - 2 * pad) / (SPARK_DATA.length - 1));
    const y = H - pad - ((v - min) / (max - min || 1)) * (H - 2 * pad);
    return `${x.toFixed(1)},${y.toFixed(1)}`;
  });
  const [lx, ly] = pts[pts.length - 1].split(",");
  return (
    <Svg viewBox={`0 0 ${W} ${H}`} width="100%" height={38}>
      <Polyline points={pts.join(" ")} fill="none" stroke="#7BE6BE" strokeWidth={2} strokeLinecap="round" strokeLinejoin="round" />
      <Circle cx={lx} cy={ly} r={2.6} fill="#fff" />
    </Svg>
  );
}

function PrayerStrip() {
  const t = useTheme();
  const now = new Date();
  const mins = now.getHours() * 60 + now.getMinutes();
  let active = PRAYERS.length - 1;
  for (let i = 0; i < PRAYERS.length; i++) if (mins >= PRAYERS[i].m) active = i;
  if (mins < PRAYERS[0].m) active = PRAYERS.length - 1;
  const next = PRAYERS.find((p) => p.m > mins) ?? PRAYERS[0];
  let diff = next.m - mins;
  if (diff < 0) diff += 1440;

  return (
    <View>
      <View style={{ flexDirection: "row", gap: 6, marginTop: 9 }}>
        {PRAYERS.map((p, i) => {
          const on = i === active;
          return (
            <View
              key={p.n}
              style={{
                flex: 1,
                alignItems: "center",
                paddingVertical: 10,
                borderRadius: 13,
                borderWidth: 1,
                borderColor: on ? t.colors.teal : t.colors.line,
                backgroundColor: on ? t.colors.teal : "transparent",
              }}
            >
              <Icon name={p.ic} size={16} color={on ? t.colors.white : t.colors.teal} />
              <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 9.5, color: on ? "#DFF3EA" : t.colors.inkSoft, marginTop: 4 }}>
                {p.n}
              </Text>
              <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 11, color: on ? t.colors.white : t.colors.ink, marginTop: 2 }}>
                {p.t}
              </Text>
            </View>
          );
        })}
      </View>
      <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft, textAlign: "center", marginTop: 9 }}>
        {next.n} in {Math.floor(diff / 60)}h {diff % 60}m · notifications pause around each prayer
      </Text>
    </View>
  );
}

const FLOW_STEPS = [
  { ic: "wallet", label: "Wallet", hit: true },
  { ic: "building", label: "Supplier paid", hit: true },
  { ic: "box", label: "Goods with merchant", hit: true },
  { ic: "arrdown", label: "Repayment", hit: false },
  { ic: "sprout", label: "Profit", hit: false },
];

export function HomeScreen() {
  const t = useTheme();
  const app = useApp();
  const nav = useNavigation<any>();
  const { openSheet } = useSheet();
  const toast = useToast();

  const total = app.s.avail + app.s.deployed;
  const habitsDone = app.s.habits.filter((h) => h.done).length;
  const openCamps = CAMPS.filter((c) => c.status === "open");

  const heroAct = (bg: string, fg: string, icon: string, label: string, onPress: () => void, border?: boolean) => (
    <Pressable
      key={label}
      onPress={onPress}
      style={{
        flex: 1,
        flexDirection: "row",
        alignItems: "center",
        justifyContent: "center",
        gap: 6,
        borderRadius: 999,
        paddingVertical: 10,
        minHeight: 40,
        backgroundColor: bg,
        borderWidth: border ? 1 : 0,
        borderColor: "rgba(255,255,255,0.3)",
      }}
    >
      <Icon name={icon} size={15} color={fg} />
      <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 11.5, color: fg }}>{label}</Text>
    </Pressable>
  );

  return (
    <Screen>
      <HRow
        label="As-salamu alaykum,"
        title="Muzahid"
        hijri="21 Muharram 1448"
        onBell={() => openSheet(<NotifsSheet />)}
        bellDot={!app.s.notifRead}
        onAvatar={() => nav.navigate("MeTab", { screen: "Me" })}
      />

      {!app.s.kyc ? (
        <Pressable
          onPress={() => openSheet(<KycSheet onDone={() => app.set("kyc", true)} />)}
          style={{
            flexDirection: "row",
            gap: 10,
            alignItems: "center",
            backgroundColor: t.colors.amberSoft,
            borderWidth: 1,
            borderColor: t.mode === "dark" ? "#5A4A1A" : "#EFD9A6",
            borderRadius: 15,
            padding: 13,
            marginBottom: 13,
          }}
        >
          <Icon name="id" size={20} color={t.colors.amber} />
          <Text style={{ flex: 1, fontFamily: t.fonts.body, fontSize: 12, color: t.colors.amber, lineHeight: 17 }}>
            <Text style={{ fontFamily: t.fonts.bodySemi }}>Complete verification (NID)</Text>
            {"\n"}Required before your next deposit · Tier 1 of 2 · tap to verify
          </Text>
        </Pressable>
      ) : (
        <View
          style={{
            flexDirection: "row",
            gap: 10,
            alignItems: "center",
            backgroundColor: t.colors.mint,
            borderWidth: 1,
            borderColor: t.colors.line,
            borderRadius: 15,
            padding: 13,
            marginBottom: 13,
          }}
        >
          <Icon name="check" size={20} color={t.colors.teal} />
          <Text style={{ flex: 1, fontFamily: t.fonts.body, fontSize: 12, color: t.colors.teal }}>
            <Text style={{ fontFamily: t.fonts.bodySemi }}>Identity verified</Text> · Tier 2 · deposits enabled
          </Text>
        </View>
      )}

      <LinearGradient
        colors={[t.colors.heroFrom, t.colors.heroMid, t.colors.heroTo]}
        start={{ x: 0, y: 0 }}
        end={{ x: 0.9, y: 1.2 }}
        style={{ borderRadius: 22, padding: 17, marginBottom: 13, borderWidth: 1, borderColor: "rgba(255,255,255,0.09)" }}
      >
        <View style={{ flexDirection: "row", justifyContent: "space-between", alignItems: "center" }}>
          <Kicker color="#9FDCC4">Your Amanah with Ribh</Kicker>
          <Pressable onPress={() => nav.navigate("HomeTab", { screen: "Wallet" })} hitSlop={8}>
            <Text style={{ fontFamily: t.fonts.body, fontSize: 11, color: "#9FDCC4", textDecorationLine: "underline" }}>Ledger</Text>
          </Pressable>
        </View>
        <Text style={{ fontFamily: t.fonts.display, fontSize: 34, color: t.colors.white, textAlign: "center", marginTop: 6 }}>
          <Text style={{ fontSize: 19 }}>৳</Text>
          {tk(total).slice(1)}
        </Text>
        <Text style={{ fontFamily: t.fonts.body, fontSize: 11.5, color: "#BFE6D7", textAlign: "center", marginTop: 2 }}>
          Total portfolio · profit to date ৳21,300
        </Text>
        <View style={{ marginTop: 12 }}>
          <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 9.5, color: "#9FDCC4", textTransform: "uppercase", letterSpacing: 0.8 }}>
            Profit received · last 6 months
          </Text>
          <Sparkline />
        </View>
        <View style={{ flexDirection: "row", gap: 8, marginTop: 14 }}>
          {[
            ["Available", tk(app.s.avail)],
            ["Deployed", tk(app.s.deployed)],
            ["In recovery", tk(app.s.inRecovery)],
          ].map(([l, v]) => (
            <View key={l} style={{ flex: 1, backgroundColor: "rgba(255,255,255,0.1)", borderRadius: 10, paddingVertical: 8, alignItems: "center" }}>
              <Text style={{ fontFamily: t.fonts.body, fontSize: 9.5, color: "#9FDCC4", textTransform: "uppercase", letterSpacing: 0.5 }}>{l}</Text>
              <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 13, color: t.colors.white, marginTop: 1 }}>{v}</Text>
            </View>
          ))}
        </View>
        <View style={{ flexDirection: "row", gap: 8, marginTop: 13 }}>
          {heroAct("#FFFFFF", "#0F6E56", "arrdown", "Add funds", () => openSheet(<DepositSheet />))}
          {heroAct("rgba(255,255,255,0.14)", "#FFFFFF", "arrup", "Withdraw", () => openSheet(<WithdrawSheet />), true)}
          {heroAct("rgba(255,255,255,0.14)", "#FFFFFF", "trend", "Invest", () => nav.navigate("InvestTab", { screen: "Invest" }), true)}
        </View>
        <View style={{ flexDirection: "row", gap: 6, justifyContent: "center", alignItems: "center", marginTop: 12 }}>
          <Icon name="shield" size={13} color="#9FDCC4" />
          <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: "#9FDCC4" }}>Books balanced · reconciled today, 6:00 AM</Text>
        </View>
      </LinearGradient>

      <View style={{ flexDirection: "row", gap: 9, marginBottom: 13 }}>
        {[
          ["scale", "Zakat", () => nav.navigate("GrowTab", { screen: "Grow" })],
          ["heart", "Sadaqah", () => nav.navigate("BarakahTab", { screen: "Barakah" })],
          [
            "file",
            "Statements",
            () =>
              openSheet(
                <InfoSheet
                  title="Statements and receipts"
                  sub="Zakat-ready annual summary and per-transaction receipts, exported from the signed ledger."
                  items={[
                    { ic: "file", bold: "Annual statement 2026", text: "· zakatable holdings summarized, dated and labelled." },
                    { ic: "file", bold: "Transaction receipts", text: "· every signed ledger entry, exportable as PDF." },
                  ]}
                  footer="Read-only views of the append-only ledger; never editable."
                />
              ),
          ],
          [
            "gift",
            "Invite",
            () =>
              openSheet(
                <InfoSheet
                  title="Invite a friend"
                  sub="Share your code MUZAHID26. When a friend verifies and makes a first deposit, you both plant a tree."
                  items={[
                    { ic: "users", bold: "3 friends joined", text: "· 2 trees planted in Nilphamari so far." },
                    { ic: "sprout", bold: "Reward", text: "· a tree each, sadaqah jariyah in both names. Never framed as a return." },
                  ]}
                />
              ),
          ],
        ].map(([icn, label, fn]) => (
          <Pressable
            key={label as string}
            onPress={fn as () => void}
            style={{ flex: 1, alignItems: "center", gap: 6, paddingVertical: 12, borderRadius: 16 }}
          >
            <IconSq name={icn as string} size={34} iconSize={17} radius={11} bg={t.colors.mintSoft} />
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 10.5, color: t.colors.ink }}>{label as string}</Text>
          </Pressable>
        ))}
      </View>

      <Card>
        <SeeAll label="Your goals" linkLabel="See all" onPress={() => nav.navigate("GrowTab", { screen: "Grow" })} />
        {app.s.goals.slice(0, 2).map((g, i) => (
          <GoalRow key={g.id} goal={g} last={i === 1} onPress={() => nav.navigate("GrowTab", { screen: "Grow" })} />
        ))}
      </Card>

      <View style={{ marginTop: 16 }}>
        <SeeAll label="Open campaigns" linkLabel="See all" onPress={() => nav.navigate("InvestTab", { screen: "Invest" })} />
        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginHorizontal: -20 }} contentContainerStyle={{ paddingHorizontal: 20, gap: 11 }}>
          {openCamps.map((c) => {
            const pct = Math.min(100, Math.round((c.raised / c.pool) * 100));
            return (
              <Pressable
                key={c.id}
                onPress={() => nav.navigate("InvestTab", { screen: "CampaignDetail", params: { campId: c.id } })}
                style={{
                  width: 280,
                  backgroundColor: t.colors.card,
                  borderWidth: 1,
                  borderColor: t.colors.line,
                  borderRadius: 15,
                  padding: 13,
                }}
              >
                <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12.5, color: t.colors.ink, lineHeight: 16 }} numberOfLines={2}>
                  {c.title}
                </Text>
                <View style={{ marginTop: 7 }}>
                  <Pill kind="contract" label={c.contract} />
                </View>
                <View style={{ flexDirection: "row", gap: 10, marginTop: 9 }}>
                  <Text style={{ fontFamily: t.fonts.body, fontSize: 10, color: t.colors.inkSoft }}>
                    Profit/lac <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.ink }}>{tk(c.ppl)}</Text>
                  </Text>
                  <Text style={{ fontFamily: t.fonts.body, fontSize: 10, color: t.colors.inkSoft }}>
                    Tenure <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.ink }}>{c.tenure}d</Text>
                  </Text>
                  <Text style={{ fontFamily: t.fonts.body, fontSize: 10, color: t.colors.inkSoft }}>
                    <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.ink }}>{pct}%</Text> funded
                  </Text>
                </View>
                <ProgressBar pct={pct} style={{ marginTop: 10 }} />
                <View style={{ flexDirection: "row", justifyContent: "space-between", alignItems: "center", marginTop: 10 }}>
                  <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 11, color: t.colors.teal }}>
                    {c.investors} investors · {c.daysLeft}d left
                  </Text>
                  <Icon name="chev" size={14} color={t.colors.teal} />
                </View>
              </Pressable>
            );
          })}
        </ScrollView>
      </View>

      <Card onPress={() => nav.navigate("HomeTab", { screen: "Wallet" })} style={{ marginTop: 4 }}>
        <Kicker>Where's my money?</Kicker>
        <Sec style={{ marginBottom: 12 }}>৳1,00,000 · Printing Zone (Wakalah)</Sec>
        <View style={{ flexDirection: "row" }}>
          {FLOW_STEPS.map((s, i) => (
            <View key={s.label} style={{ flex: 1, alignItems: "center" }}>
              <View
                style={{
                  width: 28,
                  height: 28,
                  borderRadius: 9,
                  alignItems: "center",
                  justifyContent: "center",
                  backgroundColor: s.hit ? t.colors.teal : t.colors.mint,
                  borderWidth: 1.5,
                  borderColor: s.hit ? t.colors.teal : t.colors.line,
                  marginBottom: 5,
                }}
              >
                <Icon name={s.ic} size={14} color={s.hit ? t.colors.white : t.colors.teal} />
              </View>
              {i < FLOW_STEPS.length - 1 ? (
                <View
                  style={{
                    position: "absolute",
                    top: 14,
                    left: "50%",
                    marginLeft: 16,
                    right: -16,
                    height: 2,
                    backgroundColor: s.hit && FLOW_STEPS[i + 1].hit ? t.colors.green : t.colors.line,
                  }}
                />
              ) : null}
              <Text style={{ fontFamily: t.fonts.body, fontSize: 9, color: t.colors.inkSoft, textAlign: "center", lineHeight: 11 }}>
                {s.label}
              </Text>
            </View>
          ))}
        </View>
      </Card>

      <Card>
        <View style={{ flexDirection: "row", justifyContent: "space-between", alignItems: "center" }}>
          <Kicker>Prayer times · Dhaka</Kicker>
          <Pressable onPress={() => openSheet(<QiblaSheet />)} hitSlop={8}>
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 11, color: t.colors.teal }}>Qibla</Text>
          </Pressable>
        </View>
        <PrayerStrip />
      </Card>

      <Card>
        <View style={{ flexDirection: "row", justifyContent: "space-between", alignItems: "baseline" }}>
          <Kicker>Daily activity</Kicker>
          <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 11, color: t.colors.teal }}>{habitsDone} of 5</Text>
        </View>
        <ProgressBar pct={(habitsDone / 5) * 100} height={7} style={{ marginTop: 9 }} />
        <View style={{ marginTop: 5 }}>
          {app.s.habits.map((h, i) => (
            <Pressable
              key={h.id}
              onPress={() => {
                app.toggleHabit(h.id);
                if (!h.done) toast("Alhamdulillah, checked off");
              }}
              style={{
                flexDirection: "row",
                alignItems: "center",
                gap: 11,
                paddingVertical: 10,
                borderBottomWidth: i < app.s.habits.length - 1 ? 1 : 0,
                borderBottomColor: t.colors.mintSoft,
              }}
            >
              <IconSq name={h.ic} size={32} iconSize={15} radius={10} color={t.colors.teal} />
              <View style={{ flex: 1 }}>
                <Text
                  style={{
                    fontFamily: t.fonts.bodySemi,
                    fontSize: 12.5,
                    color: h.done ? t.colors.inkSoft : t.colors.ink,
                    textDecorationLine: h.done ? "line-through" : "none",
                  }}
                >
                  {h.t}
                </Text>
                <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft }}>{h.s}</Text>
              </View>
              <View
                style={{
                  width: 24,
                  height: 24,
                  borderRadius: 12,
                  borderWidth: 2,
                  borderColor: h.done ? t.colors.teal : t.colors.line,
                  backgroundColor: h.done ? t.colors.teal : "transparent",
                  alignItems: "center",
                  justifyContent: "center",
                }}
              >
                {h.done ? <Icon name="check" size={13} color={t.colors.white} /> : null}
              </View>
            </Pressable>
          ))}
        </View>
      </Card>

      <Card>
        <SeeAll label="Knowledge Hub" linkLabel="See all" onPress={() => nav.navigate("BarakahTab", { screen: "Barakah" })} />
        <Pressable
          onPress={() =>
            openSheet(
              <InfoSheet
                title="AAOIFI publishes revised guidance on agency-based investment"
                sub="News · why it matters to your Wakalah campaign · 3 min"
                items={[
                  { ic: "file", bold: "What changed", text: "· clarified disclosure duties for the agent (Wakil) and fee transparency." },
                  { ic: "shield", bold: "Why it matters", text: "· Ribh's Wakalah campaigns already disclose fee and projection basis up front." },
                ]}
              />
            )
          }
          style={{ flexDirection: "row", gap: 11, alignItems: "flex-start" }}
        >
          <IconSq name="file" size={40} iconSize={16} radius={12} color={t.colors.teal} />
          <View style={{ flex: 1 }}>
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12, color: t.colors.ink, lineHeight: 16 }}>
              AAOIFI publishes revised guidance on agency-based investment
            </Text>
            <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft, marginTop: 2 }}>
              News · why it matters to your Wakalah campaign · 3 min
            </Text>
          </View>
        </Pressable>
      </Card>

      <FootDis>
        Capital at risk. Returns are projections, not guarantees. Ribh Investments · AAOIFI-aligned · regulatory
        registration under process.
      </FootDis>
    </Screen>
  );
}
