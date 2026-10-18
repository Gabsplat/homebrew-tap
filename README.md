# Gabsplat's Homebrew tap

```
brew install --cask gabsplat/tap/lienzo
brew upgrade --cask lienzo
```

| Cask | What it is |
|---|---|
| `lienzo` | [Lienzo](https://github.com/Gabsplat/paseo-canvas), a canvas you and your agent draw explanations on (desktop app) |

Lienzo is not signed with an Apple Developer ID yet. Installing it from this tap removes macOS's quarantine flag
from the app so it opens without the "Apple could not verify" block; do it only if you trust this source.

`.github/workflows/update-lienzo.yml` moves the cask to each new release by itself.
