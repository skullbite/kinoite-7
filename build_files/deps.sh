#!/bin/bash

set -ouex pipefail

# did this because i had like 20 repeated dependencies and it was driving me nuts

# general
dnf install -y fastfetch steam tailscale gum glow

dnf copr enable -y secureblue/packages
dnf install -y homebrew
dnf copr disable -y secureblue/packages

# aerothemeplasma
dnf install -y layer-shell-qt-devel wayland-protocols-devel sddm ninja gcc gcc-c++ cmake make extra-cmake-modules plasma-workspace-devel libksysguard-devel kvantum qt6-qtmultimedia-devel qt6-qt5compat-devel libplasma-devel qt6-qtbase-devel qt6-qtwayland-devel plasma-activities-devel kf6-kpackage-devel kf6-kglobalaccel-devel qt6-qtsvg-devel wayland-devel plasma-wayland-protocols kf6-ksvg-devel kf6-kcrash-devel kf6-kguiaddons-devel kf6-kcmutils-devel kf6-kio-devel kdecoration-devel kf6-ki18n-devel kf6-knotifications-devel kf6-kirigami-devel kf6-kiconthemes-devel cmake gmp-ecm-devel kf5-plasma-devel libepoxy-devel kwin-devel kf6-karchive-devel plasma-wayland-protocols-devel qt6-qtbase-private-devel qt6-qtbase-devel kf6-knewstuff-devel kf6-knotifyconfig-devel kf6-attica-devel kf6-krunner-devel kf6-kdbusaddons-devel kf6-sonnet-devel plasma5support-devel plasma-activities-stats-devel polkit-qt6-1-devel qt-devel libdrm-devel kf6-kitemmodels-devel kf6-kstatusnotifieritem-devel kf6-frameworkintegration-devel

# apps
dnf install -y kf6-kio kf6-kparts-devel kf6-baloo-devel kf6-kcoreaddons-devel libjpeg-turbo-devel exiv2-devel lcms2-devel kimageannotator-qt6-devel libkdcraw-devel kcolorpicker-qt6-devel patchelf

# gadgets
dnf install -y qt6-qtbase kf6-kunitconversion-devel kf6-kholidays-devel extra-cmake-modules qt6-qtdeclarative-devel kf6-ktextwidgets-devel

# plymouthvista
dnf install -y plymouth plymouth-scripts plymouth-plugin-script ImageMagick