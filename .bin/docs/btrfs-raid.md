# BTRFS RAID Storage Documentation

**Created:** November 18, 2026  
**Mount Point:** `/mnt/btrfs`  
**Filesystem Label:** `btrfs-data`  
**Filesystem UUID:** `86ec6cbb-ba62-4bfb-a1da-11acf7e94e61`  
**RAID Profile:** `RAID1` (Data, Metadata, and System mirrored across 2 drives; ~1.36 TiB usable capacity)

# Table of Contents
- [BTRFS RAID Storage Documentation](#btrfs-raid-storage-documentation)
- [Table of Contents](#table-of-contents)
  - [Physical Drives Inventory](#physical-drives-inventory)
    - [Command to Inspect Physical Disks \& UUIDs](#command-to-inspect-physical-disks--uuids)
  - [Filesystem Creation Baseline \& Future Feature Upgrades](#filesystem-creation-baseline--future-feature-upgrades)
    - [How to Check \& Upgrade Features in the Future](#how-to-check--upgrade-features-in-the-future)
    - [Optional Future Upgrade: `block-group-tree` (Faster Mounts on Multi-TB Arrays)](#optional-future-upgrade-block-group-tree-faster-mounts-on-multi-tb-arrays)
  - [Install Required Packages (On a Fresh Linux System)](#install-required-packages-on-a-fresh-linux-system)
  - [Mounting the RAID1 Array](#mounting-the-raid1-array)
    - [A. Quick Manual Mount](#a-quick-manual-mount)
    - [B. Permanent Mount via `/etc/fstab`](#b-permanent-mount-via-etcfstab)
  - [Health Checks \& Maintenance](#health-checks--maintenance)
    - [Check Array Health, Space \& Drive Errors](#check-array-health-space--drive-errors)
      - [Resetting Error Counters](#resetting-error-counters)
    - [Run a Data Integrity Scrub](#run-a-data-integrity-scrub)
  - [Emergency Recovery (If One Drive Dies)](#emergency-recovery-if-one-drive-dies)

---

## Physical Drives Inventory

> **Note:** Device letters (`/dev/sdb`, `/dev/sdc`) can swap between reboots. Always identify physical drives using the **Model**, **Serial Number**, **PARTUUID**, or **UUID_SUB** listed below.

| Btrfs `devid` | Printed Model | Serial Number | Size | Partition (`PARTUUID`) | Sub-UUID (`UUID_SUB`) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **`devid 1`** | `WDC WD15EADS-00S2B0` | `WD-WCAVY1814382` | 1.36 TiB (1.5 TB) | `fe7da4c4-afc0-49b1-b59e-190d8caff2dd` | `bda59a53-50d2-4919-a49c-89ac8b2c5fee` |
| **`devid 2`** | `WDC WD25EZRX-00MMMB0` | `WD-WCAWZ1499199` | 2.27 TiB (2.5 TB) | `3471c35d-6610-44ec-a21f-b9357503e2cc` | `aa91628b-42b0-47e9-bc3c-d307110de594` |

*(OS / Boot Drive: `INTENSO SSD` 232.9 GiB NVMe — Serial `532608019002722`, not part of the Btrfs RAID1 pool.)*

### Command to Inspect Physical Disks & UUIDs
Run this command on any Linux system to verify connected models, serial numbers, and Btrfs member partitions:
```bash
lsblk -d -o NAME,MODEL,SERIAL,SIZE,TRAN && echo "---" && blkid -t TYPE=btrfs && echo "---" && sudo btrfs filesystem show
```

---

## Filesystem Creation Baseline & Future Feature Upgrades

Recording the exact software versions and on-disk superblock flags used when creating this array makes it easy in 5+ years to compare against newer `mkfs.btrfs` defaults and safely enable modern features via `btrfstune`.

| Parameter | Value at Creation | Notes / Meaning |
| :--- | :--- | :--- |
| **Linux Kernel** | `6.18.50+rpt-rpi-2712` (ARM64) | Raspberry Pi OS / Debian |
| **`btrfs-progs` Version** | `v6.14` | Built with `+LZO +ZSTD +FSVERITY +ZONED` |
| **Checksum Algorithm (`csum_type`)** | `0 (crc32c)` | Hardware-accelerated default checksums |
| **Read-Only Compat Flags (`compat_ro_flags`)** | `0x3` | `FREE_SPACE_TREE` + `FREE_SPACE_TREE_VALID` (`space_cache=v2`) |
| **Incompat Flags (`incompat_flags`)** | `0x351` | `MIXED_BACKREF`, `BIG_METADATA`, `EXTENDED_IREF`, `SKINNY_METADATA`, `NO_HOLES` |
| **Active Mount Compression** | `zstd:3` + `autodefrag` | Transparent compression + background defrag for HDDs |
| **Drive Firmware Tweaks** | `idle3ctl -s 138` (5 min) | Applied permanently to both WD Green drives (`WD25EZRX` & `WD15EADS`) to prevent 8s head-parking wear. Only needed for legacy WD Green desktop HDDs (produced up to ~2015–2016); not needed for WD Red or modern NAS drives. |

### How to Check & Upgrade Features in the Future
1. **Inspect current on-disk superblock flags:**
   ```bash
   btrfs --version && sudo btrfs inspect-internal dump-super /dev/sdX1 | grep -E "csum_type|incompat_flags|compat_ro_flags"
   ```
2. **Compare against current `mkfs.btrfs` defaults** on a newer Linux system:
   ```bash
   mkfs.btrfs -O list-all
   ```
3. **Enable newer on-disk features without reformatting** (must be run while `/mnt/btrfs` is **unmounted**, e.g., enabling `block-group-tree` for faster mount times on multi-terabyte arrays):
   ```bash
   sudo umount /mnt/btrfs
   sudo btrfstune --convert-to-block-group-tree /dev/sdX1
   sudo mount -a
   ```
   *(Caution: Only enable new on-disk flags if all Linux machines you plan to mount these disks on run a kernel new enough to support those flags.)*

### Optional Future Upgrade: `block-group-tree` (Faster Mounts on Multi-TB Arrays)
* **Current Status:** Not enabled (keeps array compatible with Linux kernels `5.15+`).
* **When to Enable:** Only needed if the array grows to several terabytes and mount times take noticeably longer than a couple of seconds. *(Requires Linux kernel `6.1+` on any machine mounting these drives).*
* **How to Enable (Offline):**
  1. Ensure **all** member disks of the RAID1 array are connected.
  2. Unmount the filesystem and run `btrfstune` against **any single** member partition (Btrfs automatically updates the mirrored metadata across all disks in the pool):
     ```bash
     sudo umount /mnt/btrfs
     sudo btrfstune --convert-to-block-group-tree /dev/sdX1
     sudo mount -a
     ```

---

## Install Required Packages (On a Fresh Linux System)
On Debian, Ubuntu, or Raspberry Pi OS, install `btrfs-progs` (required for multi-device Btrfs scanning and management) and `smartmontools` (for reading drive SMART health):
```bash
sudo apt update && sudo apt install -y btrfs-progs smartmontools
```

---

## Mounting the RAID1 Array 

Btrfs stores RAID metadata directly on each disk's superblock—no `mdadm.conf` or hardware RAID controller is required. Plugging these drives into **any Linux machine with `btrfs-progs` installed** allows immediate mounting.

### A. Quick Manual Mount
```bash
sudo mkdir -p /mnt/btrfs
sudo btrfs device scan
sudo mount -t btrfs -o noatime,compress=zstd:3,autodefrag -U 86ec6cbb-ba62-4bfb-a1da-11acf7e94e61 /mnt/btrfs
```

### B. Permanent Mount via `/etc/fstab`
1. Edit `/etc/fstab`:
   ```bash
   sudo nano /etc/fstab
   ```
2. Add the following line:
   ```text
   UUID=86ec6cbb-ba62-4bfb-a1da-11acf7e94e61  /mnt/btrfs  btrfs  defaults,nofail,x-systemd.device-timeout=30s,noatime,compress=zstd:3,autodefrag  0  0
   ```
   * **`nofail`**: Prevents boot hangs if a USB drive is unplugged or fails.
   * **`x-systemd.device-timeout=30s`**: Waits up to 30 seconds for slow-spinning USB HDDs to initialize before skipping the mount.
   * **`noatime`**: Stops metadata writes on file reads (ideal for NAS folder browsing).
   * **`compress=zstd:3`**: Transparently compresses compressible files on the fly without wasting CPU on pre-compressed media.
   * **`autodefrag`**: Automatically detects small random writes and rewrites them sequentially in the background to prevent fragmentation on mechanical HDDs. *(Avoid hosting active SQLite/Postgres databases or large VM disk images directly on this mount unless `chattr +C` is set on their folder.)*
   * *(Do **not** add `degraded` to `fstab`—if one drive spins up slowly, mounting degraded would write unmirrored `single` chunks.)*

3. Reload `systemd` so it regenerates mount units from the updated `fstab`, then mount (or remount):
   ```bash
   sudo systemctl daemon-reload
   sudo mkdir -p /mnt/btrfs
   sudo mount -a
   sudo mount -o remount /mnt/btrfs
   ```
4. Verify the active mount options:
   ```bash
   findmnt /mnt/btrfs
   ```

---

## Health Checks & Maintenance

### Check Array Health, Space & Drive Errors
```bash
sudo btrfs filesystem usage /mnt/btrfs
sudo btrfs device stats /mnt/btrfs
```
*(All error counters should remain `0`. Note: With two mismatched drives, `Free (statfs, df)` shows the true remaining usable RAID1 space.)*

#### Resetting Error Counters
Btrfs error counters are cumulative and saved permanently on disk until manually cleared. After repairing a temporary glitch (such as an accidental USB disconnect) and completing a full `btrfs scrub` with `Uncorrectable: 0`, reset the counters to `0` so you can spot any new issues:
```bash
sudo btrfs device stats -z /mnt/btrfs
```
*(Note: The `-z` flag prints the current stats one final time and immediately zeroes all counters.)*


### Run a Data Integrity Scrub
A scrub reads every block on both drives and automatically repairs silent corruption using checksums and the healthy mirror copy:
```bash
sudo btrfs scrub start /mnt/btrfs
sudo btrfs scrub status /mnt/btrfs
```

---

## Emergency Recovery (If One Drive Dies)

Because the array uses **RAID1** for Data, Metadata, and System chunks, it can survive the complete failure of either drive:

1. **Mount in degraded (read-only) mode** with only the surviving drive attached:
   ```bash
   sudo mkdir -p /mnt/btrfs
   sudo mount -o ro,degraded -U 86ec6cbb-ba62-4bfb-a1da-11acf7e94e61 /mnt/btrfs
   ```
2. **Back up critical files** immediately while mounted read-only.
3. **Identify the dead drive's `devid`:**
   Run `sudo btrfs filesystem show /mnt/btrfs` while mounted. Look for the `devid` marked `*** Some devices missing` (or cross-reference the failing drive's path against `sudo btrfs device stats /mnt/btrfs`):
   ```text
   devid    1 size 1.36TiB used 339.03GiB path /dev/sdc1
   devid    2 size 2.27TiB used 339.03GiB path *** Some devices missing
   ```
   *(In this example, `<dead_devid>` is `2`.)*
4. **Replace the dead drive permanently:**
   Remount in read-write degraded mode (`sudo mount -o remount,rw,degraded /mnt/btrfs`), attach a replacement partition `/dev/sdX1` of equal or larger size, and run:
   ```bash
   sudo btrfs replace start <dead_devid> /dev/sdX1 /mnt/btrfs
   sudo btrfs replace status /mnt/btrfs
   ```
   *(Alternatively, if the dead drive is already physically disconnected, you can run `sudo btrfs device add /dev/sdX1 /mnt/btrfs` followed by `sudo btrfs device delete missing /mnt/btrfs`.)*

