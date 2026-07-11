import React, { useState } from "react";
import { Pressable, Text, TextInput, View } from "react-native";
import { useNavigation } from "@react-navigation/native";
import { LinearGradient } from "expo-linear-gradient";

import { useTheme } from "@/theme";
import { useApp } from "@/state/AppState";
import { tk, parseNum, groupIndian } from "@/utils/format";
import { Screen, HRow } from "@/components/chrome";
import { Icon } from "@/components/Icon";
import { Card, Kicker, Sec, Btn, FootDis, Sw2, IconSq, BodyText } from "@/components/ui";
import { useSheet } from "@/components/Sheet";
import { useToast } from "@/components/Toast";
import { SheetTitle, ChipRow, AmountInput, InfoSheet, KycSheet } from "@/sheets/sheets";
import { GoalRow } from "@/components/GoalRow";

function RiskTierSheet() {
  const app = useApp();
  const { closeSheet } = useSheet();
  const toast = useToast();
  const t = useTheme();
  const [a1, setA1] = useState<string | null>(null);
  const [a2, setA2] = useState<string | null>(null);
  const [a3, setA3] = useState<string | null>(null);

  const Q = ({ q, val, set, opts }: { q: string; val: string | null; set: (v: string) => void; opts: string[] }) => (
    <View>
      <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12, color: t.colors.ink, marginBottom: 7 }}>{q}</Text>
      <ChipRow options={opts.map((o) => ({ key: o, label: o }))} selected={val} onSelect={set} />
    </View>
  );

  const score = [a1, a2, a3].filter((x) => x === "Comfortable" || x === "Growth" || x === "5+ years").length;
  const tier = score >= 2 ? "Balanced trade" : "Short-tenure Murabaha";

  return (
    <View>
      <SheetTitle title="Risk tier · 3 questions" sub="A recommendation only, never advice. Each deployment still needs its own risk acknowledgement." />
      <Q q="If a campaign repays late, you are..." val={a1} set={setA1} opts={["Anxious", "Comfortable"]} />
      <Q q="Your priority is..." val={a2} set={setA2} opts={["Stability", "Growth"]} />
      <Q q="Your horizon is..." val={a3} set={setA3} opts={["Under 1 year", "5+ years"]} />
      <Btn
        label="Save my tier"
        icon="check"
        disabled={!a1 || !a2 || !a3}
        onPress={() => {
          app.set("riskTier", tier);
          closeSheet();
          toast("Tier saved: " + tier);
        }}
      />
    </View>
  );
}

function NomineeSheet() {
  const app = useApp();
  const { closeSheet } = useSheet();
  const toast = useToast();
  const t = useTheme();
  const [name, setName] = useState("");

  return (
    <View>
      <SheetTitle
        title="Nominee"
        sub="Name a beneficiary. The nominee is custodial, not a substitute for Islamic inheritance (Faraid) rules."
      />
      <TextInput
        value={name}
        onChangeText={setName}
        placeholder="Full name, as on NID"
        placeholderTextColor={t.colors.inkSoft}
        style={{
          fontFamily: t.fonts.body, fontSize: 14, color: t.colors.ink, padding: 13, borderWidth: 1.5,
          borderColor: t.colors.line, borderRadius: 12, backgroundColor: t.colors.mintSoft, marginBottom: 10,
        }}
      />
      <Btn
        label="Save nominee"
        icon="users"
        disabled={!name.trim()}
        onPress={() => {
          app.set("nominee", name.trim());
          closeSheet();
          toast("Nominee saved: " + name.trim());
        }}
      />
    </View>
  );
}

function PayoutSheet() {
  const app = useApp();
  const { closeSheet } = useSheet();
  const toast = useToast();
  const [plan, setPlan] = useState(app.s.payoutPlan);

  return (
    <View>
      <SheetTitle title="Payout plan" sub="How matured profit reaches you. Bank account ····4192 is your verified destination." />
      <ChipRow
        options={["Per campaign", "Monthly", "Auto-reinvest"].map((x) => ({ key: x, label: x }))}
        selected={plan}
        onSelect={setPlan}
      />
      <Btn
        label="Save plan"
        icon="calendar"
        onPress={() => {
          app.set("payoutPlan", plan);
          closeSheet();
          toast("Payout plan: " + plan);
        }}
      />
    </View>
  );
}

