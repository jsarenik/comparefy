# Meant to be sourced

type bc >/dev/null 2>&1 && BC=bc || {
  test -x $PWD/busybox-x86_64 || {
    wget --quiet \
      https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64
    chmod a+x busybox-x86_64
  }
  echo Using busybox bc
  BC="$PWD/busybox-x86_64 bc"
}
