import React, { useMemo, useState } from "react";
import { Pressable, Text, TextInput, View } from "react-native";
import { useNavigation } from "@react-navigation/native";

import { useTheme } from "@/theme";
import { useApp } from "@/state/AppState";
import { CAMPS, CONTRACT_COLORS, STRATEGIES } from "@/state/data";
import { tk } from "@/utils/format";
import { Screen, HRow } from "@/components/chrome";
import { Icon } from "@/components/Icon";
import { Card, Kicker, Sec, Pill, ProgressBar, FootDis, Empty, Btn, IconSq, BodyText } from "@/components/ui";
import { useSheet } from "@/components/Sheet";
import { useToast } from "@/components/Toast";
import { SheetTitle, ChipRow } from "@/sheets/sheets";

type Seg = "all" | "open" | "matured" | "saved";

function AutoInvestSheet() {
  const t = useTheme();
  const app = useApp();
  const { closeSheet } = useSheet();
  const toast = useToast();
  const [pick, setPick] = useState<string | null>(app.s.autoStrategy);

  return (
    <View>
      <SheetTitle
        title="Auto-invest strategy"
        sub="Pick a strategy; matching campaigns queue for your approval. Nothing deploys without your per-deal confirmation."
      />
      {STRATEGIES.map((s) => {
        const on = pick === s.id;
        return (
          <Pressable
            key={s.id}
            onPress={() => setPick(s.id)}
            style={{
              borderWidth: 1.5,
              borderColor: on ? t.colors.teal : t.colors.line,
              backgroundColor: on ? t.colors.mintSoft : "transparent",
              borderRadius: 14,
              padding: 13,
              marginBottom: 10,
            }}
          >
            <View style={{ flexDirection: "row", justifyContent: "space-between", alignItems: "center" }}>
              <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 13, color: t.colors.ink }}>{s.name}</Text>
              <View
                style={{
                  width: 20,
                  height: 20,
                  borderRadius: 10,
                  borderWidth: 2,
                  borderColor: on ? t.colors.teal : t.colors.line,
                  backgroundColor: on ? t.colors.teal : "transparent",
                  alignItems: "center",
                  justifyContent: "center",
                }}
              >
                {on ? <Icon name="check" size={12} color={t.colors.white} /> : null}
              </View>
            </View>
            <Text style={{ fontFamily: t.fonts.body, fontSize: 11, color: t.colors.inkSoft, marginTop: 3, lineHeight: 16 }}>
              {s.desc}
            </Text>
            <View style={{ flexDirection: "row", height: 8, borderRadius: 99, overflow: "hidden", marginTop: 9 }}>
              {s.mix.map(([name, pct, color]) => (
                <View key={name} style={{ width: `${pct}%`, backgroundColor: color }} />
              ))}
            </View>
            <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft, marginTop: 5 }}>{s.band}</Text>
          </Pressable>
        );
      })}
      <Btn
        label={pick ? "Save strategy" : "Pick a strategy"}
        icon="check"
        disabled={!pick}
        onPress={() => {
          app.set("autoStrategy", pick);
          closeSheet();
          toast("Strategy saved. Each deployment still needs your approval");
        }}
      />
    </View>
  );
}

function FiltersSheet({
  contract,
  sector,
  onApply,
}: {
  contract: string;
  sector: string;
  onApply: (c: string, s: string) => void;
}) {
  const { closeSheet } = useSheet();
  const [c, setC] = useState(contract);
  const [s, setS] = useState(sector);
  const t = useTheme();

  return (
    <View>
      <SheetTitle title="Filters" />
      <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 11, color: t.colors.ink, marginBottom: 7 }}>Contract</Text>
      <ChipRow
        options={["any", "Murabaha", "Wakalah"].map((x) => ({ key: x, label: x === "any" ? "Any" : x }))}
        selected={c}
        onSelect={setC}
      />
      <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 11, color: t.colors.ink, marginBottom: 7 }}>Sector</Text>
      <ChipRow
        options={["any", "Printing and Packaging", "Printing Equipment", "Building Materials"].map((x) => ({
          key: x,
          label: x === "any" ? "Any" : x,
        }))}
        selected={s}
        onSelect={setS}
      />
      <Btn
        label="Apply filters"
        icon="filter"
        onPress={() => {
          onApply(c, s);
          closeSheet();
        }}
      />
    </View>
  );
}

