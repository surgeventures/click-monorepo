# frozen_string_literal: true

require "dotenv"
require "minitest/autorun"
require "minitest/reporters"
require "require_all"

$VERBOSE = false
Dotenv.load
MiniTest::Reporters.use!
Minitest::Reporters.use! [
  Minitest::Reporters::HtmlReporter.new,
  Minitest::Reporters::JUnitReporter.new,
  Minitest::Reporters::SpecReporter.new
]

require_all "lib"
