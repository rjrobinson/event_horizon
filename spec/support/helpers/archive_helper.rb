require "zlib"
require "rubygems/package"

module ArchiveHelper
  def read_file_from_gzipped_archive(archive_path, filename)
    Zlib::GzipReader.open(archive_path) do |gz|
      contents = nil

      Gem::Package::TarReader.new(gz) do |tar|
        contents = tar.seek(filename) { |f| f.read }
      end

      contents
    end
  end
end
