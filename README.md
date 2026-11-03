# Linux Lab Scripts

Bash scripts for the labs of the course "System Programming and OS Administration".

## Contents

- `count_files.sh` - counts regular files, directories and links in a directory (default: /etc)
- `count_files.1`, `count-files.conf` - man page and config file
- `packaging/rpm/count-files.spec` - spec file for the RPM package
- `packaging/deb/debian/` - files for the DEB package

## Usage

```bash
./count_files.sh                  # files in /etc
./count_files.sh /usr/share       # another directory
./count_files.sh -e conf          # only .conf files
./count_files.sh -r /etc          # with all subdirectories
./count_files.sh -h               # help
./count_files.sh -r -e conf /etc  # all .conf files with subdirectories
```

## Example

![Example output](images/demo.png)

## PPA

```bash
sudo add-apt-repository ppa:xitu-a1/count-files
sudo apt install count-files
```

![apt install from PPA](images/ppa-install.png)

## RPM package

![rpm -Uvh](images/rpm-upgrade.png)

![rpm -qi](images/rpm-info.png)

![man count_files](images/rpm-man.png)

![config file](images/rpm-config.png)

## DEB package

![dpkg -i](images/deb-install.png)

## Author

Student of group PI-241
