begin
  verbose, $VERBOSE = $VERBOSE, nil
  require "pathname"
ensure
  $VERBOSE = verbose
end

require "test/unit"
require "core_assertions"

Test::Unit::TestCase.include Test::Unit::CoreAssertions
