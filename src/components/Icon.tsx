import React from "react";
import { Feather, MaterialCommunityIcons } from "@expo/vector-icons";

// Maps the prototype's icon vocabulary onto stroke icon sets.
const FEATHER: Record<string, React.ComponentProps<typeof Feather>["name"]> = {
  home: "home",
  trend: "trending-up",
  heart: "heart",
  user: "user",
  users: "users",
  bell: "bell",
  shield: "shield",
  calendar: "calendar",
  lock: "lock",
  file: "file-text",
  gift: "gift",
  chat: "message-circle",
  chev: "chevron-right",
  chevl: "chevron-left",
  plus: "plus",
  minus: "minus",
  check: "check",
  alert: "alert-triangle",
  sun: "sun",
  sunrise: "sunrise",
  sunset: "sunset",
  moon: "moon",
  briefcase: "briefcase",
  box: "package",
  refresh: "refresh-cw",
  arrdown: "arrow-down",
  arrup: "arrow-up",
  book: "book-open",
  compass: "compass",
  camera: "camera",
  pin: "map-pin",
  search: "search",
  filter: "filter",
  columns: "columns",
  target: "target",
  star: "star",
  bookmark: "bookmark",
  info: "info",
  db: "database",
  trash: "trash-2",
  clock: "clock",
  phone: "smartphone",
  repeat: "repeat",
  chartbar: "bar-chart-2",
  scholar2: "user",
  route: "map",
  copy: "copy",
  sparkles: "star",
};

const MCI: Record<string, React.ComponentProps<typeof MaterialCommunityIcons>["name"]> = {
  sprout: "sprout-outline",
  wallet: "wallet-outline",
  id: "card-account-details-outline",
  building: "office-building-outline",
  scale: "scale-balance",
  graduation: "school-outline",
  sunlow: "weather-sunset",
};

export type IconName = keyof typeof FEATHER | keyof typeof MCI;

export function Icon({ name, size = 16, color }: { name: string; size?: number; color: string }) {
  if (name in MCI) {
    return <MaterialCommunityIcons name={MCI[name]} size={size} color={color} />;
  }
  return <Feather name={FEATHER[name] ?? "check"} size={size} color={color} />;
}