function CompareSheet() {
  const t = useTheme();
  const [picks, setPicks] = useState<string[]>(["zone", "purchase"]);

  const toggle = (id: string) =>
    setPicks((p) => (p.includes(id) ? p.filter((x) => x !== id) : p.length < 3 ? [...p, id] : p));

  return (
    <View>
      <SheetTitle title="Compare campaigns" sub="Pick two or three. Contract and risk sit above return by design." />
      {CAMPS.map((c) => {
        const on = picks.includes(c.id);
        return (
          <Pressable key={c.id} onPress={() => toggle(c.id)} style={{ flexDirection: "row", alignItems: "center", gap: 9, paddingVertical: 9 }}>
            <View
              style={{
                width: 18,
                height: 18,
                borderRadius: 4,
                borderWidth: 1.5,
                borderColor: on ? t.colors.teal : t.colors.line,
                backgroundColor: on ? t.colors.teal : "transparent",
                alignItems: "center",
                justifyContent: "center",
              }}
            >
              {on ? <Icon name="check" size={12} color={t.colors.white} /> : null}
            </View>
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 12, color: t.colors.ink }}>{c.title.split("·")[0].trim()}</Text>
          </Pressable>
        );
      })}
      <View style={{ flexDirection: "row", gap: 9, marginTop: 12 }}>
        {picks.slice(0, 3).map((id) => {
          const c = CAMPS.find((x) => x.id === id)!;
          return (
            <View key={id} style={{ flex: 1, backgroundColor: t.colors.mintSoft, borderWidth: 1, borderColor: t.colors.line, borderRadius: 13, padding: 12 }}>
              <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 11, color: t.colors.ink, minHeight: 30 }}>
                {c.title.split("·")[0].trim()}
              </Text>
              {[
                ["Contract", c.contract],
                ["Risk", c.risk],
                ["Tenure", c.tenure + "d"],
                ["P/lac", tk(c.ppl)],
                ["Share", c.share + "%"],
                ["Status", c.status],
              ].map(([l, v]) => (
                <View key={l} style={{ flexDirection: "row", justifyContent: "space-between", paddingVertical: 5, borderTopWidth: 1, borderTopColor: t.colors.line }}>
                  <Text style={{ fontFamily: t.fonts.body, fontSize: 9.5, color: t.colors.inkSoft }}>{l}</Text>
                  <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 9.5, color: t.colors.ink }}>{v}</Text>
                </View>
              ))}
            </View>
          );
        })}
      </View>
      <FootDis left>A higher profit-per-lac on a higher-risk deal is not a better deal.</FootDis>
    </View>
  );
}

