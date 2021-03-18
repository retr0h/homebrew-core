class Grin < Formula
  desc "Minimal implementation of the Mimblewimble protocol"
  homepage "https://grin.mw/"
  url "https://github.com/mimblewimble/grin/archive/v5.0.2.tar.gz"
  sha256 "5057f0ae0e93a694bafe29a9d9e3a8599638d23270accd7af7758cd6c1f89f5d"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:  "23508e8aeb1f492d02cab86a37ee13a01b7c91e51ba9f99915bb290168aa65e3"
    sha256 cellar: :any_skip_relocation, catalina: "614b5706b1411d4fe034892ebd04757c8130dce05c839bb49c530ef35aff7c18"
    sha256 cellar: :any_skip_relocation, mojave:   "367c827e429afa3bff4c03f2c272d8e6b18346eda070994afe32230a6f3f59da"
  end

  depends_on "llvm" => :build # for libclang
  depends_on "rust" => :build

  def install
    ENV["CLANG_PATH"] = Formula["llvm"].opt_bin/"clang"

    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/grin", "server", "config"
    assert_predicate testpath/"grin-server.toml", :exist?
  end
end
