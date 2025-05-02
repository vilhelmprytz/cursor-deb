CURSOR_HASH := 0781e811de386a0c5bcb07ceb259df8ff8246a52
CURSOR_VERSION := 0.49.6
CURSOR_APPIMAGE_URL := https://downloads.cursor.com/production/${CURSOR_HASH}/linux/x64/Cursor-${CURSOR_VERSION}-x86_64.AppImage
CURSOR_ICON_URL := https://www.cursor.com/favicon.svg

.PHONY: all clean

all: cursor.deb

cursor.deb: build/.assets-downloaded
	dpkg-deb --build build cursor.deb

build/.assets-downloaded:
	mkdir -p build/DEBIAN
	mkdir -p build/usr/bin
	mkdir -p build/usr/share/applications
	mkdir -p build/usr/share/icons/hicolor/256x256/apps
	mkdir -p build/usr/share/cursor
	mkdir -p build/usr/share/doc/cursor
	mkdir -p build/etc/default

	# Download AppImage
	wget -O build/usr/share/cursor/cursor.AppImage $(CURSOR_APPIMAGE_URL)
	chmod +x build/usr/share/cursor/cursor.AppImage

	# Download icon
	wget -O build/usr/share/icons/hicolor/256x256/apps/cursor.png $(CURSOR_ICON_URL)

	# Copy desktop entry
	cp debian/cursor.desktop build/usr/share/applications/cursor.desktop

	# Copy wrapper script for cursor command
	cp debian/cursor-wrapper build/usr/bin/cursor
	chmod +x build/usr/bin/cursor

	# Copy default configuration file template
	cp debian/cursor-default build/etc/default/cursor

	# Copy control file
	cp debian/control build/DEBIAN/control

	# Copy and compress changelog file
	gzip -9c debian/changelog > build/usr/share/doc/cursor/changelog.Debian.gz

	touch build/.assets-downloaded

clean:
	rm -rf build/
	rm -f cursor.deb
