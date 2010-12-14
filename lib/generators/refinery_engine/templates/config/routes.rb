Refinery::Application.routes.draw do
  resources :<%= class_name.pluralize.underscore.downcase %>, :only => [:index, :show]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :<%= class_name.pluralize.underscore.downcase %>, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end