function PurifySheet() {
  const app = useApp();
  const { closeSheet } = useSheet();
  const toast = useToast();
  const [amt, setAmt] = useState("120");

  return (
    <View>
      <SheetTitle
        title="Interest purification"
        sub="Cleanse incidental interest (e.g. from a conventional bank account) by routing it to charity. It is not sadaqah in your name; it is removal of what was never yours."
      />
      <AmountInput value={amt} onChange={setAmt} />
      <Btn
        label="Route to charity"
        icon="sparkles"
        onPress={() => {
          const v = parseNum(amt);
          if (!v) return;
          app.purify(v);
          closeSheet();
          toast(tk(v) + " purified, routed to charity");
        }}
      />
    </View>
  );
}

function GoalSettingsSheet() {
  const app = useApp();
  const toast = useToast();
  const t = useTheme();

  return (
    <View>
      <SheetTitle title="Goal settings" sub="Closing a goal returns its savings to your available balance and writes to the ledger." />
      {app.s.goals.map((g) => (
        <View key={g.id} style={{ flexDirection: "row", alignItems: "center", gap: 8 }}>
          <View style={{ flex: 1 }}>
            <GoalRow goal={g} onPress={() => {}} last />
          </View>
          <Pressable
            onPress={() => {
              app.removeGoal(g.id);
              toast(g.saved > 0 ? "Goal removed, " + tk(g.saved) + " returned" : "Goal removed");
            }}
            style={{
              width: 34,
              height: 34,
              borderRadius: 11,
              borderWidth: 1,
              borderColor: t.colors.line,
              backgroundColor: t.colors.dangerSoft,
              alignItems: "center",
              justifyContent: "center",
            }}
          >
            <Icon name="trash" size={15} color={t.colors.danger} />
          </Pressable>
        </View>
      ))}
    </View>
  );
}

