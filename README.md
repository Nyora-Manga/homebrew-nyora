<div align="center">

<img src="https://nyora.xyz/icon.png" width="120" alt="Nyora icon" />

# Nyora — Homebrew Tap (macOS)

### Read like the world can wait.

A free, open-source, ad-free manga reader for your Mac — with on-device AI page translation, offline downloads and free cloud sync. This is the official Homebrew tap: **one `brew` command to install, one to update.**

<p>
  <img alt="Homebrew" src="https://img.shields.io/badge/Homebrew-FBB040?style=for-the-badge&logo=homebrew&logoColor=black" />
  <img alt="Apple" src="https://img.shields.io/badge/Apple-000000?style=for-the-badge&logo=apple&logoColor=white" />
</p>

<p>
  <a href="https://github.com/Nyora-Manga/homebrew-nyora"><img alt="Homebrew Cask" src="https://img.shields.io/badge/Homebrew-cask-%23F7B731?logo=homebrew&logoColor=white" /></a>
  <a href="https://github.com/Nyora-Manga/nyora-mac"><img alt="App repo" src="https://img.shields.io/badge/app-nyora--mac-blue?logo=apple&logoColor=white" /></a>
  <a href="https://github.com/Nyora-Manga/nyora-mac"><img alt="License Apache-2.0" src="https://img.shields.io/badge/license-Apache--2.0-green.svg" /></a>
  <a href="https://github.com/Nyora-Manga/homebrew-nyora/pulls"><img alt="PRs welcome" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" /></a>
</p>

<p>
  <a href="https://github.com/Nyora-Manga/nyora-mac/releases/latest"><img alt="Download DMG" src="https://img.shields.io/badge/Download-.dmg-000000?style=for-the-badge&logo=apple&logoColor=white" /></a>
  <a href="https://nyora.xyz"><img alt="Website" src="https://img.shields.io/badge/Website-nyora.xyz-FF4655?style=for-the-badge&logo=githubpages&logoColor=white" /></a>
</p>

</div>

---

## What is this?

**Nyora** is a native manga reader for macOS — read manga, manhwa and manhua from hundreds of sources, translate whole pages on-device with AI, download chapters for offline reading, and sync your library across devices for free. **This repository is the Homebrew tap** that distributes it: a thin, scriptable channel so you can install and keep Nyora current with plain `brew` commands instead of re-downloading from GitHub each time.

**Why you'll love it**

- **It just reads — no friction.** No account to start, no ads, no paywall. Open it and read.
- **Translation that stays on your Mac.** Whole-page AI translation runs on-device with Apple Vision and a bundled MangaOCR model — your reading never leaves the machine, and it works offline once a page is loaded.
- **Yours to keep.** Download chapters as portable CBZ archives you actually own, ready for planes, trains and dead zones.
- **One library, every device.** Optional free Nyora Cloud sync — an email + password account syncs your library, history and progress across every Nyora platform — resume on your Mac exactly where your phone left off.
- **Open and auditable.** Apache-2.0, no analytics SDKs, no behavioural tracking. The code is there for anyone to read.

**Install in one line:**

```bash
brew install --cask Hasan72341/nyora/nyora
```

