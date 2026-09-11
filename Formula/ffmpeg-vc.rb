class FfmpegVc < Formula
  desc "Portable static FFmpeg with x264, x265, SVT-AV1, dav1d, zimg and libass"
  homepage "https://github.com/video-commander/ffmpeg-builder"
  version "9.0.1-2"
  license "GPL-3.0-or-later"

  if Hardware::CPU.arm?
    url "https://github.com/video-commander/ffmpeg-builder/releases/download/v9.0.1-2/ffmpeg-9.0.1-macos-arm64.zip"
    sha256 "49fce4f35a0c5907353e6323c24da23c118e0a35d90a0901163c5ac0ad786121"
  else
    url "https://github.com/video-commander/ffmpeg-builder/releases/download/v9.0.1-2/ffmpeg-9.0.1-macos-x86_64.zip"
    sha256 "334e5e7430766bf84d544fa3075ceb0c43c4ad70c453b573dc102e224ffc338f"
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