export function MeScreen() {
  const t = useTheme();
  const app = useApp();
  const nav = useNavigation<any>();
  const { openSheet } = useSheet();
  const toast = useToast();

  const SetRow = ({ title, sub, on, onToggle, last }: { title: string; sub: string; on: boolean; onToggle: () => void; last?: boolean }) => (
    <View
      style={{
        flexDirection: "row",
        alignItems: "center",
        justifyContent: "space-between",
        paddingVertical: 12,
        borderBottomWidth: last ? 0 : 1,
        borderBottomColor: t.colors.mintSoft,
      }}
    >
      <View style={{ flex: 1, paddingRight: 12 }}>
        <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12.5, color: t.colors.ink }}>{title}</Text>
        <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft, marginTop: 1 }}>{sub}</Text>
      </View>
      <Sw2 on={on} onToggle={onToggle} />
    </View>
  );

  const MeRow = ({ ic, title, sub, onPress, last }: { ic: string; title: string; sub: string; onPress: () => void; last?: boolean }) => (
    <Pressable
      onPress={onPress}
      style={{
        flexDirection: "row",
        alignItems: "center",
        gap: 11,
        paddingVertical: 13,
        borderBottomWidth: last ? 0 : 1,
        borderBottomColor: t.colors.mintSoft,
        minHeight: 56,
      }}
    >
      <IconSq name={ic} size={36} iconSize={17} radius={12} color={t.colors.teal} />
      <View style={{ flex: 1 }}>
        <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 13, color: t.colors.ink }}>{title}</Text>
        <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft, marginTop: 1 }}>{sub}</Text>
      </View>
      <Icon name="chev" size={16} color={t.colors.inkSoft} />
    </Pressable>
  );

  return (
    <Screen>
      <HRow label="Account" title="Muzahid Islam" />

      <Card solid>
        <Kicker>Settings</Kicker>
        <SetRow title="Language" sub="English / বাংলা" on={false} onToggle={() => toast("Bangla strings ship with the bilingual build")} />
        <SetRow title="Dark appearance" sub="Easier on the eyes at night" on={t.mode === "dark"} onToggle={() => t.setMode(t.mode === "dark" ? "light" : "dark")} />
        <SetRow title="Salah quiet hours" sub="Pause notifications around prayer times" on={app.s.quiet} onToggle={() => app.set("quiet", !app.s.quiet)} />
        <SetRow title="Payment reminders" sub="Due dates and campaigns closing soon" on={app.s.reminders} onToggle={() => app.set("reminders", !app.s.reminders)} last />
      </Card>

      <Card solid>
        <Kicker>Shariah oversight</Kicker>
        <Sec>Ribh's Shariah board</Sec>
        <View style={{ flexDirection: "row", gap: 12, alignItems: "flex-start" }}>
          <LinearGradient
            colors={[t.colors.green, t.colors.tealDeep]}
            start={{ x: 0, y: 0 }}
            end={{ x: 1, y: 1 }}
            style={{ width: 52, height: 52, borderRadius: 16, alignItems: "center", justifyContent: "center" }}
          >
            <Text style={{ fontFamily: t.fonts.display, fontSize: 20, color: t.colors.white }}>AJ</Text>
          </LinearGradient>
          <View style={{ flex: 1 }}>
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 14, color: t.colors.ink }}>
              Abdullah Jubair <Text style={{ fontSize: 10, color: t.colors.teal }}>· Chair</Text>
            </Text>
            <Text style={{ fontFamily: t.fonts.body, fontSize: 11, color: t.colors.inkSoft, lineHeight: 16, marginTop: 2 }}>
              M.A. Islamic Studies (gold medalist) and B.A., University of Dhaka · Editor-in-Chief, monthly Sawtul Madina
            </Text>
          </View>
        </View>
        <BodyText style={{ marginTop: 9 }}>Plus Mufti Mahmudur Rahman and Dr. Sadia Haque</BodyText>
        <View style={{ height: 11 }} />
        <Btn
          kind="ghost"
          label="Meet the board"
          icon="users"
          onPress={() =>
            openSheet(
              <InfoSheet
                title="Ribh's Shariah board"
                sub="Every contract structure is reviewed before listing; pronouncements are published in plain language."
                items={[
                  { ic: "user", bold: "Abdullah Jubair · Chair", text: "· M.A. Islamic Studies (gold medalist), University of Dhaka." },
                  { ic: "user", bold: "Mufti Mahmudur Rahman", text: "· specialist in fiqh al-muamalat (commercial jurisprudence)." },
                  { ic: "user", bold: "Dr. Sadia Haque", text: "· researcher in Islamic finance and consumer protection." },
                ]}
              />
            )
          }
        />
        <View style={{ height: 8 }} />
        <Btn
          kind="ghost"
          label="Read Shariah notes per contract"
          icon="scale"
          onPress={() =>
            openSheet(
              <InfoSheet
                title="Shariah notes, per contract"
                sub="Reviewed by Abdullah Jubair. Plain-language pronouncements:"
                items={[
                  { ic: "box", bold: "Murabaha (SS No. 8)", text: "· Ribh buys and owns the goods before selling at a fixed, disclosed markup. The price never increases with time; late charges go to charity." },
                  { ic: "briefcase", bold: "Wakalah", text: "· Ribh acts as your agent for a disclosed fee (ujrah). Returns are indicative; you remain the capital owner." },
                  { ic: "users", bold: "Musharakah and Mudarabah", text: "· profit shared by agreed ratio; financial loss borne by capital providers, effort loss by the manager. Any capital guarantee would nullify the contract." },
                ]}
                footer={'"...Allah has permitted trade and forbidden riba." Al-Baqarah 2:275'}
              />
            )
          }
        />
      </Card>

      <Card solid>
        <MeRow
          ic="chartbar"
          title="Risk tier"
          sub={app.s.riskTier ? app.s.riskTier + " · change anytime" : "Not set · take the 3-question quiz"}
          onPress={() => openSheet(<RiskTierSheet />)}
        />
        <MeRow
          ic="repeat"
          title="Weekly auto-save"
          sub={app.s.autosaveOn ? "On · ৳" + app.s.autosaveAmount + " weekly into the Ribh Fund" : "Off · build the habit from Tk250"}
          onPress={() => nav.navigate("GrowTab", { screen: "Grow" })}
        />
        <MeRow
          ic="users"
          title="Nominee"
          sub={app.s.nominee ?? "Not set · name a beneficiary"}
          onPress={() => openSheet(<NomineeSheet />)}
          last
        />
      </Card>

      <Card solid>
        <MeRow ic="briefcase" title="Business mode" sub="Musannif Corp. dashboard" onPress={() => nav.navigate("Business")} />
        <MeRow
          ic="id"
          title="Identity and KYC"
          sub={app.s.kyc ? "Tier 2 · verified" : "Tier 1 · NID pending · tap to verify"}
          onPress={() => (app.s.kyc ? toast("Already verified · Tier 2") : openSheet(<KycSheet onDone={() => app.set("kyc", true)} />))}
        />
        <MeRow ic="calendar" title="Payout plan" sub={app.s.payoutPlan + " · bank ····4192"} onPress={() => openSheet(<PayoutSheet />)} />
        <MeRow ic="target" title="Goal settings" sub={app.s.goals.length + " active goals"} onPress={() => openSheet(<GoalSettingsSheet />)} />
        <MeRow
          ic="lock"
          title="Security"
          sub="Biometric on · 2FA on"
          onPress={() =>
            openSheet(
              <InfoSheet
                title="Security"
                sub="Biometric unlock and two-factor authentication are on."
                items={[
                  { ic: "lock", bold: "Biometric unlock", text: "· FaceID or fingerprint on this device." },
                  { ic: "phone", bold: "Two-factor", text: "· OTP to your verified number for money-moving actions." },
                  { ic: "shield", bold: "Session control", text: "· sign out of other devices at any time." },
                ]}
              />
            )
          }
        />
        <MeRow
          ic="file"
          title="Statements and receipts"
          sub="Zakat-ready annual summary"
          onPress={() =>
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
            )
          }
        />
        <MeRow
          ic="sparkles"
          title="Interest purification"
          sub={app.s.purified > 0 ? tk(app.s.purified) + " purified to date" : "Cleanse incidental interest"}
          onPress={() => openSheet(<PurifySheet />)}
        />
        <MeRow
          ic="gift"
          title="Invite a friend"
          sub="You both plant a tree"
          onPress={() =>
            openSheet(
              <InfoSheet
                title="Invite a friend"
                sub="Share your code MUZAHID26. When a friend verifies and makes a first deposit, you both plant a tree."
                items={[
                  { ic: "users", bold: "3 friends joined", text: "· 2 trees planted in Nilphamari so far." },
                  { ic: "sprout", bold: "Reward", text: "· a tree each, sadaqah jariyah in both names. Never framed as a return." },
                ]}
              />
            )
          }
        />
        <MeRow
          ic="route"
          title="How Ribh works"
          sub="A quick tour"
          onPress={() =>
            openSheet(
              <InfoSheet
                title="How Ribh works"
                sub="Your money is an amanah: held segregated, deployed only into screened, asset-backed trade."
                items={[
                  { ic: "wallet", bold: "1 · Deposit", text: "· from your own verified account, name-matched (AML)." },
                  { ic: "box", bold: "2 · Deploy", text: "· you approve each campaign; funds buy real goods." },
                  { ic: "arrdown", bold: "3 · Repay", text: "· the merchant repays on schedule; every taka hits the signed ledger." },
                  { ic: "sprout", bold: "4 · Profit or loss", text: "· projections are not promises; capital is at risk." },
                ]}
              />
            )
          }
        />
        <MeRow
          ic="info"
          title="About Ribh Investments"
          sub="Who we are, in brief"
          onPress={() =>
            openSheet(
              <InfoSheet
                title="About Ribh Investments"
                sub="A halal wealth companion from Ribh Capital Group, Dhanmondi, Dhaka."
                items={[
                  { ic: "scale", bold: "AAOIFI-aligned", text: "· contracts structured and reviewed under our Shariah framework." },
                  { ic: "shield", bold: "Amanah custody", text: "· client funds held segregated; books reconciled daily." },
                  { ic: "file", bold: "Registration", text: "· BSEC and Bangladesh Bank registration under process." },
                ]}
              />
            )
          }
        />
        <MeRow
          ic="db"
          title="Local database"
          sub="Prototype data on this device"
          onPress={() =>
            openSheet(
              <InfoSheet
                title="Local database"
                sub="This build runs on device-local prototype data mirroring the future Supabase schema. Nothing leaves your device."
              />
            )
          }
        />
        <MeRow
          ic="chat"
          title="Help and disputes"
          sub="Negotiation to arbitration path"
          onPress={() =>
            openSheet(
              <InfoSheet
                title="Help and disputes"
                sub="Trust in Islamic finance is fragile; disputes follow a clear path."
                items={[
                  { ic: "chat", bold: "1 · Talk to us", text: "· live chat and email, human support." },
                  { ic: "users", bold: "2 · Negotiation", text: "· structured resolution with operations." },
                  { ic: "scale", bold: "3 · Arbitration", text: "· independent, then Shariah arbitration if needed." },
                ]}
              />
            )
          }
          last
        />
      </Card>

      <FootDis>
        Ribh Investments · Dhanmondi, Dhaka · support@ribhcapital.com · Client funds held segregated as amanah. BSEC and
        Bangladesh Bank registration under process.
      </FootDis>
    </Screen>
  );
}
