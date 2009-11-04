module ScriptNest
  def self.switch_space_for_tabs(filename)
    text = File.read(filename)
    text.gsub!(" ", "\t")
    f = File.new(filename, "w")
    f.puts text
    f.close
  end
end