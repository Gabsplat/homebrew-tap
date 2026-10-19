cask "lienzo" do
  arch arm: "arm64", intel: "x64"

  version "0.3.8"
  sha256 arm:   "4be8020cfaef969b38dc580dbc641674a665acdde0b379a708b737f948e91fd8",
         intel: "b217f31c6626f1bc1ba7e4bbaf5f5c847c77e442e34868d86cafb7ef1fbacfc2"

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
