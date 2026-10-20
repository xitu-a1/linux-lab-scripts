Name:           count-files
Version:        2.0
Release:        1%{?dist}
Summary:        Script to count regular files in a directory
License:        MIT
URL:            https://github.com/xitu-a1/linux-lab-scripts
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch
Requires:       bash, coreutils, findutils, grep

%description
A Bash script that counts regular files, directories and symbolic links
in a directory. The default directory is set in /etc/count-files.conf.

%prep
%setup -q

%install
install -D -m 755 count_files.sh %{buildroot}%{_bindir}/count_files
install -D -m 644 count_files.1 %{buildroot}%{_mandir}/man1/count_files.1
install -D -m 644 count-files.conf %{buildroot}%{_sysconfdir}/count-files.conf

%pre
echo "Installing count-files %{version}..."

%post
echo "count-files is installed. Try: count_files -h"

%files
%{_bindir}/count_files
%{_mandir}/man1/count_files.1*
%config(noreplace) %{_sysconfdir}/count-files.conf

%changelog
* Tue Oct 20 2026 Radomskyi Anton <radomskyianton@gmail.com> - 2.0-1
- Add man page, config file and install messages
- Fix project URL
* Tue Oct 13 2026 Radomskyi Anton <radomskyianton@gmail.com> - 1.0-1
- Initial package release
