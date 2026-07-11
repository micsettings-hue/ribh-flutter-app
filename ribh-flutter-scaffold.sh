#!/usr/bin/env bash
# RIBH Flutter scaffold. Run from the parent folder where you want ~/ribh-flutter to live.
# Prerequisites: Flutter stable, Dart, Git, and Claude Code installed.
set -euo pipefail

APP_DIR="ribh-flutter"
ORG="com.ribhinvestments"

echo "==> 1. Verify toolchain"
flutter --version
flutter doctor

echo "==> 2. Create the Flutter project"
flutter create --org "$ORG" --platforms=android,ios --description "RIBH Investments, AAOIFI-aligned halal trade financing" "$APP_DIR"
cd "$APP_DIR"

echo "==> 3. Folder structure"
mkdir -p lib/{app,core,data,features,shared}
mkdir -p lib/app/{theme,router,l10n}
mkdir -p lib/core/{formatters,failures,constants}
mkdir -p lib/data/{models,repositories,supabase}
mkdir -p lib/features/{home,invest,grow,barakah,me,services,campaign,sheets}
mkdir -p lib/shared
mkdir -p docs supabase .claude/rules

echo "==> 4. Place the brief (copy the files you downloaded into these paths)"
# CLAUDE.md            -> ./CLAUDE.md
# flutterv9.2.md       -> ./flutterv9.2.md
# .claude/rules/*.md   -> ./.claude/rules/
# prototype + dossier  -> ./docs/
echo "    Copy CLAUDE.md, flutterv9.2.md, the five .claude/rules files,"
echo "    and the two HTML docs into docs/ before the first Claude Code session."

echo "==> 5. Core dependencies"
flutter pub add flutter_riverpod riverpod_annotation go_router supabase_flutter freezed_annotation json_annotation intl google_fonts fl_chart flutter_local_notifications geolocator webview_flutter
flutter pub add flutter_localizations --sdk=flutter
flutter pub add --dev build_runner riverpod_generator freezed json_serializable mocktail

echo "==> 6. Enable localization (ARB) and create the progress log"
cat > l10n.yaml <<'YAML'
arb-dir: lib/app/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
YAML
printf '# RIBH Flutter progress\n\n## Done\n- (nothing yet)\n\n## Next\n- M0 Foundation: theme, router shell, Supabase client, CI\n' > docs/PROGRESS.md

echo "==> 7. First analyze and format"
dart format .
flutter analyze || true

echo "==> 8. Git"
git init
git add -A
git commit -m "Scaffold: RIBH Flutter project, brief, and structure"

echo "==> Done. Next: add your remote and push, then open Claude Code."
echo "    git remote add origin <your-repo-url>"
echo "    git branch -M main && git push -u origin main"
