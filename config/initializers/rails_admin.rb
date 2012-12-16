# RailsAdmin config file. Generated on December 17, 2012 01:21
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Colights', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_admin } # auto-generated
  config.authenticate_with do
    warden.authenticate! :scope => :admin
  end
  config.authorize_with :cancan

  # If you want to track changes on your models:
  # config.audit_with :history, 'Admin'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'Admin'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  # config.excluded_models = ['Admin', 'Match', 'Movie', 'Thumbnail', 'User', 'Video']

  # Include specific models (exclude the others):
  config.included_models = ['Movie', 'Thumbnail', 'User', 'Video']

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]
  config.label_methods << :email
  config.label_methods << :title

  config.actions do
    # root actions
    dashboard                     # mandatory
    # collection actions
    index                         # mandatory
    new do
      only User
    end
    export
    # history_index
    bulk_delete
    # member actions
    show
    edit
    delete
    # history_show
    show_in_app
  end


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block

  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.


  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:

  ###  Movie  ###

  config.model 'Movie' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your movie.rb model definition

  #   # Found associations:

      configure :videos, :has_many_association

  #   # Found columns:

      configure :_type, :text         # Hidden
      configure :_id, :bson_object_id
      configure :title, :string
      configure :year, :integer
      configure :gross, :integer
      configure :studio, :text

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

      list do
        field :title
        field :year
        field :gross
        field :studio
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
      end
      show do
        field :title
        field :year
        field :gross
        field :studio
      end
      edit do; end
      export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  end


  ###  Thumbnail  ###

  config.model 'Thumbnail' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your thumbnail.rb model definition

  #   # Found associations:

      configure :video, :belongs_to_association

  #   # Found columns:

      configure :_type, :text         # Hidden
      configure :_id, :bson_object_id
      configure :thumbnail_uid, :string         # Hidden
      configure :thumbnail, :dragonfly
      configure :name, :string
      configure :video_id, :bson_object_id         # Hidden

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

      list do
        field :name
        field :thumbnail
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
      end
      show do
        field :name
        field :thumbnail
      end
      edit do; end
      export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  end


  ###  User  ###

  config.model 'User' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your user.rb model definition

  #   # Found associations:



  #   # Found columns:

      configure :_type, :text         # Hidden
      configure :_id, :bson_object_id
      configure :email, :text
      configure :password, :password         # Hidden
      configure :password_confirmation, :password         # Hidden
      configure :reset_password_token, :text         # Hidden
      configure :reset_password_sent_at, :datetime
      configure :remember_created_at, :datetime
      configure :sign_in_count, :integer
      configure :current_sign_in_at, :datetime
      configure :last_sign_in_at, :datetime
      configure :current_sign_in_ip, :text
      configure :last_sign_in_ip, :text

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

      list do
        field :email
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
      end
      show do
        field :email
      end
      edit do; end
      export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  end


  ###  Video  ###

  # config.model 'Video' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your video.rb model definition

  #   # Found associations:

  #     configure :match, :belongs_to_association
  #     configure :movie, :belongs_to_association
  #     configure :thumbnails, :has_many_association

  #   # Found columns:

  #     configure :_type, :text         # Hidden
  #     configure :_id, :bson_object_id
  #     configure :title, :string
  #     configure :unique_id, :text
  #     configure :description, :text
  #     configure :uploaded_at, :date
  #     configure :view_count, :integer
  #     configure :match_id, :bson_object_id         # Hidden
  #     configure :movie_id, :bson_object_id         # Hidden
  #     configure :_keywords, :serialized

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end

end