export function InvestScreen() {
  const t = useTheme();
  const app = useApp();
  const nav = useNavigation<any>();
  const { openSheet } = useSheet();
  const toast = useToast();
  const [seg, setSeg] = useState<Seg>("all");
  const [search, setSearch] = useState("");
  const [fContract, setFContract] = useState("any");
  const [fSector, setFSector] = useState("any");

  const rows = useMemo(() => {
    const q = search.toLowerCase();
    return CAMPS.filter((c) => {
      if (seg === "saved") return app.s.watch.includes(c.id);
      if (seg !== "all" && c.status !== seg) return false;
      if (fContract !== "any" && c.contract !== fContract) return false;
      if (fSector !== "any" && c.sector !== fSector) return false;
      if (q && !(c.title + " " + c.sector + " " + c.contract).toLowerCase().includes(q)) return false;
      return true;
    });
  }, [seg, search, fContract, fSector, app.s.watch]);

  const filterCount = (fContract !== "any" ? 1 : 0) + (fSector !== "any" ? 1 : 0);
  const insights = useMemo(() => {
    const byContract: Record<string, number> = {};
    let total = 0;
    CAMPS.forEach((c) => {
      if (c.status !== "matured") {
        byContract[c.contract] = (byContract[c.contract] || 0) + c.raised;
        total += c.raised;
      }
    });
    return Object.keys(byContract).map((k) => ({ k, pct: Math.round((byContract[k] / total) * 100) }));
  }, []);

  const strategy = STRATEGIES.find((s) => s.id === app.s.autoStrategy);

  return (
    <Screen>
      <HRow label="Marketplace" title="Campaigns" onAvatar={() => nav.navigate("MeTab", { screen: "Me" })} />

      <View
        style={{
          flexDirection: "row",
          alignItems: "center",
          gap: 9,
          backgroundColor: t.colors.mintSoft,
          borderRadius: 14,
          paddingHorizontal: 13,
          paddingVertical: 4,
          marginBottom: 11,
        }}
      >
        <Icon name="search" size={16} color={t.colors.inkSoft} />
        <TextInput
          value={search}
          onChangeText={setSearch}
          placeholder="Search campaigns, sectors"
          placeholderTextColor={t.colors.inkSoft}
          style={{ flex: 1, fontFamily: t.fonts.body, fontSize: 13, color: t.colors.ink, paddingVertical: 9 }}
        />
        <Pressable
          onPress={() => openSheet(<FiltersSheet contract={fContract} sector={fSector} onApply={(c, s) => { setFContract(c); setFSector(s); }} />)}
          style={{ flexDirection: "row", alignItems: "center", gap: 5, paddingLeft: 9, borderLeftWidth: 1, borderLeftColor: t.colors.line }}
        >
          <Icon name="filter" size={14} color={t.colors.teal} />
          <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 11, color: t.colors.teal }}>Filters</Text>
          {filterCount ? (
            <View style={{ backgroundColor: t.colors.green, borderRadius: 99, paddingHorizontal: 6, paddingVertical: 1 }}>
              <Text style={{ fontFamily: t.fonts.bodyBold, fontSize: 9, color: "#03251D" }}>{filterCount}</Text>
            </View>
          ) : null}
        </Pressable>
      </View>

      <Card solid onPress={() => openSheet(<AutoInvestSheet />)}>
        <View style={{ flexDirection: "row", alignItems: "center", gap: 12 }}>
          <IconSq name="refresh" size={40} iconSize={18} radius={13} />
          <View style={{ flex: 1 }}>
            <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 13.5, color: t.colors.ink }}>Auto-invest strategy</Text>
            <Text style={{ fontFamily: t.fonts.body, fontSize: 11, color: t.colors.inkSoft, marginTop: 1 }}>
              {strategy ? strategy.name + " · each deployment needs your approval" : "Off · pick a strategy, approve each deployment"}
            </Text>
          </View>
          <Icon name="chev" size={16} color={t.colors.inkSoft} />
        </View>
      </Card>

      <View style={{ flexDirection: "row", borderBottomWidth: 1, borderBottomColor: t.colors.line, marginBottom: 6 }}>
        {(["all", "open", "matured", "saved"] as Seg[]).map((k) => {
          const on = seg === k;
          return (
            <Pressable key={k} onPress={() => setSeg(k)} style={{ flex: 1, alignItems: "center", paddingVertical: 11 }}>
              <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 11.5, color: on ? t.colors.ink : t.colors.inkSoft }}>
                {k[0].toUpperCase() + k.slice(1)}
              </Text>
              {on ? (
                <View style={{ position: "absolute", bottom: -1, left: "14%", right: "14%", height: 2, backgroundColor: t.colors.teal, borderRadius: 2 }} />
              ) : null}
            </Pressable>
          );
        })}
      </View>

      {rows.length === 0 ? (
        <Empty>
          {seg === "saved"
            ? "No saved campaigns yet.\nTap the bookmark on any campaign to follow it."
            : "No campaigns match.\nTry clearing filters or search."}
        </Empty>
      ) : (
        rows.map((c) => {
          const pct = Math.min(100, Math.round((c.raised / c.pool) * 100));
          const watched = app.s.watch.includes(c.id);
          return (
            <Pressable
              key={c.id}
              onPress={() => nav.navigate("CampaignDetail", { campId: c.id })}
              style={{ paddingVertical: 15, borderBottomWidth: 1, borderBottomColor: t.colors.line }}
            >
              <View style={{ flexDirection: "row", justifyContent: "space-between", gap: 8, alignItems: "flex-start" }}>
                <View style={{ maxWidth: "70%" }}>
                  <Text style={{ fontFamily: t.fonts.bodySemi, fontSize: 13.5, color: t.colors.ink, lineHeight: 17 }}>{c.title}</Text>
                  <Text style={{ fontFamily: t.fonts.body, fontSize: 11, color: t.colors.inkSoft, marginTop: 1 }}>{c.sector}</Text>
                </View>
                <View style={{ flexDirection: "row", gap: 8, alignItems: "center" }}>
                  <Pill kind={c.status === "open" ? "open" : c.status === "matured" ? "matured" : "recovery"} label={c.status === "open" ? "Open" : c.status === "matured" ? "Matured" : "In recovery"} />
                  <Pressable
                    hitSlop={8}
                    onPress={() => {
                      const added = app.toggleWatch(c.id);
                      toast(added ? "Saved, we will alert you before it closes" : "Removed from watchlist");
                    }}
                  >
                    <Icon name="bookmark" size={15} color={watched ? t.colors.gold : t.colors.inkSoft} />
                  </Pressable>
                </View>
              </View>
              <View style={{ marginTop: 8 }}>
                <Pill kind="contract" label={c.contract} />
              </View>
              <View style={{ flexDirection: "row", gap: 12, marginTop: 10, flexWrap: "wrap" }}>
                <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft }}>
                  Profit/lac <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.ink }}>{tk(c.ppl)}</Text>
                </Text>
                <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft }}>
                  Your share <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.ink }}>{c.share}%</Text>
                </Text>
                <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft }}>
                  Tenure <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.ink }}>{c.tenure}d</Text>
                </Text>
              </View>
              <ProgressBar pct={pct} bad={c.status === "recovery"} style={{ marginTop: 10 }} />
              <View style={{ flexDirection: "row", gap: 12, marginTop: 10 }}>
                <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft }}>{c.investors} investors</Text>
                {c.status === "open" ? (
                  <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft }}>{c.daysLeft}d left</Text>
                ) : null}
                <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft }}>
                  Risk <Text style={{ fontFamily: t.fonts.bodySemi, color: t.colors.ink }}>{c.risk}</Text>
                </Text>
              </View>
            </Pressable>
          );
        })
      )}

      <View style={{ height: 13 }} />
      <Btn kind="ghost" label="Compare campaigns side by side" icon="columns" onPress={() => openSheet(<CompareSheet />)} />

      <Card style={{ marginTop: 6 }}>
        <Kicker>Portfolio insights</Kicker>
        <Sec>Your diversification</Sec>
        <View style={{ flexDirection: "row", height: 10, borderRadius: 99, overflow: "hidden", marginBottom: 7 }}>
          {insights.map((x) => (
            <View key={x.k} style={{ width: `${x.pct}%`, backgroundColor: CONTRACT_COLORS[x.k] ?? t.colors.green }} />
          ))}
        </View>
        <View style={{ flexDirection: "row", gap: 12, flexWrap: "wrap" }}>
          {insights.map((x) => (
            <View key={x.k} style={{ flexDirection: "row", alignItems: "center", gap: 5 }}>
              <View style={{ width: 9, height: 9, borderRadius: 3, backgroundColor: CONTRACT_COLORS[x.k] ?? t.colors.green }} />
              <Text style={{ fontFamily: t.fonts.body, fontSize: 10.5, color: t.colors.inkSoft }}>
                {x.k} {x.pct}%
              </Text>
            </View>
          ))}
        </View>
        <View style={{ flexDirection: "row", justifyContent: "space-between", marginTop: 10, paddingTop: 10, borderTopWidth: 1, borderTopColor: t.colors.line, borderStyle: "dashed" }}>
          {[
            ["Projected (matured)", "৳3,937"],
            ["Actual received", "৳3,937"],
            ["Accuracy", "100%"],
          ].map(([l, v]) => (
            <View key={l}>
              <Text style={{ fontFamily: t.fonts.body, fontSize: 11, color: t.colors.inkSoft }}>{l}</Text>
              <Text style={{ fontFamily: t.fonts.display, fontSize: 14, color: t.colors.ink, marginTop: 2 }}>{v}</Text>
            </View>
          ))}
        </View>
      </Card>

      <FootDis>
        Every campaign is screened for riba, gharar and maysir, and reviewed under our Shariah framework before listing.
      </FootDis>
    </Screen>
  );
}
