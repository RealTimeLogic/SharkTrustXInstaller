# SharkTrustX Installer

[SharkTrustX](https://github.com/RealTimeLogic/SharkTrustX) [Ansible](https://en.wikipedia.org/wiki/Ansible_(software)) installation scripts.

- NewMachine - prepare and optionally harden a new VPS
- SharkTrustX - SharkTrust installer

Edit the two `vars.yaml` files prior to running the two `main.sh` scripts.
Do not leave the placeholder passwords in `SharkTrustX/vars.yaml`; the
playbook rejects them.

Run the installer from Linux. On Windows, use the `Ubuntu-22.04` WSL2
distribution. Install Ansible and the required collections before the first
run:

```console
sudo apt-get install sshpass
pipx install ansible --include-deps
ansible-galaxy collection install -r NewMachine/requirements.yml
ansible-galaxy collection install -r SharkTrustX/requirements.yml
```

Prepare a new VPS using its initial root password:

```console
cd NewMachine
bash main.sh portal.example.com
```

The script uses `~/.ssh/id_ed25519.pub` or `~/.ssh/id_rsa.pub`, in that order.
To use another public key, pass its path as the second argument. Initial VPS
preparation installs only Python, `sudo`, and CA certificates, then creates the
deployment user. Full distribution upgrades, unattended upgrades, firewall
configuration, fail2ban, package removal, and disabling root SSH access are
separate options in `NewMachine/vars.yaml` and are disabled by default.
Before enabling `disable_root_ssh`, verify that the deployment account can log
in with its SSH key and can run `sudo -n true`.

Install or upgrade a portal with:

```console
cd SharkTrustX
bash main.sh portal.example.com deployment-user
```

`mako_local_archive` can name a Mako release archive on the Ansible
controller. Leave it empty to use `mako_download_url`. A matching
`mako_archive_checksum` is required in both cases. The public download URL is
left unset by default until it supplies the Mako build required by the current
portal. Existing `mako.conf` files are preserved; set `replace_mako_conf: true`
to replace one deliberately while retaining Ansible's timestamped backup. The
portal source is packaged as `SharkTrustX.zip`; the database, certificates,
and ACME state remain outside that archive and are preserved during upgrades.

## Tutorials

* [Installing the SharkTrustX Portal](https://realtimelogic.com/articles/Installing-the-SharkTrustX-Portal)
