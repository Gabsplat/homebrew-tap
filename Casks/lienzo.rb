cask "lienzo" do
  arch arm: "arm64", intel: "x64"

  version "0.3.12"
  sha256 arm:   "e32050ecfb467aa292dbfdee11c8f20b7a96402eb822fcf1062ee25199dba27b",
         intel: "0de10806dba5d5bac8222111baad901c0605469615786787f0627e9f9696eef1"

  url "https://github.com/Gabsplat/paseo-canvas/releases/download/desktop-v#{version}/Lienzo-#{version}-mac-#{arch}.dmg"
  name "Lienzo"
  desc "Canvas you and your agent draw explanations on"
  homepage "https://github.com/Gabsplat/paseo-canvas"

  livecheck do
    url "https://github.com/Gabsplat/paseo-canvas"
    regex(/^desktop-v(\d+(?:\.\d+)+)$/i)
    strategy :git
  end

  depends_on macos: :big_sur

  app "Lienzo.app"

  # Lienzo is not signed with an Apple Developer ID yet, so Gatekeeper would refuse to open it. Installing through
  # this tap is the owner's explicit choice to trust it: the quarantine flag is removed once the app is in place.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Lienzo.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/Lienzo",
    "~/Library/Preferences/dev.gabsplat.lienzo.plist",
    "~/Library/Saved Application State/dev.gabsplat.lienzo.savedState",
  ]
end
