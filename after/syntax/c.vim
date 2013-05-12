" source glib and friends highlighing, when requested

if exists("glib_deprecated_errors")
  runtime! syntax/glib.vim
endif

if exists("gobject_deprecated_errors")
  runtime! syntax/gobject.vim
endif

if exists("gdk_deprecated_errors")
  runtime! syntax/gdk.vim
endif

if exists("gdkpixbuf_deprecated_errors")
  runtime! syntax/gdkpixbuf.vim
endif

if exists("gtk_deprecated_errors")
  runtime! syntax/gtk.vim
endif

if exists("gimp_deprecated_errors")
  runtime! syntax/gimp.vim
endif

" vim: set ft=vim :
