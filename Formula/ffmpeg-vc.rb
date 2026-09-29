class FfmpegVc < Formula
  desc "Portable static FFmpeg with x264, x265, SVT-AV1, dav1d, zimg and libass"
  homepage "https://github.com/video-commander/ffmpeg-builder"
  version "9.0.1-4"
  license "GPL-3.0-or-later"

  if Hardware::CPU.arm?
    url "https://github.com/video-commander/ffmpeg-builder/releases/download/v9.0.1-4/ffmpeg-9.0.1-macos-arm64.zip"
    sha256 "d0384565fc656057fb547704dcf091d3013fb18a27981fd0d1c98b053208d6a2"
  else
    url "https://github.com/video-commander/ffmpeg-builder/releases/download/v9.0.1-4/ffmpeg-9.0.1-macos-x86_64.zip"
    sha256 "9a59aab845661a2f3293ddff462590fe8555b8eb08ceb312e526d0faf5c1880e"
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
