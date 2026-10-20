cask "lienzo" do
  arch arm: "arm64", intel: "x64"

  version "0.3.9"
  sha256 arm:   "619acc586a1de30edb5788d41eca1c27053a8f242b5450bdf9c7c3dd384e83d2",
         intel: "c0dffc6e03d151a546250ac69c27e288a00b6ac5acf558352114802ce9c7bad4"

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
