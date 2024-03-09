require_relative '../init'

require 'test_bench/isolated'; TestBenchIsolated::TestBench.activate

require 'TEMPLATE-PATH/controls'

include TestBench

Controls = TEMPLATE-NAMESPACE::Controls rescue nil
