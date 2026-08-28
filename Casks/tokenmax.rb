cask "tokenmax" do
  version "0.1.12"
  sha256 "e233b54f086897235cbc69fa4d7d5c7eb6f727c1f9f007f41157a62032bae8c8"

  url "https://github.com/danieldrinhausen/Tokenmax/releases/download/v#{version}/Tokenmax-#{version}.dmg",
      verified: "github.com/danieldrinhausen/Tokenmax/"
  name "Tokenmax"
  desc "Menu bar app showing remaining Claude Code and Codex quota"
  homepage "https://github.com/danieldrinhausen/Tokenmax/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Tokenmax.app"

  zap trash: [
    "~/Library/Application Support/Tokenmax",
    "~/Library/Caches/com.tokenmax.Tokenmax",
    "~/Library/HTTPStorages/com.tokenmax.Tokenmax",
    "~/Library/Preferences/com.tokenmax.Tokenmax.plist",
    "~/Library/Saved Application State/com.tokenmax.Tokenmax.savedState",
  ]

  caveats <<~EOS
    Tokenmax is signed but not notarized, so macOS refuses the first launch:

      System Settings -> Privacy & Security -> Open Anyway

    It then asks once for access to the "Claude Code-credentials" keychain
    item, which is how it reads your quota. Both prompts return after every
    upgrade, because macOS binds the decision to the exact binary.
  EOS
end
