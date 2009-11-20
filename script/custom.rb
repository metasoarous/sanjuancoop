module ScriptMethods
  def switch_space_for_tabs(filename)
    text = File.read(filename)
    text.gsub!(" ", "\t")
    f = File.new(filename, "w")
    f.puts text
    f.close
  end
  
  def clean_and_read_file(file_name)
    text = File.read(file_name)
    ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
    valid_string = ic.iconv(text << ' ')[0..-2]
  end
  
  def add_memberships_from_tsv(file_name)
    puts "starting method"
    text = clean_and_read_file(file_name)
    text.lines.each do |line|
      params = {}
      params[:first_name], params[:last_name], params[:email] = line.split("\t")
      unless params[:email].nil?
        if params[:email].empty? or params[:email] == "?"
          params[:email] = nil
        else
          params[:accepts_newsletters] = true
        end
      end        
      member = Membership.new(params)
      unless member.save
        member.errors.each do |error, message|
          puts "Error message for #{member.first_name}, #{member.last_name} - #{error} - #{message}"
          puts member.email
        end
      end
    end
  end
  
  def destructive_membership_import
    Membership.all.each {|m| m.destroy}
    add_memberships_from_tsv "current co-op emails 11_09.txt"
    add_memberships_from_tsv "new co-op emails 7_09.txt"
    puts "There are now #{Membership.all.size} members in the coop"
  end
end

