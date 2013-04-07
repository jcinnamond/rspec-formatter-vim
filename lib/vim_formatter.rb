require 'rspec/core/formatters/base_formatter'

class VimFormatter < RSpec::Core::Formatters::BaseFormatter
  def example_failed(example)
    super
    metadata = [
      "F",
      example.metadata[:file_path],
      example.metadata[:line_number],
      example.metadata[:full_description],
    ].join(":")
    output.puts "#{metadata}\n#{example.execution_result[:exception].message.strip}"
  end

  def dump_summary(duration, example_count, failure_count, pending_count)
    if failure_count == 0 && pending_count == 0
      output.puts "All tests passed"
    end
  end
end
