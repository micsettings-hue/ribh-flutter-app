import React, { useState } from "react";
import { Pressable, Text, TextInput, View } from "react-native";

import { useTheme } from "@/theme";
import { useApp } from "@/state/AppState";
import { CAMPS } from "@/state/data";
import { useSheet } from "@/components/Sheet";
import { useToast } from "@/components/Toast";
import { Btn, BodyText, FootDis, IconSq } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { TK, tk, groupIndian, parseNum } from "@/utils/format";

export function SheetTitle({ title, sub }: { title: string; sub?: string }) {
  const t = useTheme();
  return (
    <View style={{ marginBottom: sub ? 14 : 10 }}>
      <Text style={{ fontFamily: t.fonts.display, fontSize: 18, color: t.colors.ink, marginBottom: 4 }}>{title}</Text>
      {sub ? <Text style={{ fontFamily: t.fonts.body, fontSize: 12, color: t.colors.inkSoft, lineHeight: 18 }}>{sub}</Text> : null}
    </View>
  );
}

export function AmountInput({ value, onChange }: { value: string; onChange: (v: string) => void }) {
  const t = useTheme();
  return (
    <View style={{ position: "relative", marginBottom: 12 }}>
      <Text
        style={{
          position: "absolute",
          left: 13,
          top: 0,
          bottom: 0,
          textAlignVertical: "center",
          lineHeight: 52,
          fontFamily: t.fonts.display,
          fontSize: 19,
          color: t.colors.teal,
          zIndex: 1,
        }}
      >
        {TK}
      </Text>
      <TextInput
        value={value}
        onChangeText={(v) => {
          const n = parseNum(v);
          onChange(n ? groupIndian(n) : "");
        }}
        keyboardType="numeric"
        style={{
          fontFamily: t.fonts.display,
          fontSize: 24,
          color: t.colors.ink,
          paddingVertical: 13,
          paddingLeft: 32,
          paddingRight: 14,
          borderWidth: 1.5,
          borderColor: t.colors.line,
          borderRadius: 12,
          backgroundColor: t.colors.mintSoft,
        }}
      />
    </View>
  );
}

export function ChipRow({
  options,
  selected,
  onSelect,
}: {
  options: Array<{ key: string; label: string }>;
  selected: string | null;
  onSelect: (key: string) => void;
}) {
  const t = useTheme();
  return (
    <View style={{ flexDirection: "row", flexWrap: "wrap", gap: 7, marginBottom: 14 }}>
      {options.map((o) => {
        const on = o.key === selected;
        return (
          <Pressable
            key={o.key}
            onPress={() => onSelect(o.key)}
            style={{
              paddingHorizontal: 13,
              paddingVertical: 8,
              borderRadius: 999,
              borderWidth: 1.5,
              borderColor: on ? t.colors.teal : t.colors.line,
              backgroundColor: on ? t.colors.teal : t.colors.mintSoft,
            }}
          >
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 11.5, color: on ? t.colors.white : t.colors.teal }}>
              {o.label}
            </Text>
          </Pressable>
        );
      })}
    </View>
  );
}

export function Ack({ checked, onToggle, children }: { checked: boolean; onToggle: () => void; children: React.ReactNode }) {
  const t = useTheme();
  return (
    <Pressable onPress={onToggle} style={{ flexDirection: "row", gap: 10, paddingVertical: 10, alignItems: "flex-start" }}>
      <View
        style={{
          width: 18,
          height: 18,
          borderRadius: 4,
          borderWidth: 1.5,
          borderColor: checked ? t.colors.teal : t.colors.line,
          backgroundColor: checked ? t.colors.teal : "transparent",
          alignItems: "center",
          justifyContent: "center",
          marginTop: 1,
        }}
      >
        {checked ? <Icon name="check" size={12} color={t.colors.white} /> : null}
      </View>
      <Text style={{ flex: 1, fontFamily: t.fonts.body, fontSize: 11.5, color: t.colors.inkSoft, lineHeight: 17 }}>
        {children}
      </Text>
    </Pressable>
  );
}

