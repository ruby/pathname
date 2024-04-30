# frozen_string_literal: true
require "test/unit"
require "pathname"

class TestPathnameRactor < Test::Unit::TestCase
  if respond_to?(:ractor)
    ractor
    def test_shareable
      r = Ractor.new Pathname("a") do |x|
        x.join(Pathname("b"), Pathname("c"))
      end
      assert_equal(Pathname("a/b/c"), r.take)
    end
  end
end

