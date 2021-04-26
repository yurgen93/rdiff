require "rdiff/version"
require "matrix"

module Rdiff
  class Error < StandardError; end

  def self.print_diff(io, c, x, y, i, j)
    return if i.zero? && j.zero?

    if i.zero?
      print_diff(io, c, x, y, i, j - 1)
      io.print("+ #{y[j - 1]}")
    elsif j.zero?
      print_diff(io, c, x, y, i - 1, j)
      io.print("- #{x[i - 1]}")
    elsif x[i - 1] == y[j - 1]
      print_diff(io, c, x, y, i - 1, j - 1)
      io.print("  #{x[i - 1]}")
    elsif c[i, j - 1] >= c[i - 1, j]
      print_diff(io, c, x, y, i, j - 1)
      io.print("+ #{y[j - 1]}")
    elsif c[i, j - 1] < c[i - 1, j]
      print_diff(io, c, x, y, i - 1, j)
      io.print("- #{x[i - 1]}")
    end
  end

  def self.lcs_length(x, y)
    Matrix.build(x.size + 1, y.size + 1) { 0 }.tap do |c|
      x.each.with_index(1) do |x_line, i|
        y.each.with_index(1) do |y_line, j|
          c[i, j] =
            if x_line == y_line
              1 + c[i - 1, j - 1]
            else
              [c[i, j - 1], c[i - 1, j]].max
            end
        end
      end
    end
  end

  def self.diff(x, y, stream = $stdout)
    c = lcs_length(x, y)
    print_diff(stream, c, x, y, x.size, y.size)
  end

  def self.cli
    if ARGV.size != 2
      puts "Usage: rdiff <file1> <file2>"
      exit(1)
    else
      diff(
        File.readlines(ARGV[0], mode: 'r'),
        File.readlines(ARGV[1], mode: 'r')
      )
    end
  end
end
