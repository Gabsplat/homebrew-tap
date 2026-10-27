cask "lienzo" do
  arch arm: "arm64", intel: "x64"

  version "0.3.13"
  sha256 arm:   "7ea95eff8af4095199be910ee8f25c9733d15e3a29c2f0c8254561e9a2f89cad",
         intel: "4c5b81650f0bd4b524c631a85a196782c6ee8e5e00d774622241841712c39c66"

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
