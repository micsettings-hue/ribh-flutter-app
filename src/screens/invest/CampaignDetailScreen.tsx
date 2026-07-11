import React, { useState } from "react";
import { Text, TextInput, View } from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import { useRoute, RouteProp } from "@react-navigation/native";

import { useTheme } from "@/theme";
import { CAMPS } from "@/state/data";
import { TK, tk, groupIndian, parseNum } from "@/utils/format";
import type { InvestStackParamList } from "@/navigation/types";
import { Screen, BackBtn } from "@/components/chrome";
import { Card, Kicker, Sec, Btn, FootDis, BodyText, IconSq } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { useSheet } from "@/components/Sheet";
import { InvestSheet, InfoSheet } from "@/sheets/sheets";

const SHARIAH_POINTS = [
  { ic: "box", bold: "Real asset, real activity", text: "· funds buy actual goods; return comes from trade, not lending." },
  { ic: "file", bold: "Full disclosure (bayan)", text: "· cost, markup or fee and terms fixed before execution." },
  { ic: "calendar", bold: "No time-based increase", text: "· the amount owed never grows due to delay; late charges go to charity." },
  { ic: "scale", bold: "Reviewed", text: "· screened for riba, gharar and maysir under our Shariah framework." },
];

const PROTECTIONS = [
  { ic: "file", bold: "Deed of Agreement", text: "· stamp-paper contract ('aqd)." },
  { ic: "users", bold: "Kafalah", text: "· verified guarantors, jointly and severally liable." },
  { ic: "shield", bold: "Security cheques", text: "· full repayment value including markup." },
  { ic: "alert", bold: "Contingency plan", text: "· signed, activates on material loss." },
];

const RECOVERY_STEPS = [
  { state: "done", t: "Contingency plan activated", s: "24 Jun · merchant and guarantors notified in writing" },
  { state: "now", t: "Kafalah enforcement", s: "Now · security cheques presented; 2 of 4 Kafils responding" },
  { state: "todo", t: "Legal proceedings", s: "If needed · against merchant and all Kafils" },
  { state: "todo", t: "Final accounting", s: "Only after all steps: any shortfall borne proportionally (Rabb al-Mal)" },
];