const PROVIDERS: Record<string, [string, string]> = {
  bkash: ["bKash", "····211"],
  nagad: ["Nagad", "····874"],
  bank: ["Bank transfer", "····4192"],
};

export function DepositSheet() {
  const app = useApp();
  const { closeSheet } = useSheet();
  const toast = useToast();
  const [prov, setProv] = useState<string>(app.s.depositProvider);
  const [amt, setAmt] = useState("5,000");
  const p = PROVIDERS[prov];

  return (
    <View>
      <SheetTitle
        title="Add funds"
        sub={
          "Funds must arrive from your own verified " +
          p[0] +
          " account in a name that matches your NID (AML rule)." +
          (app.s.kyc ? "" : " Complete KYC first; deposits are locked at Tier 1.")
        }
      />
      <ChipRow
        options={Object.keys(PROVIDERS).map((k) => ({ key: k, label: PROVIDERS[k][0] }))}
        selected={prov}
        onSelect={(k) => {
          setProv(k);
          app.set("depositProvider", k as "bkash" | "nagad" | "bank");
        }}
      />
      <AmountInput value={amt} onChange={setAmt} />
      <ChipRow
        options={[
          { key: "1000", label: TK + "1,000" },
          { key: "5000", label: TK + "5,000" },
          { key: "25000", label: TK + "25,000" },
        ]}
        selected={null}
        onSelect={(k) => setAmt(groupIndian(parseInt(k, 10)))}
      />
      <Btn
        label={"Confirm via " + p[0] + " " + p[1]}
        icon="arrdown"
        disabled={!app.s.kyc}
        onPress={() => {
          const v = parseNum(amt);
          if (!v) return;
          app.deposit(v, p[0]);
          closeSheet();
          toast(tk(v) + " received via " + p[0] + ", ledger updated");
        }}
      />
      {!app.s.kyc ? <BodyText style={{ marginTop: 9, textAlign: "center" }}>Verify identity from the Home banner first.</BodyText> : null}
      <FootDis left>You will approve the charge inside your {p[0]} app. Ribh never sees your {p[0]} PIN.</FootDis>
    </View>
  );
}

export function WithdrawSheet() {
  const app = useApp();
  const { closeSheet } = useSheet();
  const toast = useToast();
  const [amt, setAmt] = useState("10,000");
  const [ack, setAck] = useState(false);

  return (
    <View>
      <SheetTitle
        title="Withdraw to bank"
        sub={"Available: " + tk(app.s.avail) + " · sent to your verified account ····4192. Withdrawals reduce your fund total."}
      />
      <AmountInput value={amt} onChange={setAmt} />
      <Ack checked={ack} onToggle={() => setAck(!ack)}>
        I confirm this withdrawal goes to my own account and understand it may take 1 business day.
      </Ack>
      <Btn
        label="Confirm withdrawal"
        icon="arrup"
        disabled={!ack}
        onPress={() => {
          const v = parseNum(amt);
          if (!v) return;
          if (!app.withdraw(v)) {
            toast("Exceeds available " + tk(app.s.avail));
            return;
          }
          closeSheet();
          toast(tk(v) + " on its way to your bank");
        }}
      />
    </View>
  );
}

