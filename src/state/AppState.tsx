import React, { createContext, useContext, useMemo, useState } from "react";

import { tk } from "@/utils/format";

export type LedgerEntry = { sign: "+" | "-" | "!"; t: string; s: string; amt: string };
export type Goal = { id: string; t: string; ic: string; saved: number; target: number };
export type Habit = { id: string; t: string; s: string; ic: string; done: boolean };

type AppState = {
  kyc: boolean;
  avail: number;
  deployed: number;
  inRecovery: number;
  given: number;
  meals: number;
  saved: number;
  streak: number;
  savedToday: boolean;
  tas: number;
  pendingPayout: number;
  payoutPlan: string;
  quiet: boolean;
  reminders: boolean;
  bio: boolean;
  tfa: boolean;
  watch: string[];
  roundup: boolean;
  roundupAccum: number;
  challenge: boolean;
  chalDay: number;
  autoStrategy: string | null;
  riskTier: string | null;
  depositProvider: "bkash" | "nagad" | "bank";
  nominee: string | null;
  autosaveOn: boolean;
  autosaveAmount: number;
  purified: number;
  lessons: Record<string, boolean>;
  goals: Goal[];
  habits: Habit[];
  ledger: LedgerEntry[];
  notifRead: boolean;
};

const INITIAL: AppState = {
  kyc: false,
  avail: 86450,
  deployed: 400000,
  inRecovery: 50000,
  given: 2340,
  meals: 47,
  saved: 1830,
  streak: 61,
  savedToday: false,
  tas: 0,
  pendingPayout: 2450,
  payoutPlan: "Per campaign",
  quiet: true,
  reminders: true,
  bio: true,
  tfa: true,
  watch: [],
  roundup: false,
  roundupAccum: 74,
  challenge: false,
  chalDay: 0,
  autoStrategy: null,
  riskTier: null,
  depositProvider: "bkash",
  nominee: null,
  autosaveOn: false,
  autosaveAmount: 250,
  purified: 0,
  lessons: { l1: false, l2: false, l3: false },
  goals: [
    { id: "hajj", t: "Hajj 2028", ic: "pin", saved: 180000, target: 650000 },
    { id: "emergency", t: "Emergency amanah", ic: "shield", saved: 95000, target: 150000 },
    { id: "qurbani", t: "Qurbani", ic: "gift", saved: 12000, target: 35000 },
  ],
  habits: [
    { id: "fajr", t: "Pray Fajr on time", s: "First light, first win", ic: "sunrise", done: true },
    { id: "azkar", t: "Morning adhkar", s: "Tap through in Barakah", ic: "moon", done: false },
    { id: "save", t: "Save today's ৳10", s: "Ribh Fund habit", ic: "wallet", done: false },
    { id: "sadaqah", t: "Give any sadaqah", s: "Even ৳10 counts", ic: "heart", done: false },
    { id: "quran", t: "Read one page of Quran", s: "Consistency over volume", ic: "book", done: true },
  ],
  ledger: [
    { sign: "+", t: "Profit · Printing Mach. Trading", s: "1 Jul · Murabaha matured", amt: "+৳3,937" },
    { sign: "+", t: "Refund (principal) · PM Trading", s: "1 Jul · capital returned", amt: "+৳1,00,000" },
    { sign: "-", t: "Investment · Printing Zone", s: "3 Jul · Wakalah deployment", amt: "−৳1,00,000" },
    { sign: "+", t: "Deposit · bKash verified", s: "28 Jun · name-matched source", amt: "+৳50,000" },
    { sign: "!", t: "Write-down provision · Cement Supply", s: "24 Jun · recovery in progress, not final", amt: "৳0 held" },
  ],
  notifRead: false,
};

type AppApi = {
  s: AppState;
  set: <K extends keyof AppState>(key: K, value: AppState[K]) => void;
  pushLedger: (entry: LedgerEntry) => void;
  toggleHabit: (id: string) => void;
  toggleWatch: (id: string) => boolean;
  give: (amount: number) => void;
  deposit: (amount: number, providerLabel: string) => void;
  withdraw: (amount: number) => boolean;
  invest: (campTitle: string, contract: string, amount: number) => boolean;
  addGoal: (name: string, target: number) => void;
  addToGoal: (id: string, amount: number) => boolean;
  removeGoal: (id: string) => void;
  markSavedToday: () => void;
  sweepRoundup: () => void;
  purify: (amount: number) => void;
};

const Ctx = createContext<AppApi | null>(null);

export function useApp(): AppApi {
  const v = useContext(Ctx);
  if (!v) throw new Error("useApp outside AppStateProvider");
  return v;
}

