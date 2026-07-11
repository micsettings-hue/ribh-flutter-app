import type { NavigatorScreenParams } from "@react-navigation/native";

export type HomeStackParamList = {
  Home: undefined;
  Wallet: undefined;
};
export type InvestStackParamList = {
  Invest: undefined;
  CampaignDetail: { campId: string };
};
export type GrowStackParamList = { Grow: undefined };
export type BarakahStackParamList = { Barakah: undefined };
export type MeStackParamList = {
  Me: undefined;
  Business: undefined;
};

export type TabParamList = {
  HomeTab: NavigatorScreenParams<HomeStackParamList>;
  InvestTab: NavigatorScreenParams<InvestStackParamList>;
  GrowTab: NavigatorScreenParams<GrowStackParamList>;
  BarakahTab: NavigatorScreenParams<BarakahStackParamList>;
  MeTab: NavigatorScreenParams<MeStackParamList>;
};
