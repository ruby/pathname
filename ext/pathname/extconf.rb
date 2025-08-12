# frozen_string_literal: false

require 'mkmf'

if RUBY_ENGINE == "ruby"
  create_makefile('pathname')
else
  File.write("Makefile", dummy_makefile($srcdir).join(""))
end
