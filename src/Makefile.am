NULL =
LDADD =
MAINTAINERCLEANFILES =
bin_PROGRAMS =

noinst_LTLIBRARIES = libvirt-viewer-util.la libvirt-viewer.la

noinst_DATA = \
	resources/ui/virt-viewer.ui \
	resources/ui/virt-viewer-about.ui \
	resources/ui/virt-viewer-auth.ui \
	resources/ui/virt-viewer-guest-details.ui \
	resources/ui/virt-viewer-vm-connection.ui \
	resources/ui/virt-viewer-preferences.ui \
	resources/ui/remote-viewer-connect.ui \
	resources/ui/remote-viewer-iso-list.ui \
	resources/ui/virt-viewer-file-transfer-dialog.ui \
	$(NULL)

EXTRA_DIST =					\
	$(noinst_DATA)					\
	virt-viewer-enums.c.etemplate		\
	virt-viewer-enums.h.etemplate		\
	resources/virt-viewer.gresource.xml	\
	$(NULL)

ENUMS_FILES =					\
	virt-viewer-display.h			\
	$(NULL)

BUILT_SOURCES =					\
	virt-viewer-resources.h			\
	virt-viewer-resources.c			\
	virt-viewer-enums.h			\
	virt-viewer-enums.c			\
	$(NULL)

virt-viewer-resources.c virt-viewer-resources.h: resources/virt-viewer.gresource.xml Makefile $(shell $(GLIB_COMPILE_RESOURCES) --generate-dependencies --sourcedir=$(srcdir)/resources $(srcdir)/resources/virt-viewer.gresource.xml)
	$(AM_V_GEN) $(GLIB_COMPILE_RESOURCES) --target=$@ --sourcedir=$(srcdir)/resources --generate --c-name virt_viewer $<

virt-viewer-enums.c virt-viewer-enums.h: %: %.etemplate $(ENUMS_FILES)
	$(AM_V_GEN)LC_ALL= LANG=C LC_CTYPE=en_US.UTF-8 $(GLIB_MKENUMS) --template $^ | \
            sed -e 's/VIRT_TYPE_VIEWER/VIRT_VIEWER_TYPE/' \
                -e 's,#include "$(srcdir)/,#include ",' > $@

CLEANFILES = \
	$(BUILT_SOURCES)				\
	$(NULL)

libvirt_viewer_util_la_SOURCES = \
	virt-viewer-util.h \
	virt-viewer-util.c \
	$(NULL)

libvirt_viewer_la_SOURCES =					\
	$(BUILT_SOURCES)				\
	glib-compat.h					\
	glib-compat.c					\
	virt-viewer-auth.h				\
	virt-viewer-auth.c				\
	virt-viewer-app.h				\
	virt-viewer-app.c				\
	virt-viewer-file.h				\
	virt-viewer-file.c				\
	virt-viewer-session.h				\
	virt-viewer-session.c				\
	virt-viewer-display.h				\
	virt-viewer-display.c				\
	virt-viewer-notebook.h				\
	virt-viewer-notebook.c				\
	virt-viewer-window.h				\
	virt-viewer-window.c				\
	virt-viewer-vm-connection.h			\
	virt-viewer-vm-connection.c			\
	virt-viewer-display-vte.h			\
	virt-viewer-display-vte.c			\
	virt-viewer-timed-revealer.c \
	virt-viewer-timed-revealer.h \
	$(NULL)

if HAVE_GTK_VNC
libvirt_viewer_la_SOURCES += \
	virt-viewer-session-vnc.h \
	virt-viewer-session-vnc.c \
	virt-viewer-display-vnc.h \
	virt-viewer-display-vnc.c \
	$(NULL)
endif

if HAVE_SPICE_GTK
libvirt_viewer_la_SOURCES += \
	virt-viewer-session-spice.h \
	virt-viewer-session-spice.c \
	virt-viewer-display-spice.h \
	virt-viewer-display-spice.c \
	virt-viewer-file-transfer-dialog.h \
	virt-viewer-file-transfer-dialog.c \
	$(NULL)
endif

if HAVE_OVIRT
libvirt_viewer_la_SOURCES += \
	ovirt-foreign-menu.h \
	ovirt-foreign-menu.c \
	remote-viewer-iso-list-dialog.c \
	remote-viewer-iso-list-dialog.h \
	$(NULL)
endif

COMMON_LIBS = \
	-lm					\
	$(GLIB2_LIBS)				\
	$(GTK_LIBS)				\
	$(GTK_VNC_LIBS)				\
	$(VTE_LIBS)				\
	$(SPICE_GTK_LIBS)			\
	$(LIBXML2_LIBS)				\
	$(OVIRT_LIBS) \
	$(NULL)