export function InvestSheet({ campId }: { campId: string }) {
  const app = useApp();
  const { closeSheet } = useSheet();
  const toast = useToast();
  const t = useTheme();
  const camp = CAMPS.find((c) => c.id === campId);
  const [amt, setAmt] = useState("50,000");
  const [ack1, setAck1] = useState(false);
  const [ack2, setAck2] = useState(false);
  if (!camp) return null;
  const v = parseNum(amt);
  const proj = (v / 100000) * camp.ppl * (camp.share / 100);

  return (
    <View>
      <SheetTitle title={"Commit to " + camp.title} sub={camp.contract + " · " + camp.tenure + "-day tenure · your share " + camp.share + "%"} />
      <AmountInput value={amt} onChange={setAmt} />
      <Text style={{ fontFamily: t.fonts.body, fontSize: 12, color: t.colors.inkSoft, marginBottom: 8 }}>
        Projected profit: <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.gold }}>{tk(proj)}</Text>. A projection, not a promise.
      </Text>
      <Ack checked={ack1} onToggle={() => setAck1(!ack1)}>
        Capital at risk. I understand returns are not guaranteed and, if recovery is exhausted after default, I bear loss
        proportionally (Rabb al-Mal).
      </Ack>
      <Ack checked={ack2} onToggle={() => setAck2(!ack2)}>
        I have read the {camp.contract} contract basis and the security instruments for this campaign.
      </Ack>
      <Btn
        label="Invest now"
        icon="check"
        disabled={!ack1 || !ack2 || !v}
        onPress={() => {
          if (!app.invest(camp.title, camp.contract, v)) {
            toast("Exceeds available " + tk(app.s.avail));
            return;
          }
          closeSheet();
          toast(tk(v) + " committed, signed entry added to your ledger");
        }}
      />
    </View>
  );
}

export function GiveCustomSheet() {
  const app = useApp();
  const { closeSheet } = useSheet();
  const toast = useToast();
  const [amt, setAmt] = useState("100");

  return (
    <View>
      <SheetTitle title="Sadaqah, your amount" sub="100% of your sadaqah reaches vetted causes; allocation published monthly." />
      <AmountInput value={amt} onChange={setAmt} />
      <Btn
        label="Give now"
        icon="heart"
        onPress={() => {
          const v = parseNum(amt);
          if (!v) return;
          app.give(v);
          closeSheet();
          toast(tk(v) + " given. May it be accepted");
        }}
      />
    </View>
  );
}

export function NewGoalSheet() {
  const app = useApp();
  const { closeSheet } = useSheet();
  const toast = useToast();
  const t = useTheme();
  const [name, setName] = useState("");
  const [target, setTarget] = useState("1,00,000");

  return (
    <View>
      <SheetTitle title="New goal pot" sub="Name your niyyah and set a target. Targets are aspirations, never guarantees." />
      <TextInput
        value={name}
        onChangeText={setName}
        placeholder="Goal name (e.g. Marriage)"
        placeholderTextColor={t.colors.inkSoft}
        style={{
          fontFamily: t.fonts.body,
          fontSize: 14,
          color: t.colors.ink,
          padding: 13,
          borderWidth: 1.5,
          borderColor: t.colors.line,
          borderRadius: 12,
          backgroundColor: t.colors.mintSoft,
          marginBottom: 10,
        }}
      />
      <AmountInput value={target} onChange={setTarget} />
      <Btn
        label="Create goal"
        icon="target"
        onPress={() => {
          const n = name.trim() || "New goal";
          app.addGoal(n, parseNum(target) || 100000);
          closeSheet();
          toast("Goal created: " + n);
        }}
      />
    </View>
  );
}

export function GoalAddSheet({ goalId }: { goalId: string }) {
  const app = useApp();
  const { closeSheet } = useSheet();
  const toast = useToast();
  const goal = app.s.goals.find((g) => g.id === goalId);
  const [amt, setAmt] = useState("5,000");
  if (!goal) return null;

  return (
    <View>
      <SheetTitle
        title={"Add to " + goal.t}
        sub={tk(goal.saved) + " of " + tk(goal.target) + " so far · moves from your available balance and writes to the ledger."}
      />
      <AmountInput value={amt} onChange={setAmt} />
      <Btn
        label="Add to goal"
        icon="plus"
        onPress={() => {
          const v = parseNum(amt);
          if (!v) {
            toast("Enter an amount");
            return;
          }
          if (!app.addToGoal(goalId, v)) {
            toast("Exceeds available " + tk(app.s.avail));
            return;
          }
          closeSheet();
          toast(tk(v) + " added to " + goal.t);
        }}
      />
    </View>
  );
}