export function CampaignDetailScreen() {
  const t = useTheme();
  const { openSheet } = useSheet();
  const route = useRoute<RouteProp<InvestStackParamList, "CampaignDetail">>();
  const camp = CAMPS.find((c) => c.id === route.params.campId);
  const [amt, setAmt] = useState("1,00,000");
  if (!camp) return null;

  const isRec = camp.status === "recovery";
  const v = parseNum(amt);
  const proj = (v / 100000) * camp.ppl * (camp.share / 100);
  const projLabel = camp.contract === "Murabaha" ? "Projected profit (fixed markup basis)" : "Indicative profit (projected)";

  return (
    <Screen>
      <BackBtn label="Campaigns" />

      <LinearGradient
        colors={[t.colors.heroFrom, t.colors.heroMid, t.colors.heroTo]}
        start={{ x: 0, y: 0 }}
        end={{ x: 0.9, y: 1.2 }}
        style={{ borderRadius: 22, padding: 16, marginBottom: 13, borderWidth: 1, borderColor: "rgba(255,255,255,0.09)" }}
      >
        <View
          style={{
            alignSelf: "flex-start",
            backgroundColor: "rgba(255,255,255,0.14)",
            borderWidth: 1,
            borderColor: "rgba(255,255,255,0.35)",
            borderRadius: 999,
            paddingHorizontal: 8,
            paddingVertical: 3,
          }}
        >
          <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 10, color: t.colors.white }}>{camp.contract}</Text>
        </View>
        <Text style={{ fontFamily: t.fonts.display, fontSize: 19, color: t.colors.white, marginTop: 6, lineHeight: 23 }}>
          {camp.title}
        </Text>
        <Text style={{ fontFamily: t.fonts.body, fontSize: 11.5, color: "#BFE6D7", marginTop: 2 }}>
          {camp.sector} · {camp.tenure}-day tenure
        </Text>
      </LinearGradient>

      {isRec ? (
        <View
          style={{
            backgroundColor: t.colors.dangerSoft,
            borderWidth: 1,
            borderColor: t.mode === "dark" ? "#5A2F26" : "#ECD0C8",
            borderRadius: 14,
            padding: 13,
            marginBottom: 13,
          }}
        >
          <Text style={{ fontFamily: t.fonts.body, fontSize: 11, color: t.mode === "dark" ? "#E8B0A4" : "#6B463C", lineHeight: 17 }}>
            <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.danger }}>Status: in recovery.</Text> Repayment was not
            completed at maturity. Your capital is protected by the security stack below and the process is underway, but a
            proportional loss remains possible if recovery is exhausted.
          </Text>
        </View>
      ) : null}

      <View style={{ flexDirection: "row", flexWrap: "wrap", gap: 9, marginBottom: 13 }}>
        {[
          ["Profit per lac", tk(camp.ppl)],
          ["Your share", camp.share + "% · fee " + (100 - camp.share) + "%"],
          ["Pool", tk(camp.pool)],
          ["Raised", tk(camp.raised)],
        ].map(([l, val]) => (
          <View key={l} style={{ width: "48%", flexGrow: 1, backgroundColor: t.colors.mintSoft, borderRadius: 12, paddingVertical: 10, paddingHorizontal: 12 }}>
            <Text style={{ fontFamily: t.fonts.body, fontSize: 10, color: t.colors.inkSoft }}>{l}</Text>
            <Text style={{ fontFamily: t.fonts.display, fontSize: 15, color: t.colors.ink, marginTop: 1 }}>{val}</Text>
          </View>
        ))}
      </View>

      <Card>
        <Kicker>Try your numbers</Kicker>
        <Sec>Projection, not a promise</Sec>
        <View style={{ position: "relative" }}>
          <Text
            style={{
              position: "absolute",
              left: 12,
              top: 13,
              fontFamily: t.fonts.display,
              fontSize: 17,
              color: t.colors.teal,
              zIndex: 1,
            }}
          >
            {TK}
          </Text>
          <TextInput
            value={amt}
            onChangeText={(x) => {
              const n = parseNum(x);
              setAmt(n ? groupIndian(n) : "");
            }}
            keyboardType="numeric"
            style={{
              fontFamily: t.fonts.display,
              fontSize: 20,
              color: t.colors.ink,
              paddingVertical: 12,
              paddingLeft: 30,
              paddingRight: 12,
              borderWidth: 1.5,
              borderColor: t.colors.line,
              borderRadius: 11,
              backgroundColor: t.colors.mintSoft,
            }}
          />
        </View>
        <View
          style={{
            flexDirection: "row",
            justifyContent: "space-between",
            alignItems: "baseline",
            marginTop: 11,
            paddingTop: 11,
            borderTopWidth: 1,
            borderTopColor: t.colors.line,
            borderStyle: "dashed",
          }}
        >
          <Text style={{ fontFamily: t.fonts.body, fontSize: 11, color: t.colors.inkSoft, flex: 1 }}>{projLabel}</Text>
          <Text style={{ fontFamily: t.fonts.display, fontSize: 22, color: t.colors.gold }}>{tk(proj)}</Text>
        </View>
        <View style={{ backgroundColor: t.colors.mintSoft, borderRadius: 9, padding: 10, marginTop: 8 }}>
          <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft, lineHeight: 16 }}>
            profit = (amount ÷ 1,00,000) × {tk(camp.ppl)} × {camp.share}%. Ribh's {100 - camp.share}% is a disclosed{" "}
            <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.ink }}>Wakalah or success fee</Text> from confirmed
            profit only, never from your capital.
          </Text>
        </View>
      </Card>

      <Card>
        <Kicker>Shariah basis</Kicker>
        <Sec>{camp.contract} · how it stays halal</Sec>
        <BodyText style={{ marginBottom: 10 }}>{camp.note}</BodyText>
        {SHARIAH_POINTS.map((p) => (
          <View key={p.bold} style={{ flexDirection: "row", gap: 9, marginBottom: 9, alignItems: "flex-start" }}>
            <IconSq name={p.ic} size={20} iconSize={12} radius={6} />
            <Text style={{ flex: 1, fontFamily: t.fonts.body, fontSize: 11.5, color: t.colors.inkSoft, lineHeight: 17 }}>
              <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.ink }}>{p.bold}</Text> {p.text}
            </Text>
          </View>
        ))}
        <View style={{ height: 11 }} />
        <Btn
          kind="ghost"
          label="Why this is halal, in plain terms"
          icon="sparkles"
          onPress={() =>
            openSheet(
              <InfoSheet
                title="Why this is halal, in plain terms"
                sub={camp.contract === "Murabaha"
                  ? "Ribh buys and owns the goods before selling at a fixed, disclosed markup. The price never increases with time; late charges go to charity."
                  : "Ribh acts as your agent for a disclosed fee (ujrah). Returns are indicative; you remain the capital owner."}
                items={SHARIAH_POINTS}
                footer={'"...Allah has permitted trade and forbidden riba." Al-Baqarah 2:275'}
              />
            )
          }
        />
      </Card>

      <Card>
        <Kicker>Your protections</Kicker>
        <Sec>Security held for this campaign</Sec>
        {PROTECTIONS.map((p) => (
          <View key={p.bold} style={{ flexDirection: "row", gap: 9, marginBottom: 9, alignItems: "flex-start" }}>
            <IconSq name={p.ic} size={20} iconSize={12} radius={6} />
            <Text style={{ flex: 1, fontFamily: t.fonts.body, fontSize: 11.5, color: t.colors.inkSoft, lineHeight: 17 }}>
              <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.ink }}>{p.bold}</Text> {p.text}
            </Text>
          </View>
        ))}
      </Card>

      {isRec ? (
        <Card>
          <Kicker>Live recovery tracker</Kicker>
          <Sec>What we're doing about it</Sec>
          {RECOVERY_STEPS.map((r, i) => (
            <View key={r.t} style={{ flexDirection: "row", gap: 11, paddingBottom: i < RECOVERY_STEPS.length - 1 ? 16 : 0 }}>
              <View style={{ alignItems: "center" }}>
                <View
                  style={{
                    width: 22,
                    height: 22,
                    borderRadius: 11,
                    alignItems: "center",
                    justifyContent: "center",
                    backgroundColor: r.state === "done" ? t.colors.teal : r.state === "now" ? t.colors.gold : t.colors.mint,
                  }}
                >
                  {r.state === "done" ? (
                    <Icon name="check" size={11} color={t.colors.white} />
                  ) : (
                    <Text style={{ fontFamily: t.fonts.bodyBold, fontSize: 10, color: r.state === "now" ? t.colors.white : t.colors.teal }}>
                      {i + 1}
                    </Text>
                  )}
                </View>
                {i < RECOVERY_STEPS.length - 1 ? <View style={{ flex: 1, width: 1.5, backgroundColor: t.colors.line, marginTop: 2 }} /> : null}
              </View>
              <View style={{ flex: 1 }}>
                <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12, color: t.colors.ink }}>{r.t}</Text>
                <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft, marginTop: 1, lineHeight: 15 }}>{r.s}</Text>
              </View>
            </View>
          ))}
        </Card>
      ) : null}

      {camp.status === "open" ? (
        <>
          <Btn label="Invest in this campaign" icon="trend" onPress={() => openSheet(<InvestSheet campId={camp.id} />)} />
          <FootDis>Two acknowledgements required. Capital at risk; invest only what you can afford to place at risk.</FootDis>
        </>
      ) : null}
    </Screen>
  );
}
