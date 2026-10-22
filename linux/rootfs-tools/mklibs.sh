#!/bin/bash
# mklibs.sh — cross-build commonly-used target libraries into the rootfs.
# Uses the existing riscv32-linux-musl cross toolchain; DESTDIR-stages then
# merges into $ROOTFS. Re-runnable; per-package failures don't abort.
set -u

BASE=${ALVX_ROOTFS:-/home/li/work/altera/rootfs}
ROOTFS=$BASE/rootfs
STAGE=$BASE/libs-stage
WORK=$BASE/libs-build
TARBALLS=$BASE/libs-tarballs
TC=/home/li/work/altera/vexriscv_soc/linux/toolchain-rv32ima/bin
T=riscv32-linux-musl
export PATH="$TC:$PATH"
export CC=$T-gcc CXX=$T-g++ AR=$T-ar RANLIB=$T-ranlib STRIP=$T-strip
export PKG_CONFIG=$T-pkg-config PKG_CONFIG_PATH= PKG_CONFIG_LIBDIR=$STAGE/usr/lib/pkgconfig:$STAGE/usr/share/pkgconfig
NJ=$(nproc)
mkdir -p "$STAGE" "$WORK" "$TARBALLS"
export CPPFLAGS="-I$STAGE/usr/include"
export LDFLAGS="-L$STAGE/usr/lib -Wl,-rpath-link,$STAGE/usr/lib"

LOG=$BASE/libs-build.log
: > "$LOG"