COMMON_CFLAGS = \
	-DLOCALE_DIR=\""$(datadir)/locale"\" \
	-DG_LOG_DOMAIN=\"virt-viewer\" \
	$(GLIB2_CFLAGS) \
	$(GTK_CFLAGS) \
	$(GTK_VNC_CFLAGS) \
	$(VTE_CFLAGS) \
	$(SPICE_GTK_CFLAGS) \
	$(LIBXML2_CFLAGS) \
	$(OVIRT_CFLAGS) \
	$(WARN_CFLAGS) \
	$(NULL)

if OS_WIN32
# binutils does not take into account entry point when
# -pie is used so we need to provide it manually
# ENTRY_PREFIX is empty for x86_64, underscore ("_") otherwise
ENTRY_PREFIX := $(if $(filter x86_64,$(host_cpu)),,_)

# --dynamicbase to enable ASLR protection
# --nxcompat is to enable NX protection
# -pie as --dynamicbase requires relocations
LDFLAGS_SECURITY_COMMON = -Wl,--dynamicbase,-pie,--nxcompat
LDFLAGS_SECURITY_GUI = $(LDFLAGS_SECURITY_COMMON) -Wl,-e,$(ENTRY_PREFIX)WinMainCRTStartup -mwindows
LDFLAGS_SECURITY_CUI = $(LDFLAGS_SECURITY_COMMON) -Wl,-e,$(ENTRY_PREFIX)mainCRTStartup -mconsole
endif

libvirt_viewer_util_la_LIBADD = \
	$(GLIB2_LIBS) \
	$(GTK_LIBS) \
	$(LIBXML2_LIBS) \
	$(NULL)

libvirt_viewer_util_la_CFLAGS = \
	-DLOCALE_DIR=\""$(datadir)/locale"\" \
	$(GLIB2_CFLAGS) \
	$(GTK_CFLAGS) \
	$(LIBXML2_CFLAGS) \
	$(NULL)

libvirt_viewer_la_LIBADD = \
	$(COMMON_LIBS) \
	$(NULL)

libvirt_viewer_la_CFLAGS = \
	$(COMMON_CFLAGS) \
	$(NULL)

if HAVE_LIBVIRT
bin_PROGRAMS += virt-viewer
virt_viewer_SOURCES =					\
	virt-viewer.h					\
	virt-viewer.c					\
	virt-viewer-main.c				\
	$(NULL)
virt_viewer_LDFLAGS =				\
	$(COMMON_LIBS)				\
	$(LIBVIRT_LIBS)				\
	$(NULL)
virt_viewer_CFLAGS = 				\
	$(COMMON_CFLAGS) 			\
	$(LIBVIRT_CFLAGS)			\
	$(NULL)
virt_viewer_LDADD = \
	libvirt-viewer-util.la \
	libvirt-viewer.la \
	$(NULL)
if OS_WIN32
virt_viewer_LDFLAGS += $(LDFLAGS_SECURITY_GUI)
endif
endif


bin_PROGRAMS += remote-viewer
remote_viewer_SOURCES =				\
	remote-viewer.h				\
	remote-viewer.c				\
	remote-viewer-connect.c 		\
	remote-viewer-connect.h 		\
	remote-viewer-main.c			\
	$(NULL)
remote_viewer_LDFLAGS =				\
	$(COMMON_LIBS)				\
	$(NULL)
remote_viewer_CFLAGS =				\
	$(COMMON_CFLAGS) 			\
	$(NULL)
remote_viewer_LDADD = \
	libvirt-viewer-util.la \
	libvirt-viewer.la \
	$(NULL)

if OS_WIN32
remote_viewer_LDFLAGS += $(LDFLAGS_SECURITY_GUI)
endif

VIRT_VIEWER_RES = virt-viewer.rc virt-viewer.manifest
ICONDIR = $(top_builddir)/icons
MANIFESTDIR = $(srcdir)
EXTRA_DIST += $(VIRT_VIEWER_RES)

if OS_WIN32
bin_PROGRAMS += windows-cmdline-wrapper
windows_cmdline_wrapper_SOURCES = windows-cmdline-wrapper.c
windows_cmdline_wrapper_LDFLAGS = -lpsapi $(LDFLAGS_SECURITY_CUI)

virt-viewer_rc.$(OBJEXT): $(VIRT_VIEWER_RES) $(ICONDIR)/virt-viewer.ico
	$(AM_V_GEN)$(WINDRES)				\
		-DICONDIR='\"$(ICONDIR)\"'		\
		-DMANIFESTDIR='\"$(MANIFESTDIR)\"'	\
		-i $< -o $@
LDADD += virt-viewer_rc.$(OBJEXT)
MAINTAINERCLEANFILES += virt-viewer_rc.$(OBJEXT)
endif

-include $(top_srcdir)/git.mk