export function NotifsSheet() {
  const app = useApp();
  const { closeSheet } = useSheet();
  const t = useTheme();
  const rows = [
    { ic: "sprout", t2: "Profit received, ৳3,937", s: "Printing Machinery Trading matured. Open Wallet to reinvest or withdraw." },
    { ic: "trend", t2: "Printing Zone closes in 2 days", s: "94.7% funded. You viewed this campaign yesterday." },
    { ic: "heart", t2: "Jumu'ah sadaqah reminder", s: "Give ৳10 before Maghrib; the best charity is given from surplus." },
  ];

  return (
    <View>
      <SheetTitle
        title="Notifications"
        sub={app.s.quiet ? "Quiet hours active around salah times." : "Quiet hours are off. Enable them in Settings."}
      />
      {rows.map((r, i) => (
        <View
          key={i}
          style={{
            flexDirection: "row",
            gap: 11,
            paddingVertical: 12,
            borderBottomWidth: 1,
            borderBottomColor: t.colors.mintSoft,
            alignItems: "flex-start",
          }}
        >
          <IconSq name={r.ic} iconSize={16} />
          <View style={{ flex: 1 }}>
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12.5, color: t.colors.ink, lineHeight: 17 }}>{r.t2}</Text>
            <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft, marginTop: 2, lineHeight: 15 }}>
              {r.s}
            </Text>
          </View>
        </View>
      ))}
      <View style={{ height: 12 }} />
      <Btn
        kind="ghost"
        label="Mark all read"
        icon="check"
        onPress={() => {
          app.set("notifRead", true);
          closeSheet();
        }}
      />
    </View>
  );
}

export function QiblaSheet() {
  const t = useTheme();
  const mosques = [
    { n: "Dhanmondi Shahi Jame Masjid", s: "550 m · Jumu'ah 1:15 PM" },
    { n: "Baitul Aman Jame Masjid", s: "900 m · Jumu'ah 1:30 PM" },
  ];
  return (
    <View>
      <SheetTitle title="Qibla · from Dhaka" sub="Face 277 degrees, roughly west-northwest, toward the Kaaba in Makkah." />
      <View style={{ width: 170, height: 170, alignSelf: "center", marginVertical: 8 }}>
        <View
          style={{
            flex: 1,
            borderRadius: 85,
            borderWidth: 2,
            borderColor: t.colors.line,
            backgroundColor: t.colors.mintSoft,
            alignItems: "center",
          }}
        >
          <Text style={{ fontFamily: t.fonts.bodyBold, fontSize: 10, color: t.colors.inkSoft, marginTop: 8 }}>N</Text>
          <View
            style={{
              position: "absolute",
              left: 83,
              top: 85,
              width: 4,
              height: 66,
              borderRadius: 99,
              backgroundColor: t.colors.teal,
              transform: [{ translateY: -66 }, { rotate: "277deg" }],
            }}
          />
          <View
            style={{
              position: "absolute",
              left: 78,
              top: 78,
              width: 14,
              height: 14,
              borderRadius: 7,
              backgroundColor: t.colors.gold,
            }}
          />
        </View>
      </View>
      <BodyText style={{ textAlign: "center", marginBottom: 10 }}>
        Compass is illustrative in this prototype; the native app uses the device magnetometer.
      </BodyText>
      {mosques.map((m, i) => (
        <View key={i} style={{ flexDirection: "row", gap: 11, paddingVertical: 12, alignItems: "center" }}>
          <IconSq name="pin" size={40} iconSize={16} />
          <View>
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12, color: t.colors.ink }}>{m.n}</Text>
            <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft, marginTop: 2 }}>{m.s}</Text>
          </View>
        </View>
      ))}
    </View>
  );
}