fetch() { # url
    local f=$TARBALLS/${1##*/}
    [ -f "$f" ] || curl -fsSL --retry 2 -o "$f" "$1" || { echo "DLFAIL $1" | tee -a "$LOG"; return 1; }
    tar -C "$WORK" -xf "$f"
}

run() { # name dir [cmd...]
    local name=$1 d=$2; shift 2
    echo "===== $name =====" | tee -a "$LOG"
    (cd "$WORK/$d" && "$@") >>"$LOG" 2>&1 && echo "PASS $name" | tee -a "$LOG" \
        || echo "FAIL $name" | tee -a "$LOG"
}

# ---------- zlib ----------
zlib() {
    fetch https://zlib.net/fossils/zlib-1.3.1.tar.gz || return
    run zlib zlib-1.3.1 ./configure --prefix=/usr
    run zlib zlib-1.3.1 make -j$NJ
    run zlib zlib-1.3.1 make DESTDIR="$STAGE" install
}

# ---------- bzip2 (no configure) ----------
bzip2() {
    fetch https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz || return
    run bzip2 bzip2-1.0.8 make -j$NJ -f Makefile-libbz2_so CC=$T-gcc
    run bzip2 bzip2-1.0.8 make -j$NJ bzip2 bzip2recover CC=$T-gcc AR=$T-ar RANLIB=$T-ranlib
    ( cd "$WORK/bzip2-1.0.8" &&
      make CC=$T-gcc PREFIX="$STAGE/usr" install >>"$LOG" 2>&1 &&
      cp -a libbz2.so.1.0.8 "$STAGE/usr/lib/" &&
      ln -sf libbz2.so.1.0.8 "$STAGE/usr/lib/libbz2.so.1.0" &&
      ln -sf libbz2.so.1.0 "$STAGE/usr/lib/libbz2.so" &&
      cp -a bzip2-shared "$STAGE/usr/bin/bzip2" ) \
      && echo "PASS bzip2" | tee -a "$LOG" || echo "FAIL bzip2" | tee -a "$LOG"
}

# ---------- xz ----------
xz() {
    fetch https://github.com/tukaani-project/xz/releases/download/v5.4.6/xz-5.4.6.tar.gz || return
    run xz xz-5.4.6 ./configure --host=$T --prefix=/usr --disable-static --disable-doc
    run xz xz-5.4.6 make -j$NJ
    run xz xz-5.4.6 make DESTDIR="$STAGE" install
}

# ---------- zstd ----------
zstd() {
    fetch https://github.com/facebook/zstd/releases/download/v1.5.6/zstd-1.5.6.tar.gz || return
    run zstd zstd-1.5.6 make -j$NJ -C lib
    ( cd "$WORK/zstd-1.5.6" && make -C lib install PREFIX=/usr DESTDIR="$STAGE" >>"$LOG" 2>&1 ) \
      && echo "PASS zstd" | tee -a "$LOG" || echo "FAIL zstd" | tee -a "$LOG"
}

# ---------- ncurses ----------
ncurses() {
    fetch https://ftp.gnu.org/gnu/ncurses/ncurses-6.5.tar.gz || return
    run ncurses ncurses-6.5 ./configure --host=$T --prefix=/usr --with-shared \
        --without-debug --enable-widec --without-ada --without-tests \
        --without-cxx-binding --disable-db-install --without-manpages \
        --with-terminfo-dirs=/usr/share/terminfo --with-default-terminfo-dir=/usr/share/terminfo
    run ncurses ncurses-6.5 make -j$NJ
    run ncurses ncurses-6.5 make DESTDIR="$STAGE" INSTALL_PROG='/usr/bin/install -c' install
    # common terminfo entries (install ships a few; ensure linux/vt100/xterm)
    if [ -x /usr/bin/qemu-riscv32 ] && [ ! -d "$STAGE/usr/share/terminfo/l" ]; then
        mkdir -p "$STAGE/lib"
        cp -a "$ROOTFS/lib/libc.so" "$STAGE/lib/ld-musl-riscv32-sf.so.1"
        cp -a "$ROOTFS/lib/libc.so" "$STAGE/lib/libc.so" 2>/dev/null
        /usr/bin/qemu-riscv32 -L "$STAGE" "$STAGE/usr/bin/tic" -x \
            -o "$STAGE/usr/share/terminfo" "$WORK/ncurses-6.5/misc/terminfo.src" \
            >>"$LOG" 2>&1 && echo "PASS terminfo" | tee -a "$LOG"
        rm -rf "$STAGE/lib"
    fi
}

# ---------- readline ----------
readline() {
    fetch https://ftp.gnu.org/gnu/readline/readline-8.2.tar.gz || return
    run readline readline-8.2 ./configure --host=$T --prefix=/usr --with-curses --disable-static
    run readline readline-8.2 make -j$NJ SHLIB_LIBS="-lncursesw"
    run readline readline-8.2 make DESTDIR="$STAGE" install
}

# ---------- openssl ----------
openssl() {
    fetch https://github.com/openssl/openssl/releases/download/openssl-3.0.16/openssl-3.0.16.tar.gz || return
    run openssl openssl-3.0.16 ./Configure linux-generic32 --prefix=/usr \
        --openssldir=/etc/ssl shared no-tests --cross-compile-prefix=$T- -latomic
    run openssl openssl-3.0.16 make -j$NJ
    run openssl openssl-3.0.16 make DESTDIR="$STAGE" install_sw
}

# ---------- sqlite ----------
sqlite() {
    fetch https://sqlite.org/2024/sqlite-autoconf-3460100.tar.gz || return
    run sqlite sqlite-autoconf-3460100 ./configure --host=$T --prefix=/usr --disable-static \
        --disable-readline
    run sqlite sqlite-autoconf-3460100 make -j$NJ
    run sqlite sqlite-autoconf-3460100 make DESTDIR="$STAGE" install
}

# ---------- libffi ----------
libffi() {
    fetch https://github.com/libffi/libffi/releases/download/v3.4.6/libffi-3.4.6.tar.gz || return
    run libffi libffi-3.4.6 ./configure --host=$T --prefix=/usr --disable-static
    run libffi libffi-3.4.6 make -j$NJ
    run libffi libffi-3.4.6 make DESTDIR="$STAGE" install
}

# ---------- expat ----------
expat() {
    fetch https://github.com/libexpat/libexpat/releases/download/R_2_6_4/expat-2.6.4.tar.xz || return
    run expat expat-2.6.4 ./configure --host=$T --prefix=/usr --disable-static --without-docbook
    run expat expat-2.6.4 make -j$NJ
    run expat expat-2.6.4 make DESTDIR="$STAGE" install
}

# ---------- libpng ----------
libpng() {
    fetch https://download.sourceforge.net/libpng/libpng-1.6.44.tar.xz || return
    run libpng libpng-1.6.44 ./configure --host=$T --prefix=/usr --disable-static
    run libpng libpng-1.6.44 make -j$NJ
    run libpng libpng-1.6.44 make DESTDIR="$STAGE" install
}

# ---------- libjpeg-turbo (cmake) ----------
libjpeg() {
    fetch https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/3.0.4/libjpeg-turbo-3.0.4.tar.gz || return
    cat > "$WORK/tc.cmake" <<EOF
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR riscv32)
set(CMAKE_C_COMPILER $TC/$T-gcc)
set(CMAKE_INSTALL_LIBDIR lib)
EOF
    ( cd "$WORK/libjpeg-turbo-3.0.4" &&
      cmake -B build -DCMAKE_TOOLCHAIN_FILE="$WORK/tc.cmake" \
        -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib -DENABLE_SHARED=1 -DWITH_SIMD=0 \
        -DCMAKE_BUILD_TYPE=Release >>"$LOG" 2>&1 &&
      cmake --build build -j$NJ >>"$LOG" 2>&1 &&
      DESTDIR="$STAGE" cmake --install build >>"$LOG" 2>&1 ) \
      && echo "PASS libjpeg" | tee -a "$LOG" || echo "FAIL libjpeg" | tee -a "$LOG"
}

