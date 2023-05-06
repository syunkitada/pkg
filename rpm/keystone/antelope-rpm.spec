Name:           %{name}
Url:            https://github.com/openstack/%{name}
Summary:        %{name}
License:        Apache-2.0
Group:          System/Emulators/PC
Version:        %{version}
Release:        %{release}
Source0:        base.tar.gz
BuildRoot:     %{_tmppath}/%{name}-%{version}-%{release}
AutoReq: no

%global __os_install_post %(echo '%{__os_install_post}' | sed -e 's!/usr/lib[^[:space:]]*/brp-python-bytecompile[[:space:]].*$!!g')

%description
%{name}

%prep
rm -rf %{buildroot}
rm -rf ./*
tar -xf ../SOURCES/base.tar.gz
wget https://github.com/openstack/%{name}/archive/%{version}.tar.gz
tar -xf %{version}.tar.gz

%build
python3.8 -m venv opt/%{name} --system-site-packages
opt/%{name}/bin/pip install -r base/%{version_name}-requirements.txt
grep '#!/usr/bin/env python$' opt/* -rl | xargs sed -i 's|#!/usr/bin/env python|#!/usr/bin/env python3|g'

cd %{name}-%{version}
git config --global user.name "nobody"
git config --global user.email "nobody@example.com"
git init
git add .
git commit -m %{version}
git tag -a %{version} -m %{version}
../opt/%{name}/bin/python setup.py install
cd ../

find opt/%{name} -name '*.pyc' | xargs rm -f || echo 'no *.pyc'
sed -i "s/\/tmp\/rpmbuild\/BUILD//g" opt/%{name}/bin/*

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}
mkdir -p %{buildroot}/etc
mkdir -p %{buildroot}/usr/lib/systemd/
cp -r opt %{buildroot}
cp -r %{name}-%{version}/etc %{buildroot}/etc/%{name}
cp -r base/system %{buildroot}/usr/lib/systemd/system

%clean
rm -rf %{buildroot}

%files
/opt/%{name}
%attr(-, root, root) /usr/lib/systemd/system/*
%dir %attr(0755, root, root) /etc/%{name}
%config(noreplace) %attr(-, root, root) /etc/%{name}/*

%changelog