// Generic static content sheet: title, sub, bullet list with icons, optional footer.
export function InfoSheet({
  title,
  sub,
  items,
  footer,
}: {
  title: string;
  sub?: string;
  items?: Array<{ ic: string; bold: string; text: string }>;
  footer?: string;
}) {
  const t = useTheme();
  return (
    <View>
      <SheetTitle title={title} sub={sub} />
      {items?.map((it, i) => (
        <View key={i} style={{ flexDirection: "row", gap: 9, marginBottom: 9, alignItems: "flex-start" }}>
          <IconSq name={it.ic} size={20} iconSize={12} radius={6} />
          <Text style={{ flex: 1, fontFamily: t.fonts.body, fontSize: 11.5, color: t.colors.inkSoft, lineHeight: 17 }}>
            <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.ink }}>{it.bold}</Text> {it.text}
          </Text>
        </View>
      ))}
      {footer ? <BodyText style={{ marginTop: 8 }}>{footer}</BodyText> : null}
    </View>
  );
}

export function KycSheet({ onDone }: { onDone: () => void }) {
  const t = useTheme();
  const { closeSheet } = useSheet();
  const toast = useToast();
  const [step, setStep] = useState(1);
  const [src, setSrc] = useState<string | null>(null);

  const StepBar = (
    <View style={{ flexDirection: "row", gap: 8, marginBottom: 14 }}>
      {[1, 2, 3].map((i) => (
        <View
          key={i}
          style={{ flex: 1, height: 5, borderRadius: 99, backgroundColor: i <= step ? t.colors.teal : t.colors.mint }}
        />
      ))}
    </View>
  );

  if (step === 1) {
    return (
      <View>
        <SheetTitle title="Verify identity · step 1 of 3" />
        {StepBar}
        <BodyText style={{ marginBottom: 12 }}>Enter your National ID exactly as printed. We verify against the national register.</BodyText>
        <TextInput
          defaultValue="1992 2694 8615"
          style={{
            fontFamily: t.fonts.body, fontSize: 14, color: t.colors.ink, padding: 13, borderWidth: 1.5,
            borderColor: t.colors.line, borderRadius: 12, backgroundColor: t.colors.mintSoft, marginBottom: 10,
          }}
        />
        <TextInput
          defaultValue="14-02-1992"
          style={{
            fontFamily: t.fonts.body, fontSize: 14, color: t.colors.ink, padding: 13, borderWidth: 1.5,
            borderColor: t.colors.line, borderRadius: 12, backgroundColor: t.colors.mintSoft, marginBottom: 10,
          }}
        />
        <Btn label="Continue" icon="chev" onPress={() => setStep(2)} />
      </View>
    );
  }
  if (step === 2) {
    return (
      <View>
        <SheetTitle title="Verify identity · step 2 of 3" />
        {StepBar}
        <BodyText style={{ marginBottom: 12 }}>Liveness check: hold your face inside the frame. We match your selfie to the NID photo.</BodyText>
        <View
          style={{
            width: 150, height: 150, borderRadius: 75, borderWidth: 3, borderStyle: "dashed",
            borderColor: t.colors.teal, alignSelf: "center", alignItems: "center", justifyContent: "center", marginVertical: 10,
          }}
        >
          <Icon name="camera" size={34} color={t.colors.teal} />
        </View>
        <Btn label="Capture and match" icon="camera" onPress={() => setStep(3)} />
      </View>
    );
  }
  return (
    <View>
      <SheetTitle title="Verify identity · step 3 of 3" />
      {StepBar}
      <BodyText style={{ marginBottom: 12 }}>Source of funds (AML requirement). Pick the main origin of the money you will invest.</BodyText>
      <ChipRow
        options={["Salary", "Business income", "Savings", "Remittance"].map((x) => ({ key: x, label: x }))}
        selected={src}
        onSelect={setSrc}
      />
      <Btn
        label="Finish verification"
        icon="check"
        disabled={!src}
        onPress={() => {
          onDone();
          closeSheet();
          toast("Identity verified. Tier 2 unlocked, deposits enabled");
        }}
      />
    </View>
  );
}
