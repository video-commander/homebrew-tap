# video-commander/homebrew-tap

Homebrew tap for [ffmpeg-builder](https://github.com/video-commander/ffmpeg-builder) —
portable, statically linked, signed and notarized FFmpeg builds for macOS.

## Install

```bash
brew tap video-commander/tap
brew install video-commander/tap/ffmpeg-vc
```

This installs `ffmpeg` and `ffprobe`. It conflicts with Homebrew's core
`ffmpeg`, which installs binaries of the same name — remove or unlink that
first:

```bash
brew uninstall ffmpeg     # or: brew unlink ffmpeg
```

## What you get

A single static binary per architecture with no runtime dependencies outside
macOS itself. Built with:

- **Video** — x264, x265, SVT-AV1, libaom (AV1), dav1d (AV1 decode), libvpx (VP8/VP9)
- **Audio** — Opus, LAME (MP3), AAC
- **Filters** — zscale (zimg: colour space, transfer, tone mapping), drawtext, libass subtitles, libvmaf
- **Protocols** — SRT, HTTPS (OpenSSL)

## Licensing

These are GPL binaries (`--enable-gpl --enable-version3`). Every linked
library's license text is installed alongside them:

```bash
ls "$(brew --prefix ffmpeg-vc)/share/ffmpeg-vc/LICENSES"
```

The corresponding source for each component, at the exact pinned version, is
listed in every [release](https://github.com/video-commander/ffmpeg-builder/releases).
The exact configure line is in `share/ffmpeg-vc/configure-flags.txt`.
