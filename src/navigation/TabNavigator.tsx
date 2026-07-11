import React from "react";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { createNativeStackNavigator } from "@react-navigation/native-stack";

import { useTheme } from "@/theme";
import { Icon } from "@/components/Icon";
import { HomeScreen } from "@/screens/home/HomeScreen";
import { WalletScreen } from "@/screens/home/WalletScreen";
import { InvestScreen } from "@/screens/invest/InvestScreen";
import { CampaignDetailScreen } from "@/screens/invest/CampaignDetailScreen";
import { GrowScreen } from "@/screens/grow/GrowScreen";
import { BarakahScreen } from "@/screens/barakah/BarakahScreen";
import { MeScreen } from "@/screens/me/MeScreen";
import { BusinessScreen } from "@/screens/me/BusinessScreen";
import type {
  TabParamList,
  HomeStackParamList,
  InvestStackParamList,
  GrowStackParamList,
  BarakahStackParamList,
  MeStackParamList,
} from "./types";

const Tab = createBottomTabNavigator<TabParamList>();

const HomeStack = createNativeStackNavigator<HomeStackParamList>();
function HomeStackNavigator() {
  return (
    <HomeStack.Navigator screenOptions={{ headerShown: false }}>
      <HomeStack.Screen name="Home" component={HomeScreen} />
      <HomeStack.Screen name="Wallet" component={WalletScreen} />
    </HomeStack.Navigator>
  );
}

const InvestStack = createNativeStackNavigator<InvestStackParamList>();
function InvestStackNavigator() {
  return (
    <InvestStack.Navigator screenOptions={{ headerShown: false }}>
      <InvestStack.Screen name="Invest" component={InvestScreen} />
      <InvestStack.Screen name="CampaignDetail" component={CampaignDetailScreen} />
    </InvestStack.Navigator>
  );
}

const GrowStack = createNativeStackNavigator<GrowStackParamList>();
function GrowStackNavigator() {
  return (
    <GrowStack.Navigator screenOptions={{ headerShown: false }}>
      <GrowStack.Screen name="Grow" component={GrowScreen} />
    </GrowStack.Navigator>
  );
}

const BarakahStack = createNativeStackNavigator<BarakahStackParamList>();
function BarakahStackNavigator() {
  return (
    <BarakahStack.Navigator screenOptions={{ headerShown: false }}>
      <BarakahStack.Screen name="Barakah" component={BarakahScreen} />
    </BarakahStack.Navigator>
  );
}

const MeStack = createNativeStackNavigator<MeStackParamList>();
function MeStackNavigator() {
  return (
    <MeStack.Navigator screenOptions={{ headerShown: false }}>
      <MeStack.Screen name="Me" component={MeScreen} />
      <MeStack.Screen name="Business" component={BusinessScreen} />
    </MeStack.Navigator>
  );
}

const TABS: Array<{ name: keyof TabParamList; title: string; icon: string; component: React.ComponentType }> = [
  { name: "HomeTab", title: "Home", icon: "home", component: HomeStackNavigator },
  { name: "InvestTab", title: "Invest", icon: "trend", component: InvestStackNavigator },
  { name: "GrowTab", title: "Grow", icon: "sprout", component: GrowStackNavigator },
  { name: "BarakahTab", title: "Barakah", icon: "heart", component: BarakahStackNavigator },
  { name: "MeTab", title: "Me", icon: "user", component: MeStackNavigator },
];

export function TabNavigator() {
  const t = useTheme();

  return (
    <Tab.Navigator
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: t.colors.teal,
        tabBarInactiveTintColor: "#8AA79B",
        tabBarStyle: {
          backgroundColor: t.colors.card,
          borderTopColor: t.colors.line,
          height: 78,
          paddingBottom: 12,
          paddingTop: 8,
        },
        tabBarLabelStyle: { fontFamily: t.fonts.bodySemi, fontSize: 10 },
      }}
    >
      {TABS.map((tab) => (
        <Tab.Screen
          key={tab.name}
          name={tab.name}
          component={tab.component}
          options={{
            title: tab.title,
            tabBarIcon: ({ color }) => <Icon name={tab.icon} size={22} color={color} />,
          }}
        />
      ))}
    </Tab.Navigator>
  );
}
