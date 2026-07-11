import React from "react";
import { Text, View } from "react-native";

import { useTheme } from "@/theme";
import { useApp } from "@/state/AppState";
import { tk } from "@/utils/format";
import { Screen, BackBtn } from "@/components/chrome";
import { Card, Kicker, Sec, Btn, FootDis, IconSq } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { useSheet } from "@/components/Sheet";
import { useToast } from "@/components/Toast";
import { DepositSheet, WithdrawSheet } from "@/sheets/sheets";

export function WalletScreen() {
  const t = useTheme();
  const app = useApp();
  const { openSheet } = useSheet();
  const toast = useToast();

  return (
    <Screen>
      <BackBtn label="Home" />

      <Card>
        <Kicker>Payouts</Kicker>
        <Sec>Pending payout</Sec>
        <View
          style={{
            flexDirection: "row",
            alignItems: "center",
            gap: 11,
            backgroundColor: t.colors.goldSoft,
            borderWidth: 1,
            borderColor: t.mode === "dark" ? "#5A4A1A" : "#E8D5A8",
            borderRadius: 15,
            padding: 13,
            marginBottom: 12,
          }}
        >
          <Icon name="gift" size={18} color={t.colors.gold} />
          <View style={{ flex: 1 }}>
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12, color: t.colors.ink }}>Profit · Printing Mach. Trading</Text>
            <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft }}>Plan: {app.s.payoutPlan}</Text>
          </View>
          <Text style={{ fontFamily: t.fonts.display, fontSize: 16, color: t.colors.gold }}>{tk(app.s.pendingPayout)}</Text>
        </View>
        <View style={{ flexDirection: "row", gap: 9 }}>
          <Btn
            kind="ghost"
            label="To bank"
            icon="arrup"
            style={{ flex: 1 }}
            onPress={() => {
              app.pushLedger({ sign: "-", t: "Payout to bank ····4192", s: "Today · pending payout", amt: "−" + tk(app.s.pendingPayout) });
              app.set("pendingPayout", 0);
              toast("Payout sent to your bank, 1 business day");
            }}
          />
          <Btn
            label="Reinvest"
            icon="refresh"
            style={{ flex: 1 }}
            onPress={() => {
              app.set("avail", app.s.avail + app.s.pendingPayout);
              app.pushLedger({ sign: "+", t: "Payout reinvested · available balance", s: "Today · new commitment", amt: "+" + tk(app.s.pendingPayout) });
              app.set("pendingPayout", 0);
              toast("Payout returned to available balance");
            }}
          />
        </View>
        <FootDis left>
          Reinvesting returns the payout to your available balance as a new commitment. Capital remains at risk.
        </FootDis>
      </Card>

      <Card>
        <Kicker>Signed ledger</Kicker>
        <Sec>Every taka, accounted</Sec>
        {app.s.ledger.map((l, i) => {
          const neg = l.sign !== "+";
          const icn = l.sign === "+" ? "plus" : l.sign === "-" ? "minus" : "alert";
          return (
            <View
              key={i}
              style={{
                flexDirection: "row",
                alignItems: "center",
                gap: 11,
                paddingVertical: 11,
                borderBottomWidth: i < app.s.ledger.length - 1 ? 1 : 0,
                borderBottomColor: t.colors.mintSoft,
              }}
            >
              <IconSq
                name={icn}
                size={34}
                iconSize={14}
                radius={11}
                bg={neg ? t.colors.dangerSoft : t.colors.mint}
                color={neg ? t.colors.danger : t.colors.teal}
              />
              <View style={{ flex: 1 }}>
                <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12, color: t.colors.ink }}>{l.t}</Text>
                <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft }}>{l.s}</Text>
              </View>
              <Text style={{ fontFamily: t.fonts.display, fontSize: 14, color: neg ? t.colors.danger : t.colors.teal }}>
                {l.amt}
              </Text>
            </View>
          );
        })}
        <FootDis left>Ledger is append-only. Balance equals the sum of all signed entries, reconciled daily.</FootDis>
      </Card>

      <Btn kind="ghost" label="Add funds" icon="arrdown" onPress={() => openSheet(<DepositSheet />)} />
      <View style={{ height: 9 }} />
      <Btn kind="ghost" label="Withdraw" icon="arrup" onPress={() => openSheet(<WithdrawSheet />)} />
    </Screen>
  );
}
