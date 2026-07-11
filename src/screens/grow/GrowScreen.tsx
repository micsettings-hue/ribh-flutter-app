import React, { useState } from "react";
import { Pressable, Text, TextInput, View } from "react-native";
import Svg, { Circle } from "react-native-svg";
import { useNavigation } from "@react-navigation/native";

import { useTheme } from "@/theme";
import { useApp } from "@/state/AppState";
import { tk, groupIndian, parseNum } from "@/utils/format";
import { Screen, HRow } from "@/components/chrome";
import { Icon } from "@/components/Icon";
import { Card, Kicker, Sec, Btn, FootDis, SeeAll, BodyText, Sw2 } from "@/components/ui";
import { GoalRow } from "@/components/GoalRow";
import { useSheet } from "@/components/Sheet";
import { useToast } from "@/components/Toast";
import { NewGoalSheet, GoalAddSheet, InfoSheet, ChipRow, SheetTitle } from "@/sheets/sheets";

function ZkInput({ label, value, onChange }: { label: string; value: string; onChange: (v: string) => void }) {
  const t = useTheme();
  return (
    <View>
      <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 11, color: t.colors.ink, marginTop: 9 }}>{label}</Text>
      <TextInput
        value={value}
        onChangeText={(x) => {
          const n = parseNum(x);
          onChange(n ? groupIndian(n) : "");
        }}
        keyboardType="numeric"
        style={{
          fontFamily: t.fonts.body,
          fontSize: 13,
          color: t.colors.ink,
          padding: 12,
          borderWidth: 1.5,
          borderColor: t.colors.line,
          borderRadius: 10,
          backgroundColor: t.colors.mintSoft,
          marginTop: 5,
        }}
      />
    </View>
  );
}

function AutosaveSheet() {
  const t = useTheme();
  const app = useApp();
  const { closeSheet } = useSheet();
  const toast = useToast();
  const [amt, setAmt] = useState(String(app.s.autosaveAmount));

  return (
    <View>
      <SheetTitle
        title="Weekly auto-save"
        sub="A recurring deposit into the Ribh Fund, from Tk250 a week. Recurring deposit is fine; deployment still routes through per-deal approval."
      />
      <ChipRow
        options={["250", "500", "1000"].map((x) => ({ key: x, label: "৳" + x + " / week" }))}
        selected={amt}
        onSelect={setAmt}
      />
      <Btn
        label={app.s.autosaveOn ? "Update auto-save" : "Turn on auto-save"}
        icon="repeat"
        onPress={() => {
          app.set("autosaveOn", true);
          app.set("autosaveAmount", parseInt(amt, 10));
          closeSheet();
          toast("Weekly auto-save of ৳" + amt + " is on");
        }}
      />
      {app.s.autosaveOn ? (
        <>
          <View style={{ height: 9 }} />
          <Btn
            kind="ghost"
            label="Turn off"
            onPress={() => {
              app.set("autosaveOn", false);
              closeSheet();
              toast("Auto-save turned off");
            }}
          />
        </>
      ) : null}
    </View>
  );
}

const LESSONS = [
  { id: "l1", n: 1, t: "What makes a return halal", s: "Riba vs. profit from real trade · 4 min" },
  { id: "l2", n: 2, t: "Reading a Murabaha contract", s: "Cost, markup, and why time cannot change it · 5 min" },
  { id: "l3", n: 3, t: "Zakat on investments", s: "What counts, and when the hawl completes · 4 min" },
];

