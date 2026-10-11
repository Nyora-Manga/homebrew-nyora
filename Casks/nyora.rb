cask "nyora" do
  arch arm: "arm64", intel: "x64"

  version "3.1.12"
  sha256 arm:   "227d51df04d855dba4039bc67114c9a3480ced043c3afa8e9f9f2176d49d3e41",
         intel: "e1c441af35acff25c413775e7f39e44aaf2f0ad3aee449d7bbf30eaddbd0ad17"

  url "https://github.com/Nyora-Manga/nyora-mac/releases/download/v#{version}/Nyora-#{version}-mac-#{arch}.dmg",
      verified: "github.com/Nyora-Manga/nyora-mac/"
  name "Nyora"
  desc "AI-powered manga reader"
  homepage "https://nyora.xyz"

  # Always tracks the newest Nyora for macOS GitHub release, so `brew livecheck`
  # (and the auto-bump tooling) flags this cask the moment a newer version ships.
  livecheck do
    url :url
    strategy :github_latest
  end

  # Electron desktop build, published for both Apple Silicon and Intel.
  depends_on macos: ">= :sonoma"

  app "Nyora.app"

  caveats <<~EOS
    Nyora is not notarised, so macOS blocks it on first launch.
    Allow it once via  System Settings → Privacy & Security → "Open Anyway",
    or clear the download quarantine:

      xattr -dr com.apple.quarantine "/Applications/Nyora.app"

    To skip the prompt entirely, install with:

      brew install --cask --no-quarantine nyora
  EOS

  zap trash: [
    "~/Library/Application Support/app.nyora.desktop.preview",
    "~/Library/Caches/app.nyora.desktop.preview",
    "~/Library/Preferences/app.nyora.desktop.preview.plist",
    "~/Library/Saved Application State/app.nyora.desktop.preview.savedState",
  ]
end