export function AppStateProvider({ children }: { children: React.ReactNode }) {
  const [s, setS] = useState<AppState>(INITIAL);

  const api = useMemo<AppApi>(() => {
    const set: AppApi["set"] = (key, value) => setS((p) => ({ ...p, [key]: value }));
    const pushLedger = (entry: LedgerEntry) => setS((p) => ({ ...p, ledger: [entry, ...p.ledger] }));

    return {
      s,
      set,
      pushLedger,
      toggleHabit: (id) =>
        setS((p) => ({ ...p, habits: p.habits.map((h) => (h.id === id ? { ...h, done: !h.done } : h)) })),
      toggleWatch: (id) => {
        let added = false;
        setS((p) => {
          added = !p.watch.includes(id);
          return { ...p, watch: added ? [...p.watch, id] : p.watch.filter((w) => w !== id) };
        });
        return !s.watch.includes(id);
      },
      give: (amount) =>
        setS((p) => ({
          ...p,
          given: p.given + amount,
          meals: p.meals + Math.floor(amount / 50),
          habits: p.habits.map((h) => (h.id === "sadaqah" ? { ...h, done: true } : h)),
          ledger: [
            { sign: "-" as const, t: "Sadaqah · vetted causes", s: "Today · 100% forwarded", amt: "−" + tk(amount) },
            ...p.ledger,
          ],
        })),
      deposit: (amount, providerLabel) =>
        setS((p) => ({
          ...p,
          avail: p.avail + amount,
          ledger: [
            { sign: "+" as const, t: "Deposit · " + providerLabel + " verified", s: "Today · name-matched source", amt: "+" + tk(amount) },
            ...p.ledger,
          ],
        })),
      withdraw: (amount) => {
        if (amount > s.avail) return false;
        setS((p) => ({
          ...p,
          avail: p.avail - amount,
          ledger: [
            { sign: "-" as const, t: "Withdrawal · bank ····4192", s: "Today · 1 business day", amt: "−" + tk(amount) },
            ...p.ledger,
          ],
        }));
        return true;
      },
      invest: (campTitle, contract, amount) => {
        if (amount > s.avail) return false;
        setS((p) => ({
          ...p,
          avail: p.avail - amount,
          deployed: p.deployed + amount,
          ledger: [
            { sign: "-" as const, t: "Investment · " + campTitle, s: "Today · " + contract + " deployment", amt: "−" + tk(amount) },
            ...p.ledger,
          ],
        }));
        return true;
      },
      addGoal: (name, target) =>
        setS((p) => ({
          ...p,
          goals: [...p.goals, { id: "g" + p.goals.length + "_" + name.length, t: name, ic: "target", saved: 0, target }],
        })),
      addToGoal: (id, amount) => {
        if (amount > s.avail) return false;
        setS((p) => {
          const g = p.goals.find((x) => x.id === id);
          if (!g) return p;
          return {
            ...p,
            avail: p.avail - amount,
            goals: p.goals.map((x) => (x.id === id ? { ...x, saved: x.saved + amount } : x)),
            ledger: [
              { sign: "-" as const, t: "To goal · " + g.t, s: "Today · earmarked savings", amt: "−" + tk(amount) },
              ...p.ledger,
            ],
          };
        });
        return true;
      },
      removeGoal: (id) =>
        setS((p) => {
          const g = p.goals.find((x) => x.id === id);
          if (!g) return p;
          return {
            ...p,
            avail: p.avail + g.saved,
            goals: p.goals.filter((x) => x.id !== id),
            ledger:
              g.saved > 0
                ? [
                    { sign: "+" as const, t: "Goal closed · " + g.t, s: "Today · savings returned to wallet", amt: "+" + tk(g.saved) },
                    ...p.ledger,
                  ]
                : p.ledger,
          };
        }),
      markSavedToday: () =>
        setS((p) =>
          p.savedToday
            ? p
            : {
                ...p,
                savedToday: true,
                saved: p.saved + 10,
                streak: p.streak + 1,
                habits: p.habits.map((h) => (h.id === "save" ? { ...h, done: true } : h)),
                ledger: [
                  { sign: "-" as const, t: "Ribh Fund · daily ৳10", s: "Today · micro-save", amt: "−৳10" },
                  ...p.ledger,
                ],
              }
        ),
      sweepRoundup: () =>
        setS((p) => {
          if (!p.roundup || p.roundupAccum < 1) return p;
          return {
            ...p,
            saved: p.saved + p.roundupAccum,
            roundupAccum: 0,
            ledger: [
              { sign: "-" as const, t: "Round-up sweep · Ribh Fund", s: "Today · your own verified funds", amt: "−" + tk(p.roundupAccum) },
              ...p.ledger,
            ],
          };
        }),
      purify: (amount) =>
        setS((p) => ({
          ...p,
          purified: p.purified + amount,
          ledger: [
            { sign: "-" as const, t: "Interest purification · charity", s: "Today · cleansed, not counted as sadaqah", amt: "−" + tk(amount) },
            ...p.ledger,
          ],
        })),
    };
  }, [s]);

  return <Ctx.Provider value={api}>{children}</Ctx.Provider>;
}
