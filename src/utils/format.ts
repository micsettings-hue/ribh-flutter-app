export const TK = "৳";

// Lakh-style grouping (1,00,000) to match the prototype; manual because
// Hermes Intl support for en-IN is inconsistent across platforms.
export function groupIndian(n: number): string {
  const rounded = Math.round(Math.abs(n));
  let s = String(rounded);
  if (s.length > 3) {
    const last3 = s.slice(-3);
    let rest = s.slice(0, -3);
    const parts: string[] = [];
    while (rest.length > 2) {
      parts.unshift(rest.slice(-2));
      rest = rest.slice(0, -2);
    }
    if (rest) parts.unshift(rest);
    s = parts.join(",") + "," + last3;
  }
  return n < 0 ? "-" + s : s;
}

export function tk(n: number): string {
  return TK + groupIndian(n);
}

export function parseNum(v: string): number {
  return parseInt(String(v).replace(/[^0-9]/g, "") || "0", 10);
}
