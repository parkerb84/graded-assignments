#Implement all parts of this assignment within (this) module2_assignment2.rb file
class LineAnalyzer
  attr_accessor :highest_wf_count, :highest_wf_words, :content, :line_number
  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    self.calculate_word_frequency(content)
  end

  def calculate_word_frequency(content)
    word_freq = Hash.new(0)
    content.split.each {|word| word_freq[word.downcase] += 1}
    @highest_wf_count = word_freq.values.max
    @highest_wf_words = word_freq.select{|key, value| value == @highest_wf_count}.keys
  end
end

#  Implement a class called Solution. 
class Solution
  attr_accessor :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize()
    @analyzers = []
  end

  def analyze_file()
    lines = File.foreach('test.txt')
    lines.each_with_index {|line, index| @analyzers << LineAnalyzer.new(line, index)}
  end

  def calculate_line_with_highest_frequency()
    @highest_count_words_across_lines = []
    @highest_count_across_lines = 0
    @analyzers.each do |la|
      if la.highest_wf_count > @highest_count_across_lines
        @highest_count_across_lines = la.highest_wf_count
      end
    end
    @analyzers.select do |la|
      if la.highest_wf_count == @highest_count_across_lines
        @highest_count_words_across_lines << la
      end
    end
  end

  def print_highest_word_frequency_across_lines()
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each{|l| puts "#{l.highest_wf_words} (appears in line #{l.line_number})"}
  end
end