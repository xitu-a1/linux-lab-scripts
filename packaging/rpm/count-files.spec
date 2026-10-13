Name:           count-files
Version:        1.0
Release:        1%{?dist}
Summary:        Script to count regular files in a directory
License:        MIT
URL:            https://github.com/xitu-a1/my-first-repository
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch
Requires:       bash
Requires:       coreutils
Requires:       findutils

%description
A Bash script that counts regular files, directories and symbolic links
in a directory (/etc by default). It can count only files with a given
extension, look into all subdirectories and show the total size of files.

%prep
%setup -q

%install
mkdir -p %{buildroot}%{_bindir}
install -m 755 count_files.sh %{buildroot}%{_bindir}/count_files

%files
%{_bindir}/count_files

%changelog
* Tue Oct 13 2026 Radomskyi Anton <radomskyianton@gmail.com> - 1.0-1
- Initial package release
