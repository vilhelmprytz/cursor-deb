CURSOR_VERSION := 0.47.8-82ef0f61c01d079d1b7e5ab04d88499d5af500e3
CURSOR_APPIMAGE_URL := https://downloads.cursor.com/production/client/linux/x64/appimage/Cursor-$(CURSOR_VERSION).deb.glibc2.25-x86_64.AppImage
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

	# Download AppImage
	wget -O build/usr/share/cursor/cursor.AppImage $(CURSOR_APPIMAGE_URL)
	chmod +x build/usr/share/cursor/cursor.AppImage

	# Download icon
	wget -O build/usr/share/icons/hicolor/256x256/apps/cursor.png $(CURSOR_ICON_URL)

	# Copy desktop entry
	cp debian/cursor.desktop build/usr/share/applications/cursor.desktop

	# Create symlink for cursor command
	ln -sf /usr/share/cursor/cursor.AppImage build/usr/bin/cursor

	# Copy control file
	cp debian/control build/DEBIAN/control

	touch build/.assets-downloaded

clean:
	rm -rf build/
	rm -f cursor.deb
