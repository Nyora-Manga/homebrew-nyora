#!/usr/bin/env bash
# Point Casks/nyora.rb at the newest nyora-mac release. Checksums come from
# GitHub's own sha256 digests of the uploaded DMGs, so nothing is downloaded and
# a release missing either architecture is left alone until it is complete.
set -euo pipefail
cask=Casks/nyora.rb
release=$(gh api repos/Nyora-Manga/nyora-mac/releases/latest)
tag=$(jq -r .tag_name <<<"$release")
version=${tag#v}
[[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "Unexpected tag $tag"; exit 1; }
current=$(sed -nE 's/^  version "([^"]+)"/\1/p' "$cask")
if [[ $version == "$current" ]]; then echo "Cask already at $version"; exit 0; fi
# Never move backwards (e.g. a mirror re-publishing an older tag as latest).
if [[ $(printf '%s\n%s\n' "$current" "$version" | sort -V | tail -1) != "$version" ]]; then echo "Latest $version is older than cask $current"; exit 0; fi
digest() {
  jq -r --arg n "Nyora-$version-mac-$1.dmg" '.assets[] | select(.name == $n) | .digest // empty' <<<"$release" | sed 's/^sha256://'
}
arm=$(digest arm64); intel=$(digest x64)
[[ $arm =~ ^[0-9a-f]{64}$ && $intel =~ ^[0-9a-f]{64}$ ]] || { echo "Release $tag lacks both DMG digests yet"; exit 0; }
sed -i.bak -E "s/^  version \"[^\"]+\"/  version \"$version\"/" "$cask"
sed -i.bak -E "s/^(  sha256 arm: +)\"[0-9a-f]{64}\"/\1\"$arm\"/" "$cask"
sed -i.bak -E "s/^(         intel: )\"[0-9a-f]{64}\"/\1\"$intel\"/" "$cask"
rm -f "$cask.bak"
grep -q "version \"$version\"" "$cask" && grep -q "$arm" "$cask" && grep -q "$intel" "$cask" || { echo "Cask edit did not apply"; exit 1; }
ruby -c "$cask" >/dev/null
for a in arm64 x64; do
  code=$(curl -sIL -o /dev/null -w '%{http_code}' "https://github.com/Nyora-Manga/nyora-mac/releases/download/$tag/Nyora-$version-mac-$a.dmg")
  [[ $code == 200 ]] || { echo "Download for $a returned $code"; exit 1; }
done
echo "version=$version" >> "${GITHUB_OUTPUT:-/dev/null}"
echo "Bumped cask $current -> $version"
