# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper 
  #Here is where I map controllers to corresponding tabs
  def active_tab(controller)
    hash = {:forum_topics         => :forum,
            :forum_posts          => :forum,
            :forum_categories     => :forum,
            :members              => :home,
            :welcome              => :home,
            :newsletters          => :news,
            :product_requests     => :requests,
            :wholesale_orders     => :wholesale_orders,
            :volunteer_tasks      => :volunteer,
            :barter_board_entries => :barter_board,
            :barter_board_categories => :barter_board} 
    return hash[ controller.to_sym ]
  end
  
  #Helper method for creating a whole set of tabs
  def create_tabs(active, hash)
    string = "<ul id='tabs'> \n"
    hash.each do |key, href|
      string += key == active ? create_tab(key, href, :active => true) : 
                                create_tab(key, href)
      string += "\n"
    end
    string += "</ul>"
  end
  
  #Helper method for creating a single tab
  def create_tab(id, href, options = {} )
    string = "<li><a href='#{href}' id='#{id}' "
    string += "class='active'" if options[:active]
    display = options[:display] || 
              (id.to_s.split("_").each {|seg| seg.capitalize}).join(" ")
    string += ">#{display}</a></li>"
  end
  
  # This builds a groovy looking table with alternatingly colored rows. 
  # Pass in a hash with keys either strings or arrays which will flush out 
  # category_rows with the appropriate info (single category display for string,
  # whole row of stuff with the first thing the category if an array)
  # The keys should map to arrays of arrays which will flush out the rest of the 
  # data with rows that alternate between classes 'row0' and 'row1'. Category
  # rows have class 'category_row'. Style as desired.
  def groovy_table(hash ={})
    string = ""
    array = hash.values.map do |subarr|
      (subarr.map {|subsubarr| subsubarr.length}).max
    end
    array = array.select {|n| !n.nil?}
    max_columns = array.max
    hash.each do |key, value|
      case key
      when String
        string += "<tr class='category_row'>
          <td><h3>#{key}</h3></td>
          #{'<td></td>'*(max_columns - 1)}
          </tr>\n"
      when Array
        string += "<tr class='category_row'>
              <td><h3>#{key.first}</h3></td>\n"
        value[(1...key.length)].each {|item| string += "<td>#{item}</td>\n"}
        (value.length - key.length).times { string += "<td></td>\n"}
      else
        Raise "There is a problem in yo table building!!"
      end
      i = 0
      value.each do |row|
        string += "<tr class='row#{i.modulo 2}'>\n"
        puts row.size
        row.each do |item|
          string += "<td>#{item}</td>\n"
        end
      	string += "</tr>\n"
        i += 1
      end
    end
    return string
  end
end
