{% if flag?(:static) %}
  @[Link(ldflags: "`pkg-config libarchive --libs --static`")]
{% else %}
  @[Link(ldflags: "`pkg-config libarchive --libs`")]
{% end %}
lib LibArchive
  type Archive = Void*
  type ArchiveEntry = Void*

  # https://github.com/libarchive/libarchive/blob/819a50a0436531276e388fc97eb0b1b61d2134a3/libarchive/archive.h#L190
  enum Status
    EOF    =   1
    OK     =   0
    RETRY  = -10
    WARN   = -20
    FAILED = -25
    FATAL  = -30
  end

  fun archive_read_new : Archive
  fun archive_read_free(a : Archive) : Status
  fun archive_read_support_filter_all(a : Archive) : Status
  fun archive_read_support_format_all(a : Archive) : Status
  fun archive_read_open_filename(a : Archive, filename : LibC::Char*, block_size : LibC::SizeT) : Status
  fun archive_read_next_header(a : Archive, entry : ArchiveEntry*) : Status
  fun archive_read_data(a : Archive, buffer : Void*, size : LibC::SizeT) : LibC::SSizeT
  fun archive_read_data_skip(a : Archive) : Status

  fun archive_error_string(a : Archive) : LibC::Char*

  fun archive_entry_pathname_utf8(e : ArchiveEntry) : LibC::Char*
  fun archive_entry_size(e : ArchiveEntry) : LibC::SizeT
  fun archive_entry_stat(e : ArchiveEntry) : LibC::Stat*
end
