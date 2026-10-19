cask "lienzo" do
  arch arm: "arm64", intel: "x64"

  version "0.3.2"
  sha256 arm:   "3ab7376a5e86c3bd698f3258acd66bdce6f5af6b282d5f7dde1275e2cbc5d040",
         intel: "15d2837123801290a61d0c52df35b5da4c10f796ee043b6ce5fe3362d7b44619"

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
