# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper 
  #Here we map controllers to corresponding tabs
  def active_tab(controller)
    hash = {:forum_topics         => :forum,
            :forum_posts          => :forum,
            :forum_categories     => :forum,
            :members              => :home,
            :welcome              => :home,
            :faqs                 => :home,
            :board_members        => :home,
            :content_items        => :home,
            :newsletters          => :news,
            :product_requests     => :requests,
            :wholesale_orders     => :wholesale_orders,
            :volunteer_tasks      => :volunteer,
            :volunteer_offers     => :volunteer,
            :barter_board_entries => :barter_board,
            :barter_board_categories => :barter_board} 
    # Shouldn't have to do these conditionals, but we had errors in the tests evaluating controller to nil. Hmm...
    return hash[ controller.to_sym ] unless controller.nil?
    return :home
  end
  
  # This is a groovy little method which sorts a collection based on a given attribute (or method chain return). Should put this one in a little reusable helper gem or something.
  def sort(collection, attribute)
    collection.sort {|a,b| a.send(attribute) <=> b.send(attribute)}
  end
  
  # Cleans things up just a little bit with respect to displaying content items
  def display_content(content_item)
    html = display_textile(content_item.content)
    if admin?
      html += "<p>#{link_to("Edit Content", edit_content_item_path(content_item))}</p> " 
    end
    return html
  end
  
  # Cleaner way to diplay textile content
  def display_textile(text)
    RedCloth.new(text).to_html
  end
  
  # Helper method for creating a whole set of tabs
  def create_tabs(active, *tabs)
    string = "<ul id='tabs'> \n"
    tabs.each do |tab|
      string += tab.first == active ? create_tab(tab.first, tab.last, :active => true) : 
                                create_tab(tab.first, tab.last)
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
  
  # Returns the first subscription between a given member and subscribable object. 
  # Should put something in place so that only one such object can exist.
  # Wrote this join differently than the other similar one for volunteer 
  # offerings - should consider making them the same.
  def subscription(member, subscribed_object)
    case subscribed_object
    when ForumCategory
      collection = member.forum_category_subscriptions
      collection = collection.select {|sub| sub.forum_category_id == subscribed_object.id}
    when ForumTopic
      collection = member.forum_topic_subscriptions
      collection = collection.select {|sub| sub.forum_topic_id == subscribed_object.id}
    else
      Raise "Inapropriate object class sent to subscription method"
    end
    return collection.first
  end
  
  #These are methods that make inclusion of javascript and stylesheet files easier
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end
  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end
end
