#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):80740352:f1718e24f983c8b3cf34248ead5b75a11f041ff9; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):33554432:5332b8e0dd0b67bf46c335dc7bc0399c32e1f4c3 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):80740352:f1718e24f983c8b3cf34248ead5b75a11f041ff9 && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

