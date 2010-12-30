User.find(:all).each do |user|
  if user.plugins.find_by_name('<%= class_name.pluralize.underscore.downcase %>').nil?
    user.plugins.create(:name => '<%= class_name.pluralize.underscore.downcase %>',
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end

page = Page.create(
  :title => '<%= class_name.pluralize.underscore.titleize %>',
  :link_url => '/<%= plural_name %>',
  :deletable => false,
  :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
  :menu_match => '^/<%= plural_name %>(\/|\/.+?|)$'
)
Page.default_parts.each do |default_page_part|
  page.parts.create(:title => default_page_part, :body => nil)
end
