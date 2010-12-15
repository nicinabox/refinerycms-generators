class Admin::<%= class_name.pluralize %>Controller < Admin::BaseController

  crudify :<%= singular_name %><% if (title = attributes.detect { |a| a.type.to_s == "string" }).present? and title.name != 'title' %>,
          :title_attribute => '<%= title.name %>'<% end %><% if plural_name == singular_name %>,
          :redirect_to_url => :admin_<%= singular_name %>_index_url                    
<% end %>

end
