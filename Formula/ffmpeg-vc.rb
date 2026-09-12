class FfmpegVc < Formula
  desc "Portable static FFmpeg with x264, x265, SVT-AV1, dav1d, zimg and libass"
  homepage "https://github.com/video-commander/ffmpeg-builder"
  version "9.0.1-3"
  license "GPL-3.0-or-later"

  if Hardware::CPU.arm?
    url "https://github.com/video-commander/ffmpeg-builder/releases/download/v9.0.1-3/ffmpeg-9.0.1-macos-arm64.zip"
    sha256 "80205899af8b4ff989bd62e6616124f76d3ee1c9eebf6a05e334724326d73bfb"
  else
    url "https://github.com/video-commander/ffmpeg-builder/releases/download/v9.0.1-3/ffmpeg-9.0.1-macos-x86_64.zip"
    sha256 "4a875e89fd4802b780282985dc8fce4b1c5ce1cd73e679f7730258ef15d7956a"
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  conflicts_with "ffmpeg", because: "both install ffmpeg and ffprobe binaries"

  def install
    # Homebrew strips the archive's single top-level directory.
    bin.install Dir["bin/*"]
    pkgshare.install "LICENSES", "configure-flags.txt"
  end

  test do
    assert_match "ffmpeg version #{version.to_s.sub(/-\d+$/, "")}",
                 shell_output("#{bin}/ffmpeg -version")
    assert_match "--enable-libdav1d", shell_output("#{bin}/ffmpeg -hide_banner -buildconf 2>&1")
    assert_match "--enable-libzimg", shell_output("#{bin}/ffprobe -hide_banner -buildconf 2>&1")
  end
end