export function GrowScreen() {
  const t = useTheme();
  const app = useApp();
  const nav = useNavigation<any>();
  const { openSheet } = useSheet();
  const toast = useToast();

  const [zkCash, setZkCash] = useState("2,00,000");
  const [zkInv, setZkInv] = useState("4,50,000");
  const [zkGold, setZkGold] = useState("80,000");
  const zakatDue = (parseNum(zkCash) + parseNum(zkInv) + parseNum(zkGold)) * 0.025;

  const chalPct = app.s.challenge ? app.s.chalDay / 30 : 0;

  return (
    <Screen>
      <HRow label="Mini-apps" title="Grow" onAvatar={() => nav.navigate("MeTab", { screen: "Me" })} />

      <Card solid>
        <Kicker>Zakat calculator</Kicker>
        <Sec>Purify your wealth</Sec>
        <ZkInput label="Cash and bank (৳)" value={zkCash} onChange={setZkCash} />
        <ZkInput label="Ribh investments, auto-filled (৳)" value={zkInv} onChange={setZkInv} />
        <ZkInput label="Gold and other zakatable assets (৳)" value={zkGold} onChange={setZkGold} />
        <View
          style={{
            marginTop: 12,
            paddingTop: 11,
            borderTopWidth: 1,
            borderTopColor: t.colors.line,
            borderStyle: "dashed",
            flexDirection: "row",
            justifyContent: "space-between",
            alignItems: "baseline",
          }}
        >
          <Text style={{ fontFamily: t.fonts.body, fontSize: 11, color: t.colors.inkSoft }}>Zakat due (2.5%)</Text>
          <Text style={{ fontFamily: t.fonts.display, fontSize: 21, color: t.colors.gold }}>{tk(zakatDue)}</Text>
        </View>
        <View style={{ height: 10 }} />
        <Btn
          label="Pay via Ribh charity"
          icon="heart"
          onPress={() => {
            app.give(Math.round(zakatDue));
            toast(tk(zakatDue) + " zakat paid via Ribh charity");
          }}
        />
      </Card>

      <Card>
        <SeeAll label="Goal pots" linkLabel="New goal" onPress={() => openSheet(<NewGoalSheet />)} />
        <Sec>Save with a niyyah</Sec>
        {app.s.goals.map((g, i) => (
          <GoalRow key={g.id} goal={g} last={i === app.s.goals.length - 1} onPress={() => openSheet(<GoalAddSheet goalId={g.id} />)} />
        ))}
        <FootDis left>
          Goals are targets you save toward. Money placed in campaigns or the fund remains at risk; targets are not guaranteed.
        </FootDis>
      </Card>

      <Card solid>
        <Kicker>Nisab tracker</Kicker>
        <Sec>Are you above nisab?</Sec>
        {[
          ["Gold nisab (85g)", "৳10,54,000"],
          ["Silver nisab (595g)", "৳89,250"],
          ["Your zakatable wealth", "৳7,30,000"],
        ].map(([l, v], i) => (
          <View
            key={l}
            style={{
              flexDirection: "row",
              justifyContent: "space-between",
              paddingVertical: 9,
              borderBottomWidth: i < 2 ? 1 : 0,
              borderBottomColor: t.colors.mintSoft,
            }}
          >
            <Text style={{ fontFamily: t.fonts.body, fontSize: 12, color: t.colors.inkSoft }}>{l}</Text>
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12, color: t.colors.ink }}>{v}</Text>
          </View>
        ))}
        <View
          style={{
            marginTop: 11,
            padding: 12,
            borderRadius: 12,
            backgroundColor: t.colors.mintSoft,
            borderWidth: 1,
            borderColor: t.colors.line,
          }}
        >
          <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 11.5, lineHeight: 17, color: t.mode === "dark" ? t.colors.green : t.colors.tealDeep }}>
            Above the silver nisab. Zakat is due on your wealth once a lunar year passes on it (hawl).
          </Text>
        </View>
        <Text style={{ fontFamily: t.fonts.body, fontSize: 9.5, color: t.colors.inkSoft, marginTop: 8, textAlign: "right" }}>
          Prices illustrative, as of today. Live feed in the native app.
        </Text>
      </Card>

      <Card>
        <Kicker>Ribh Fund · ৳10 a day</Kicker>
        <Sec>Small daily, big barakah</Sec>
        <BodyText>Your daily ৳10 flows into the diversified Ribh Fund. Profit is projected, never guaranteed.</BodyText>
        <View style={{ flexDirection: "row", gap: 4, marginTop: 9 }}>
          {["S", "M", "T", "W", "T", "F", "S"].map((d, i) => {
            const hit = i < 5 || (i === 5 && app.s.savedToday);
            return (
              <View
                key={i}
                style={{
                  flex: 1,
                  height: 28,
                  borderRadius: 7,
                  backgroundColor: hit ? t.colors.teal : t.colors.mint,
                  alignItems: "center",
                  justifyContent: "center",
                }}
              >
                <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 9, color: hit ? t.colors.white : t.colors.teal }}>{d}</Text>
              </View>
            );
          })}
        </View>
        <View style={{ flexDirection: "row", gap: 9, marginTop: 11 }}>
          {[
            ["Saved so far", tk(app.s.saved)],
            ["Streak", app.s.streak + " days"],
            ["Projected value", "৳1,905"],
          ].map(([l, v]) => (
            <View key={l} style={{ flex: 1, backgroundColor: t.colors.mintSoft, borderWidth: 1, borderColor: t.colors.line, borderRadius: 11, paddingVertical: 9, paddingHorizontal: 11 }}>
              <Text style={{ fontFamily: t.fonts.body, fontSize: 9.5, color: t.colors.inkSoft, textTransform: "uppercase", letterSpacing: 0.5 }}>{l}</Text>
              <Text style={{ fontFamily: t.fonts.display, fontSize: 16, color: t.colors.teal, marginTop: 1 }}>{v}</Text>
            </View>
          ))}
        </View>
        <View style={{ marginTop: 10, gap: 7 }}>
          {(
            [
              ["Murabaha", 62],
              ["Wakalah", 28],
              ["Liquidity", 10],
            ] as Array<[string, number]>
          ).map(([nm, pct]) => (
            <View key={nm} style={{ flexDirection: "row", alignItems: "center", gap: 9 }}>
              <Text style={{ width: 86, fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft }}>{nm}</Text>
              <View style={{ flex: 1, height: 7, backgroundColor: t.colors.mint, borderRadius: 99, overflow: "hidden" }}>
                <View style={{ width: `${pct}%`, height: "100%", backgroundColor: t.colors.green }} />
              </View>
              <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft }}>{pct}%</Text>
            </View>
          ))}
        </View>
        <View style={{ height: 10 }} />
        <Btn
          kind="ghost"
          label={app.s.savedToday ? "Today's ৳10 saved, alhamdulillah" : "Mark today's ৳10 saved"}
          icon="check"
          onPress={() => {
            if (app.s.savedToday) return;
            app.markSavedToday();
            toast("৳10 saved into the Ribh Fund");
          }}
        />
        <View style={{ height: 8 }} />
        <Btn
          kind="ghost"
          label={app.s.autosaveOn ? "Weekly auto-save on · ৳" + app.s.autosaveAmount : "Set up weekly auto-save"}
          icon="repeat"
          onPress={() => openSheet(<AutosaveSheet />)}
        />
      </Card>

      <Card solid>
        <View style={{ flexDirection: "row", justifyContent: "space-between", alignItems: "center" }}>
          <View style={{ flex: 1 }}>
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12.5, color: t.colors.ink }}>Round-up saving</Text>
            <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft, marginTop: 1 }}>
              Round each payment up, sweep the change
            </Text>
          </View>
          <Sw2 on={app.s.roundup} onToggle={() => app.set("roundup", !app.s.roundup)} />
        </View>
        <View style={{ alignItems: "center", paddingVertical: 6 }}>
          <Text style={{ fontFamily: t.fonts.displaySemi, fontSize: 30, color: t.colors.teal }}>{tk(app.s.roundupAccum)}</Text>
          <Text style={{ fontFamily: t.fonts.body, fontSize: 11, color: t.colors.inkSoft }}>rounded up, ready to sweep</Text>
        </View>
        <Btn
          kind="ghost"
          label="Sweep into Ribh Fund"
          icon="arrdown"
          disabled={!app.s.roundup || app.s.roundupAccum < 1}
          onPress={() => {
            const v = app.s.roundupAccum;
            app.sweepRoundup();
            toast(tk(v) + " swept into the Ribh Fund");
          }}
        />
        <FootDis left>Round-ups move only your own verified funds. Nothing is added from outside your wallet.</FootDis>
      </Card>

      <Card solid>
        <Kicker>Seasonal challenge</Kicker>
        <Sec>30-day barakah challenge</Sec>
        <View style={{ flexDirection: "row", alignItems: "center", gap: 13 }}>
          <View style={{ width: 64, height: 64 }}>
            <Svg width={64} height={64} viewBox="0 0 64 64" style={{ transform: [{ rotate: "-90deg" }] }}>
              <Circle cx={32} cy={32} r={27} stroke={t.colors.mint} strokeWidth={6} fill="none" />
              <Circle
                cx={32}
                cy={32}
                r={27}
                stroke={t.colors.green}
                strokeWidth={6}
                fill="none"
                strokeLinecap="round"
                strokeDasharray={170}
                strokeDashoffset={170 - 170 * chalPct}
              />
            </Svg>
            <View style={{ position: "absolute", top: 0, left: 0, right: 0, bottom: 0, alignItems: "center", justifyContent: "center" }}>
              <Text style={{ fontFamily: t.fonts.bodyBold, fontSize: 13, color: t.colors.ink }}>{app.s.chalDay}</Text>
            </View>
          </View>
          <View style={{ flex: 1 }}>
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 13, color: t.colors.ink }}>Save and give, every day</Text>
            <Text style={{ fontFamily: t.fonts.body, fontSize: 11, color: t.colors.inkSoft, marginTop: 2, lineHeight: 16 }}>
              Complete all five daily activities to advance. Consistency, not competition.
            </Text>
          </View>
        </View>
        <View style={{ height: 11 }} />
        <Btn
          label={app.s.challenge ? "Joined · day " + app.s.chalDay + " of 30" : "Join the challenge"}
          icon="check"
          onPress={() => {
            const joining = !app.s.challenge;
            app.set("challenge", joining);
            app.set("chalDay", joining ? 7 : 0);
            toast(joining ? "Challenge joined, day 7 of 30" : "Left the challenge");
          }}
        />
      </Card>

      <Card>
        <View
          style={{
            alignSelf: "flex-start",
            backgroundColor: t.colors.mint,
            borderRadius: 99,
            paddingHorizontal: 9,
            paddingVertical: 3,
            marginBottom: 8,
          }}
        >
          <Text style={{ fontFamily: t.fonts.bodyBold, fontSize: 9.5, letterSpacing: 0.6, textTransform: "uppercase", color: t.mode === "dark" ? t.colors.green : t.colors.tealDeep }}>
            By Ribh Welfare
          </Text>
        </View>
        <Kicker>Halal money lessons</Kicker>
        <Sec>Five minutes to wiser wealth</Sec>
        {LESSONS.map((l, i) => (
          <Pressable
            key={l.id}
            onPress={() => {
              app.set("lessons", { ...app.s.lessons, [l.id]: true });
              openSheet(
                <InfoSheet
                  title={l.t}
                  sub={l.s}
                  items={[
                    { ic: "book", bold: "Lesson summary", text: "· plain-language walkthrough with one hadith, one data point, one action." },
                    { ic: "check", bold: "Marked complete", text: "· your progress is saved on this device." },
                  ]}
                />
              );
            }}
            style={{
              flexDirection: "row",
              alignItems: "center",
              gap: 11,
              paddingVertical: 11,
              borderBottomWidth: i < LESSONS.length - 1 ? 1 : 0,
              borderBottomColor: t.colors.mintSoft,
            }}
          >
            <View style={{ width: 30, height: 30, borderRadius: 9, backgroundColor: t.colors.mint, alignItems: "center", justifyContent: "center" }}>
              <Text style={{ fontFamily: t.fonts.bodyBold, fontSize: 12, color: t.mode === "dark" ? t.colors.green : t.colors.tealDeep }}>{l.n}</Text>
            </View>
            <View style={{ flex: 1 }}>
              <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12.5, color: t.colors.ink }}>{l.t}</Text>
              <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft }}>{l.s}</Text>
            </View>
            {app.s.lessons[l.id] ? <Icon name="check" size={16} color={t.colors.teal} /> : null}
          </Pressable>
        ))}
      </Card>

      <Card solid>
        <View style={{ flexDirection: "row", justifyContent: "space-between", alignItems: "baseline" }}>
          <Kicker>Your forest</Kicker>
          <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft }}>Nilphamari</Text>
        </View>
        <Sec>1 tree, every month</Sec>
        <View style={{ flexDirection: "row", gap: 9 }}>
          {[
            ["Trees", "8"],
            ["CO2", "1.9 t"],
            ["Survival", "100%"],
          ].map(([l, v]) => (
            <View key={l} style={{ flex: 1, backgroundColor: t.colors.mintSoft, borderWidth: 1, borderColor: t.colors.line, borderRadius: 11, paddingVertical: 9, paddingHorizontal: 11 }}>
              <Text style={{ fontFamily: t.fonts.body, fontSize: 9.5, color: t.colors.inkSoft, textTransform: "uppercase", letterSpacing: 0.5 }}>{l}</Text>
              <Text style={{ fontFamily: t.fonts.display, fontSize: 16, color: t.colors.teal, marginTop: 1 }}>{v}</Text>
            </View>
          ))}
        </View>
        <View style={{ flexDirection: "row", flexWrap: "wrap", gap: 7, marginTop: 10 }}>
          {Array.from({ length: 20 }, (_, m) => (
            <View
              key={m}
              style={{
                width: 22,
                height: 22,
                borderRadius: 11,
                backgroundColor: m < 8 ? t.colors.gold : m < 14 ? t.colors.green : t.colors.mint,
              }}
            />
          ))}
        </View>
        <FootDis left>
          Each dot is a month of membership. Gold dots are trees planted this year, sadaqah jariyah in your name.
        </FootDis>
      </Card>

      <Card
        onPress={() =>
          openSheet(
            <InfoSheet
              title="Halal comparison"
              sub="Contract type, asset-backing and risk, not just headline return."
              items={[
                { ic: "box", bold: "Murabaha", text: "· asset-backed sale at fixed disclosed markup. Steadier." },
                { ic: "briefcase", bold: "Wakalah", text: "· agency deployment for a disclosed fee. Indicative returns." },
                { ic: "users", bold: "Musharakah", text: "· shared profit and loss by ratio. Widest range of outcomes." },
              ]}
              footer="Compare before you commit. A higher headline return on a higher-risk structure is not a better deal."
            />
          )
        }
      >
        <Kicker>Halal comparison</Kicker>
        <Sec style={{ marginBottom: 2 }}>Compare before you commit</Sec>
        <BodyText>Contract type, asset-backing and risk, not just headline return.</BodyText>
      </Card>
    </Screen>
  );
}