# ---------- freetype ----------
freetype() {
    fetch https://download.savannah.gnu.org/releases/freetype/freetype-2.13.3.tar.xz || return
    run freetype freetype-2.13.3 ./configure --host=$T --prefix=/usr --disable-static \
        --with-zlib=yes --with-png=yes --with-bzip2=yes --with-brotli=no --with-harfbuzz=no
    run freetype freetype-2.13.3 make -j$NJ
    run freetype freetype-2.13.3 make DESTDIR="$STAGE" install
}

# ---------- libxml2 ----------
libxml2() {
    fetch https://download.gnome.org/sources/libxml2/2.13/libxml2-2.13.5.tar.xz || return
    run libxml2 libxml2-2.13.5 ./configure --host=$T --prefix=/usr --disable-static \
        --without-python --without-icu --with-zlib --with-lzma
    run libxml2 libxml2-2.13.5 make -j$NJ
    run libxml2 libxml2-2.13.5 make DESTDIR="$STAGE" install
}

# ---------- pkgconf ----------
pkgconf() {
    fetch https://distfiles.ariadne.space/pkgconf/pkgconf-2.3.0.tar.xz || return
    run pkgconf pkgconf-2.3.0 ./configure --host=$T --prefix=/usr --disable-static
    run pkgconf pkgconf-2.3.0 make -j$NJ
    run pkgconf pkgconf-2.3.0 make DESTDIR="$STAGE" install
    ln -sf pkgconf "$STAGE/usr/bin/pkg-config"
}

# ---------- m4 ----------
m4() {
    fetch https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz || return
    run m4 m4-1.4.19 ./configure --host=$T --prefix=/usr
    run m4 m4-1.4.19 make -j$NJ
    run m4 m4-1.4.19 make DESTDIR="$STAGE" install
}

# ---------- bison ----------
bison() {
    fetch https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.xz || return
    run bison bison-3.8.2 ./configure --host=$T --prefix=/usr
    run bison bison-3.8.2 make -j$NJ
    run bison bison-3.8.2 make DESTDIR="$STAGE" install
}

# ---------- flex ----------
flex() {
    fetch https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz || return
    run flex flex-2.6.4 ./configure --host=$T --prefix=/usr
    cp "$WORK/flex-2.6.4/src/scan.c" "$WORK/flex-2.6.4/src/stage1scan.c" 2>/dev/null || true
    run flex flex-2.6.4 make -j$NJ
    run flex flex-2.6.4 make DESTDIR="$STAGE" install
}

# ---------- nano ----------
nano() {
    fetch https://www.nano-editor.org/dist/v8/nano-8.2.tar.xz || return
    run nano nano-8.2 ./configure --host=$T --prefix=/usr --enable-utf8 \
        --disable-nls CURSES_LIB="-lncursesw"
    run nano nano-8.2 make -j$NJ
    run nano nano-8.2 make DESTDIR="$STAGE" install
}

zlib; bzip2; xz; zstd; ncurses; readline; expat; libffi; sqlite; openssl
libpng; libjpeg; freetype; libxml2
pkgconf; m4; bison; flex; nano

find "$STAGE" -name '*.la' -delete 2>/dev/null
find "$STAGE/usr/bin" "$STAGE/usr/lib" -type f -executable \
     -exec sh -c 'file "$1" 2>/dev/null | grep -q ELF && '"$T-strip"' --strip-unneeded "$1" 2>/dev/null' _ {} \; 2>/dev/null

echo "===== SUMMARY =====" | tee -a "$LOG"
grep -cE "^PASS" "$LOG" | xargs echo "passed:"
grep -E "^(FAIL|DLFAIL)" "$LOG" | tee -a "$LOG" || true

# merge into rootfs
cp -a "$STAGE"/. "$ROOTFS"/
echo "merged into $ROOTFS"
