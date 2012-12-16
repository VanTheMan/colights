class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :access, :rails_admin
      can :dashboard
      can :manage, :all

      cannot [:create], [Video, Match, Thumbnail]

      # For all Models we have, forbid create and update
      # but dont forbid :manage, in order to keep it in
      # navigation if not excluded by rails_admin config
      # ActiveRecord::Base.descendants.each do |m|
      #   cannot [:create, :update], m unless request_model == m.name.underscore
      # end if request_model

      # a manual way can look like this :
      # cannot [:create, :update], Author if request_model == "books"
      # cannot [:create, :update], Book   if request_model == "author"

    else
      cannot :access, :rails_admin
    end
  end
end