> First launch shows a Gatekeeper warning because the build is independent and not notarised by Apple. That is **expected and safe** — see [First Launch on macOS](#first-launch-on-macos) for the one-time fix.

## Table of Contents

- [Overview](#overview)
- [Install](#install)
- [First Launch on macOS](#first-launch-on-macos)
- [Updating](#updating)
- [Uninstalling](#uninstalling)
- [What You Get](#what-you-get)
- [How the Tap Works](#how-the-tap-works)
- [Requirements](#requirements)
- [Troubleshooting](#troubleshooting)
- [FAQ](#faq)
- [Nyora on Every Platform](#nyora-on-every-platform)
- [Contributing](#contributing)
- [License](#license)
- [Credits](#credits)

## Overview

A Homebrew **tap** is a third-party repository of formulae and casks that extends Homebrew beyond its core catalogue. A **cask** installs a pre-built macOS application bundle (a `.app`) rather than compiling from source. The cask here, named `nyora`, declares where to download the latest Nyora build, the checksum to verify it against, and where to place `Nyora.app` (in `/Applications`). Because it tracks releases of [`Hasan72341/nyora-mac`](https://github.com/Nyora-Manga/nyora-mac), `brew upgrade` pulls new versions as they ship — no manual re-downloading from GitHub Releases.

This repo holds **no app code**; it is purely a distribution channel — a single cask that points at the release artefacts published by [`nyora-mac`](https://github.com/Nyora-Manga/nyora-mac). The payoff is a clean, scriptable install and one-command updates. More at [nyora.xyz](https://nyora.xyz).

## Install

One line — tap and install in a single command:

```bash
brew install --cask Hasan72341/nyora/nyora
```

…or tap first, then install:

```bash
brew tap Hasan72341/nyora
brew install --cask nyora
```

Both routes do the same thing. The single-line form uses Homebrew's fully-qualified `<user>/<tap>/<cask>` syntax to add the tap and install the cask in one step. The two-step form registers the tap explicitly first — handy if you want to inspect it before installing, or install more casks from it later.

**Is this safe to run?** Yes. Homebrew downloads the build straight from a [`nyora-mac`](https://github.com/Nyora-Manga/nyora-mac) GitHub Release and verifies it against the checksum pinned in the cask before installing — if the file were tampered with, the install would abort. The cask itself is a short, readable Ruby file you can [inspect in this repo](https://github.com/Nyora-Manga/homebrew-nyora/blob/main/Casks/nyora.rb) before running anything. No account, no ads, no telemetry.

## First Launch on macOS

Nyora is **ad-hoc signed** (not notarised by Apple), so Gatekeeper blocks it on first launch. **This is expected for an independent, open-source build and does not mean the app is unsafe** — Apple notarisation is a paid developer-account process, and skipping it is common for community projects. Pick whichever fix you prefer:

**A. Allow it once** via **System Settings → Privacy & Security → "Open Anyway"**. After you attempt to open Nyora and macOS refuses, an "Open Anyway" button appears in this pane for a short window. Click it, then confirm. Simplest, no terminal.

**B. Clear the quarantine flag** after install. macOS attaches a `com.apple.quarantine` extended attribute to downloaded apps; removing it tells Gatekeeper to stop blocking. Most reliable, and survives the occasional "damaged" error:

```bash
xattr -dr com.apple.quarantine "/Applications/Nyora.app"
```

**C. Skip the prompt entirely** at install time by asking Homebrew not to quarantine the download — no post-install step required:

```bash
brew install --cask --no-quarantine nyora
```

> Apple Silicon and Intel Macs are both supported; Homebrew installs the matching build automatically. Requires macOS 14 (Sonoma) or later.

The cask tracks releases of [`Hasan72341/nyora-mac`](https://github.com/Nyora-Manga/nyora-mac).

## Updating

Because the cask is pinned to the `nyora-mac` release stream, keeping Nyora current is the standard Homebrew flow:

```bash
brew update
brew upgrade --cask nyora
```

`brew update` refreshes Homebrew and all tap definitions (including this one); `brew upgrade --cask nyora` installs the newest published build if one is available. To upgrade everything you have at once, run `brew upgrade` with no arguments.

## Uninstalling

To remove the app:

```bash
brew uninstall --cask nyora
```

To also remove the tap afterwards:

```bash
brew untap Hasan72341/nyora
```

To clear the app's local data (library cache, preferences) as well, add `--zap`:

```bash
brew uninstall --zap --cask nyora
```

## What You Get

These are the core pillars of the Nyora reader you install through this tap. They are properties of the macOS app itself — see [`nyora-mac`](https://github.com/Nyora-Manga/nyora-mac) for full detail and screenshots.

### Translate

Whole-page AI translation that runs entirely on your Mac. Apple Vision performs OCR — with a rotated-ensemble pass for vertical Japanese / tategaki — and a bundled MangaOCR Core ML model assists recognition on stylised manga text. The result is typeset back over the original art so you read whole pages, not isolated speech bubbles. Press `⌘T` while reading to open a side-by-side sheet with the original and translated pages together. Because the pipeline is on-device, text recognition never leaves your Mac and works without a connection once the page is loaded.

### Download & Offline

Save chapters for offline reading and keep them with you on planes, trains, and anywhere without signal. CBZ archive support is available where applicable, so your downloads stay portable, standard archive files you actually own.

### Sources & Discovery

Hundreds of built-in sources covering manga, manhwa and manhua, source-compatible with the Tachiyomi/Kotatsu-style ecosystem. Browse, search, and filter across the catalogue from one consistent UI to find new series and follow ongoing ones. (The Android edition reaches 1100+ sources; desktop and other platforms ship a large curated set.)

### Cloud Sync

Free cloud sync. Create a free Nyora Cloud account (email + password) and your library, categories, history, bookmarks and reading progress follow you across every Nyora platform — pick up on your Mac exactly where your phone left off. No paid tier, no separate account to create.

### Privacy & Open Source

100% free, ad-free, no tracking, and no account needed to read. Nyora is open source under Apache-2.0; there are no analytics SDKs harvesting your behaviour and no ads injected into your reading. Your library is yours — it lives on your machine, and cloud sync is opt-in.

### macOS capability matrix

| Capability | Status |
|---|---|
| Whole-page AI translation (on-device, Apple Vision + MangaOCR) | Yes |
| Offline translation once a page is loaded | Yes |
| Offline downloads · CBZ where applicable | Yes |
| Free cloud sync (Nyora Cloud account) | Yes |
| Built-in sources | Large curated set |
| Ads / tracking / analytics SDKs | None |
| Account required to read | No |
| Install & update via Homebrew | Yes |
| Apple notarisation | No (ad-hoc signed) |
| Intel (x86_64) build | — |

## How the Tap Works

When you run `brew install --cask Hasan72341/nyora/nyora`, Homebrew:

1. Clones (or updates) this tap repository so it has the local `nyora` cask definition.
2. Reads the cask to learn the current version, the download URL of the macOS build, and the checksum to verify against.
3. Downloads the artefact published on a [`nyora-mac`](https://github.com/Nyora-Manga/nyora-mac) GitHub Release and verifies its integrity.
4. Installs `Nyora.app` into `/Applications`.

Subsequent `brew upgrade` runs repeat steps 2–4 whenever a newer `nyora-mac` release exists. Because everything is declarative and version-pinned, installs are reproducible and scriptable — ideal for dotfiles, provisioning scripts, and `Brewfile`-based setups.

## Requirements

- **macOS 14 (Sonoma) or later**, on Apple Silicon (arm64) or Intel (x64).
- **[Homebrew](https://brew.sh) installed.** If you do not yet have it, follow the installer at [brew.sh](https://brew.sh).
- A network connection for the initial download (the app itself works offline once chapters are downloaded).

## Troubleshooting

**"Nyora is damaged and can't be opened" / "cannot be opened because the developer cannot be verified."**
This is Gatekeeper reacting to the ad-hoc signature. Use option A, B, or C from [First Launch on macOS](#first-launch-on-macos). The most reliable fix is clearing the quarantine attribute:

```bash
xattr -dr com.apple.quarantine "/Applications/Nyora.app"
```

**`brew` cannot find the cask.**
Make sure the tap is registered, then refresh:

```bash
brew tap Hasan72341/nyora
brew update
```

**An upgrade is not appearing.**
Run `brew update` first so the tap definition is refreshed, then `brew upgrade --cask nyora`.

**Installing on an Intel Mac fails.**
This build targets Apple Silicon only; an Intel build is not currently available.

## FAQ

**Is it really free?**
Yes — 100% free and ad-free, with no paid tier and no account required to read. Optional cloud sync uses a free Nyora Cloud account (email + password). There is nothing to buy and nothing to unlock.

**Do I need an account?**
No. You can install and read without signing in to anything. An account (free Nyora Cloud email + password) is only needed if you *want* cloud sync across devices — it is entirely optional.

**Will my data be private?**
Yes. There are no ads, no analytics SDKs and no behavioural tracking. Your library and reading progress live on your Mac; cloud sync is opt-in. Translation runs on-device, so the pages you read are never sent anywhere or used to train any model. Being open source under Apache-2.0, all of this is auditable.

**Is it safe? Why is the app unsigned / flagged by macOS?**
The build is ad-hoc signed rather than notarised by Apple, so Gatekeeper blocks it on first launch. It is **not** damaged or malicious — notarisation is a paid Apple developer process that this independent project does not go through. Homebrew verifies the download against a pinned checksum before installing, and the cask is a short, readable file you can inspect. See [First Launch on macOS](#first-launch-on-macos) for the three one-time fixes.

**How do I update?**
Run `brew update` then `brew upgrade --cask nyora`. The cask tracks `nyora-mac` releases, so new versions arrive through the normal Homebrew flow.

**Where does the manga come from? Is this legal?**
Nyora is just a reader. It hosts no content of its own and is not affiliated with any of the sources it can access — it connects to third-party sources you choose. You are responsible for how you use it.

**Does it work offline?**
Yes. Downloaded chapters read fully offline, and because the translation pipeline runs on-device, translation also works once a page is loaded. Only the initial install, source browsing and cloud sync need a connection.

**How does translation work, and is my reading sent anywhere?**
It runs entirely on your Mac — Apple Vision OCR plus a bundled MangaOCR Core ML model — so text recognition never leaves the device and is never used to train any model. Press `⌘T` while reading for a side-by-side original/translated sheet.

**Does cloud sync share my library with my other devices?**
Yes — signing in to your Nyora Cloud account (email and password) syncs your library, categories, history, bookmarks and reading progress across every Nyora platform, so you resume on your Mac where your phone left off.

**Does it run on Intel Macs?**
Yes. Since 3.1.12 the cask ships both Apple Silicon (arm64) and Intel (x64) builds and Homebrew picks the right one for your Mac.

## Nyora on Every Platform

| Platform | Repo | Get it |
|---|---|---|
| Android | [nyora-android](https://github.com/Nyora-Manga/nyora-android) | [APK](https://github.com/Nyora-Manga/nyora-android/releases/latest) |
| macOS **(you are here)** | [nyora-mac](https://github.com/Nyora-Manga/nyora-mac) | [.dmg / brew](https://github.com/Nyora-Manga/nyora-mac/releases/latest) |
| Windows | [nyora-windows](https://github.com/Nyora-Manga/nyora-windows) | [.exe (x64/ARM64)](https://github.com/Nyora-Manga/nyora-windows/releases/latest) |
| Linux | [nyora-linux](https://github.com/Nyora-Manga/nyora-linux) | [deb · rpm · curl](https://github.com/Nyora-Manga/nyora-linux/releases/latest) |
| iOS / iPadOS | [nyora-ios](https://github.com/Nyora-Manga/nyora-ios) | [sideload IPA](https://github.com/Nyora-Manga/nyora-ios/releases/latest) |
| Web | [nyora-web](https://github.com/Nyora-Manga/nyora-web) | [nyora.xyz](https://nyora.xyz) |

## Contributing

This tap is small and friendly to work on — and you don't need to be a packaging expert to help. Newcomers are genuinely welcome.

### Ways to contribute (all skill levels)

- **Report an install or update problem.** A broken download URL, a checksum mismatch, a stale version, or a Gatekeeper quirk specific to packaging — [open an issue here](https://github.com/Nyora-Manga/homebrew-nyora/issues). Clear bug reports are one of the most valuable contributions.
- **Improve these docs.** Spotted a confusing step, a typo, or a fix that worked for you that isn't written down? Doc PRs are small, high-value, and a great first contribution.
- **Test a release.** Install the latest build on your Mac and confirm `brew install`, `brew upgrade` and the first-launch flow behave as documented. Reporting back either way helps.
- **Star and share.** If Nyora made your reading better, starring [this tap](https://github.com/Nyora-Manga/homebrew-nyora) and the [app repo](https://github.com/Nyora-Manga/nyora-mac) genuinely helps other readers find the project — no code required.

> **Working on the reader itself?** Bugs and feature requests about the app — translation, sources, sync, UI — belong on [`nyora-mac`](https://github.com/Nyora-Manga/nyora-mac), which is where the app is being built. This repo is only the macOS distribution channel.

### Where things live

This is a single-cask tap, so there isn't much to map:

- `Casks/nyora.rb` — the cask definition: the version, download URL, checksum, install path, first-launch caveats, and `zap` cleanup paths. This is the file that changes on almost every contribution here.
- `README.md` — this document.
- `LICENSE` — Apache-2.0.

### Good first contributions

- **Fix or clarify a Troubleshooting / FAQ entry** after you hit (and solved) an install snag.
- **Tidy the cask caveats or `zap` paths** if something in the app's local-data layout changes.
- **Catch a stale or broken link** in this README.

### How the cask updates

The cask in `Casks/nyora.rb` simply tracks releases of [`nyora-mac`](https://github.com/Nyora-Manga/nyora-mac). When a new app version ships, the bump is small and mechanical: update the `version`, refresh the `sha256` to match the new release artefact, and confirm the `url` resolves. A typical PR touches only those lines. If you'd like to take an update PR, point it at the relevant `nyora-mac` release tag in your description so it's easy to verify against the published checksum.

### PR & issue etiquette

- **Keep PRs focused.** One change per PR — a cask bump, a doc fix, a single clarification — is far easier to review than a mixed bag.
- **Describe the change.** What you changed and why, plus a link to the related `nyora-mac` release if it's a version bump.
- **Be kind.** This is a small community project maintained in spare time; assume good faith and we'll do the same.

There's no separate `CONTRIBUTING.md` to read — the guidance above is the whole contract. If anything here is unclear, open an issue and ask; questions are welcome too.

Thank you for being here. Whether you file a bug, fix a typo, or just star the repo and tell a friend, you're helping more people read like the world can wait.

## License

The Nyora macOS app is licensed under **Apache-2.0**. See [`Hasan72341/nyora-mac`](https://github.com/Nyora-Manga/nyora-mac) for full details.

## Credits

Built and maintained by **Md Hasan Raza** — [GitHub](https://github.com/Hasan72341) · [Instagram](https://instagram.com/md_hasan_raza____) · [LinkedIn](https://www.linkedin.com/in/md-hasan-raza) · hasanraza96@outlook.com

> Nyora is not affiliated with any of the manga sources it can access.