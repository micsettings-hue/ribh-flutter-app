// Static reference data lifted from the v8.0 prototype.

export type CampaignStatus = "open" | "matured" | "recovery";

export type Campaign = {
  id: string;
  title: string;
  sector: string;
  contract: "Wakalah" | "Murabaha";
  pool: number;
  raised: number;
  ppl: number; // profit per lac
  share: number; // investor share %
  tenure: number; // days
  status: CampaignStatus;
  investors: number;
  daysLeft: number;
  risk: "Lower" | "Higher";
  note: string;
};

export const CAMPS: Campaign[] = [
  {
    id: "zone",
    title: "Printing Zone · Industrial Binding Glue",
    sector: "Printing and Packaging",
    contract: "Wakalah",
    pool: 1000000,
    raised: 946950,
    ppl: 3500,
    share: 70,
    tenure: 15,
    status: "open",
    investors: 38,
    daysLeft: 2,
    risk: "Lower",
    note: "Agency-based procurement. Return is projected and indicative under Wakalah, never fixed.",
  },
  {
    id: "purchase",
    title: "Printing Machinery Purchase",
    sector: "Printing Equipment",
    contract: "Murabaha",
    pool: 500000,
    raised: 337000,
    ppl: 3500,
    share: 70,
    tenure: 30,
    status: "open",
    investors: 21,
    daysLeft: 11,
    risk: "Lower",
    note: "Ribh, as your Wakil, buys the machinery, takes ownership, then sells to the merchant at a fixed disclosed markup.",
  },
  {
    id: "trading",
    title: "Printing Machinery Trading",
    sector: "Printing Equipment",
    contract: "Murabaha",
    pool: 500000,
    raised: 500000,
    ppl: 5250,
    share: 75,
    tenure: 61,
    status: "matured",
    investors: 44,
    daysLeft: 0,
    risk: "Lower",
    note: "Matured 1 Jul, fully disbursed. Actual profit matched projection.",
  },
  {
    id: "musannif",
    title: "Musannif Corp. · Cement Supply",
    sector: "Building Materials",
    contract: "Murabaha",
    pool: 2500000,
    raised: 1840000,
    ppl: 9275,
    share: 70,
    tenure: 91,
    status: "recovery",
    investors: 73,
    daysLeft: 0,
    risk: "Higher",
    note: "Merchant repayment delayed at maturity. Recovery process active, see the live tracker below.",
  },
];

export type Strategy = {
  id: string;
  name: string;
  desc: string;
  mix: Array<[string, number, string]>;
  band: string;
};

export const STRATEGIES: Strategy[] = [
  {
    id: "short",
    name: "Short-tenure Murabaha",
    desc: "Asset-backed trade only, tenures under 30 days. Steadier, lower indicative return.",
    mix: [
      ["Murabaha", 85, "#0FA67A"],
      ["Liquidity", 15, "#C8F5E2"],
    ],
    band: "Lower risk",
  },
  {
    id: "balanced",
    name: "Balanced trade",
    desc: "A blend of Murabaha and Wakalah across sectors. Middle ground.",
    mix: [
      ["Murabaha", 55, "#0FA67A"],
      ["Wakalah", 35, "#C99A2E"],
      ["Liquidity", 10, "#C8F5E2"],
    ],
    band: "Moderate risk",
  },
  {
    id: "diversified",
    name: "Ribh Fund diversified",
    desc: "The broad diversified pool across all live contracts. Widest spread.",
    mix: [
      ["Murabaha", 50, "#0FA67A"],
      ["Wakalah", 30, "#C99A2E"],
      ["Musharakah", 12, "#14C48A"],
      ["Liquidity", 8, "#C8F5E2"],
    ],
    band: "Moderate risk",
  },
];

export const PRAYERS = [
  { n: "Fajr", t: "4:50", m: 290, ic: "sunrise" },
  { n: "Dhuhr", t: "1:05", m: 785, ic: "sun" },
  { n: "Asr", t: "4:45", m: 1005, ic: "sunlow" },
  { n: "Maghrib", t: "6:52", m: 1132, ic: "sunset" },
  { n: "Isha", t: "8:15", m: 1215, ic: "moon" },
] as const;

export const SPARK_DATA = [1650, 2100, 1980, 2450, 3937, 3200];

export const CONTRACT_COLORS: Record<string, string> = {
  Murabaha: "#0FA67A",
  Wakalah: "#C99A2E",
  Musharakah: "#14C48A",
  Mudarabah: "#7BD6B4",
};
