import React from "react";
import { Text, View } from "react-native";
import { LinearGradient } from "expo-linear-gradient";

import { useTheme } from "@/theme";
import { Screen, BackBtn } from "@/components/chrome";
import { Icon } from "@/components/Icon";
import { Card, Kicker, Sec, Btn, IconSq } from "@/components/ui";
import { useToast } from "@/components/Toast";

const SCHEDULE = [
  { ok: true, label: "Instalment 1", date: "21 May", amt: "৳6,00,000" },
  { ok: true, label: "Instalment 2", date: "21 Jun", amt: "৳6,00,000" },
  { ok: false, label: "Final settlement", date: "21 Jul · overdue", amt: "৳8,10,670" },
];

const DOCS = [
  { ic: "file", label: "Deed of Agreement ('aqd)", st: "Executed", ok: true },
  { ic: "users", label: "Kafalah · 4 guarantors", st: "Executed", ok: true },
  { ic: "file", label: "Security cheques (4)", st: "Held", ok: true },
  { ic: "shield", label: "Contingency plan", st: "Activated", ok: false },
];

export function BusinessScreen() {
  const t = useTheme();
  const toast = useToast();

  return (
    <Screen>
      <BackBtn label="Investor mode" />
      <View style={{ marginBottom: 14 }}>
        <Text style={{ fontFamily: t.fonts.body, fontSize: 13, color: t.colors.inkSoft }}>Business dashboard</Text>
        <Text style={{ fontFamily: t.fonts.display, fontSize: 21, color: t.colors.ink, letterSpacing: -0.3 }}>
          Musannif Corporation
        </Text>
      </View>

      <LinearGradient
        colors={[t.colors.heroFrom, t.colors.heroMid, t.colors.heroTo]}
        start={{ x: 0, y: 0 }}
        end={{ x: 0.9, y: 1.2 }}
        style={{ borderRadius: 22, padding: 17, marginBottom: 13, borderWidth: 1, borderColor: "rgba(255,255,255,0.09)" }}
      >
        <Kicker color="#9FDCC4">Cement Supply · Murabaha</Kicker>
        <Text style={{ fontFamily: t.fonts.display, fontSize: 34, color: t.colors.white, textAlign: "center", marginTop: 6 }}>
          <Text style={{ fontSize: 19 }}>৳</Text>18,40,000
        </Text>
        <Text style={{ fontFamily: t.fonts.body, fontSize: 11.5, color: "#BFE6D7", textAlign: "center", marginTop: 2 }}>
          Raised of ৳25,00,000 pool · matured 21 Jul
        </Text>
        <View style={{ flexDirection: "row", gap: 8, marginTop: 14 }}>
          {[
            ["Owed total", "৳20,10,670"],
            ["Repaid", "৳12,00,000"],
            ["Outstanding", "৳8,10,670"],
          ].map(([l, v]) => (
            <View key={l} style={{ flex: 1, backgroundColor: "rgba(255,255,255,0.1)", borderRadius: 10, paddingVertical: 8, alignItems: "center" }}>
              <Text style={{ fontFamily: t.fonts.body, fontSize: 9.5, color: "#9FDCC4", textTransform: "uppercase", letterSpacing: 0.5 }}>{l}</Text>
              <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 13, color: t.colors.white, marginTop: 1 }}>{v}</Text>
            </View>
          ))}
        </View>
      </LinearGradient>

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
          <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.danger }}>Repayment overdue.</Text> The recovery process
          is active. Settle the outstanding amount or contact operations to update your contingency schedule. Late settlement
          never increases the amount owed; any late charge goes to charity.
        </Text>
      </View>

      <Card>
        <Kicker>Repayment schedule</Kicker>
        <Sec>Total sale price, fixed</Sec>
        {SCHEDULE.map((r) => (
          <View key={r.label} style={{ flexDirection: "row", alignItems: "center", gap: 10, paddingVertical: 10, borderBottomWidth: 1, borderBottomColor: t.colors.mintSoft }}>
            <Icon name={r.ok ? "check" : "alert"} size={15} color={r.ok ? t.colors.teal : t.colors.danger} />
            <Text style={{ flex: 1, fontFamily: t.fonts.body, fontSize: 11.5, color: t.colors.inkSoft }}>
              <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.ink }}>{r.label}</Text> · {r.date}
            </Text>
            <Text style={{ fontFamily: t.fonts.display, fontSize: 13.5, color: t.colors.ink }}>{r.amt}</Text>
          </View>
        ))}
        <View style={{ height: 10 }} />
        <Btn label="Settle outstanding" icon="arrup" onPress={() => toast("Settlement flow opened, operations notified")} />
      </Card>

      <Card>
        <Kicker>Document vault</Kicker>
        <Sec>Security instruments</Sec>
        {DOCS.map((d, i) => (
          <View
            key={d.label}
            style={{
              flexDirection: "row",
              alignItems: "center",
              gap: 10,
              paddingVertical: 10,
              borderBottomWidth: i < DOCS.length - 1 ? 1 : 0,
              borderBottomColor: t.colors.mintSoft,
            }}
          >
            <IconSq name={d.ic} size={30} iconSize={15} radius={9} color={t.colors.teal} />
            <Text style={{ flex: 1, fontFamily: t.fonts.body, fontSize: 12, color: t.colors.ink }}>{d.label}</Text>
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 10, color: d.ok ? t.colors.teal : t.colors.amber }}>{d.st}</Text>
          </View>
        ))}
      </Card>

      <Card>
        <Kicker>Compliance</Kicker>
        <Sec>Status checklist</Sec>
        {[
          { ic: "check", bold: "Business KYC", text: "verified, trade licence on file." },
          { ic: "check", bold: "Shariah review", text: "Murabaha structure approved before listing." },
          { ic: "alert", bold: "Repayment standing", text: "overdue, recovery step 2 of 4 active." },
        ].map((r) => (
          <View key={r.bold} style={{ flexDirection: "row", gap: 9, marginBottom: 9, alignItems: "flex-start" }}>
            <IconSq name={r.ic} size={20} iconSize={12} radius={6} />
            <Text style={{ flex: 1, fontFamily: t.fonts.body, fontSize: 11.5, color: t.colors.inkSoft, lineHeight: 17 }}>
              <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.ink }}>{r.bold}</Text> · {r.text}
            </Text>
          </View>
        ))}
        <View style={{ height: 10 }} />
        <Btn kind="ghost" label="Message operations" icon="chat" onPress={() => toast("Chat opened with Ribh operations")} />
      </Card>
    </Screen>
  );
}
