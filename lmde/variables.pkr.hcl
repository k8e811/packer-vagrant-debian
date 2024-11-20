# Debian Bullseye Vagrant box - Variables
#
# copyright: 2020-2022, Frederico Martins
# author: Frederico Martins <http://github.com/fscm>
# license: SPDX-License-Identifier: MIT

# variables

variables {
    disk_size_mb          = 8192
    debug                 = false
    domain                = "vagrant.local"
    hostname              = "lmde"
    os_version            = "6"
    password              = "faye"
    username              = "faye"
    _boot_wait_sec        = 10
    _headless             = true
    _os_arch              = "amd64"
    _os_codename          = "faye"
    _os_type_vbox         = "Debian_64"
    _os_type_vmware       = "debian10_64Guest"
    _ssh_port             = 22
    _ssh_wait_timeout_sec = 3600
    _system_memory_mb     = 2048
    _timezone             = "UTC"
}

# locals

locals {
    _boot_command     = [
        "<esc><wait>",
        "/casper/vmlinuz",
        " boot=live ",
        " live-config ",
        " initrd=/casper/initrd.lz ",
        " live-media-path=/casper ",
#        " quiet",
#        " splash",
        " --"
        " lowmem/low=true",
        " preseed/url=http://{{.HTTPIP}}:{{.HTTPPort}}/preseed.cfg",
        " netcfg/get_hostname=${var.hostname}",
        " netcfg/get_domain=${var.domain}",
        " netcfg/hostname=${var.hostname}",
        " netcfg/domain=${var.domain}",
        " time/zone=${var._timezone}",
        " passwd/root-password=${var.password}",
        " passwd/root-password-again=${var.password}",
        " passwd/username=${var.username}",
        " passwd/user-password=${var.password}",
        " passwd/user-password-again=${var.password}<enter>"
    ]
    # _headless         = "${!var.debug}"
    _headless         = false
    _iso_checksum     = "file:https://mirrors.kernel.org/linuxmint/debian/sha256sum.txt"
    _iso_target_path  = "${abspath(path.root)}/../builds/cache/lmde-${var.os_version}-${var._os_arch}-netinst.iso"
    _iso_urls         = [
        "${abspath(path.root)}/../builds/isos/lmde-${var.os_version}-cinnamon-64bit.iso",
        "https://mirrors.kernel.org/linuxmint/debian/lmde-6-cinnamon-64bit.iso"
    ]
    _output           = "${abspath(path.root)}/../builds/providers/{{.Provider}}/${var._os_codename}-${var._os_arch}.box"
    _output_directory = "${abspath(path.root)}/../builds/sandbox"
    _preseed_file     = "${abspath(path.root)}/preseed.cfg"
    _provisioner_file = "${abspath(path.root)}/provisioner.sh"
    _vagrantfile      = "${abspath(path.root)}/../builds/cache/${var._os_codename}-Vagrantfile"
    _vagrantfile_tpl  = "${abspath(path.root)}/Vagrantfile.pkrtpl.hcl"
    _vm_name          = "${var._os_codename}-${var._os_arch}-${formatdate("YYYYMMDDhhmmss", timestamp())}"
}
