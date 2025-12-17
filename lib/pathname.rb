# frozen_string_literal: true
#
# = pathname.rb
#
# Object-Oriented Pathname Class
#
# Author:: Tanaka Akira <akr@m17n.org>
# Documentation:: Author and Gavin Sinclair
#
# For documentation, see class Pathname.
#

if defined?(::Pathname) # Clear builtin Pathname
  # :stopdoc:
  class ::Object
    remove_const :Pathname
  end

  # Remove module_function Pathname
  class << ::Kernel
    undef Pathname
  end
  module ::Kernel
    undef Pathname
  end

  $".delete('pathname.so')
  # :startdoc:
end

require 'pathname.so' if RUBY_ENGINE == 'ruby'

require_relative 'pathname_builtin'

class Pathname    # * Find *
  #
  # Iterates over the directory tree in a depth first manner, yielding a
  # Pathname for each file under "this" directory.
  #
  # Returns an Enumerator if no block is given.
  #
  # Since it is implemented by the standard library module Find, Find.prune can
  # be used to control the traversal.
  #
  # If +self+ is +.+, yielded pathnames begin with a filename in the
  # current directory, not +./+.
  #
  # See Find.find
  #
  def find(ignore_error: true) # :yield: pathname
    return to_enum(__method__, ignore_error: ignore_error) unless block_given?
    require 'find'
    if @path == '.'
      Find.find(@path, ignore_error: ignore_error) {|f| yield self.class.new(f.delete_prefix('./')) }
    else
      Find.find(@path, ignore_error: ignore_error) {|f| yield self.class.new(f) }
    end
  end
end


class Pathname    # * FileUtils *
  # See <tt>FileUtils.mkdir_p</tt>.
  def mkdir_p(...) require 'fileutils' ; FileUtils.mkdir_p(self, ...) end

  # See <tt>FileUtils.ln</tt>.
  def ln(...) require 'fileutils' ; FileUtils.ln(self, ...) end

  # See <tt>FileUtils.ln_s</tt>.
  def ln_s(...) require 'fileutils' ; FileUtils.ln_s(self, ...) end

  # See <tt>FileUtils.ln_sf</tt>.
  def ln_sf(...) require 'fileutils' ; FileUtils.ln_sf(self, ...) end

  # See <tt>FileUtils.cp</tt>.
  def cp(...) require 'fileutils' ; FileUtils.cp(self, ...) end

  # See <tt>FileUtils.cp_r</tt>.
  def cp_r(...) require 'fileutils' ; FileUtils.cp_r(self, ...) end

  # See <tt>FileUtils.mv</tt>.
  def mv(...) require 'fileutils' ; FileUtils.mv(self, ...) end

  # See <tt>FileUtils.rm</tt>.
  def rm(...) require 'fileutils' ; FileUtils.rm(self, ...) end

  # See <tt>FileUtils.rm_r</tt>.
  def rm_r(...) require 'fileutils' ; FileUtils.rm_r(self, ...) end

  # See <tt>FileUtils.rm_rf</tt>.
  def rm_rf(...) require 'fileutils' ; FileUtils.rm_rf(self, ...) end
  alias rmtree rm_rf
end

class Pathname    # * tmpdir *
  # Creates a tmp directory and wraps the returned path in a Pathname object.
  #
  # See Dir.mktmpdir
  def self.mktmpdir
    require 'tmpdir' unless defined?(Dir.mktmpdir)
    if block_given?
      Dir.mktmpdir do |dir|
        dir = self.new(dir)
        yield dir
      end
    else
      self.new(Dir.mktmpdir)
    end
  end
end
