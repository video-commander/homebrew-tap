class FfmpegVc < Formula
  desc "Portable static FFmpeg with x264, x265, SVT-AV1, dav1d, zimg and libass"
  homepage "https://github.com/video-commander/ffmpeg-builder"
  version "9.0.1-1"
  license "GPL-3.0-or-later"

  if Hardware::CPU.arm?
    url "https://github.com/video-commander/ffmpeg-builder/releases/download/v9.0.1-1/ffmpeg-9.0.1-macos-arm64.zip"
    sha256 "6d74d9970d22efc0542b38f2038b32b98af47b081d139575102cf5079d21ef6a"
  else
    url "https://github.com/video-commander/ffmpeg-builder/releases/download/v9.0.1-1/ffmpeg-9.0.1-macos-x86_64.zip"
    sha256 "d3f9e0cd116cb3c062179fc42e8fa1dc12998ef0f9efc2506895dab6fff236da"
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  conflicts_with "ffmpeg", because: "both install ffmpeg and ffprobe binaries"

  def install
    root = Dir["macos-*"].first
    bin.install Dir["#{root}/bin/*"]
    pkgshare.install "#{root}/LICENSES", "#{root}/configure-flags.txt"
  end

  test do
    assert_match "ffmpeg version #{version.to_s.sub(/-\d+$/, "")}",
                 shell_output("#{bin}/ffmpeg -version")
    assert_match "--enable-libdav1d", shell_output("#{bin}/ffmpeg -hide_banner -buildconf 2>&1")
    assert_match "--enable-libzimg", shell_output("#{bin}/ffprobe -hide_banner -buildconf 2>&1")
  end
end
