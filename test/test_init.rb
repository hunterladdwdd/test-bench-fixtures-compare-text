require_relative '../init'

require 'test_bench'; TestBench.activate

require 'test_bench/fixtures/compare_text/controls'

include TestBench::Fixtures

Controls = CompareText::Controls
