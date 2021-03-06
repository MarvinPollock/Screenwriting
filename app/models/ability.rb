class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role?("admin")
      can :manage, :all
    else
      define_project_access(user)
      define_group_access(user)
      define_user_access(user)
      define_pad_access(user)
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
  def define_project_access(user)
      can :manage, Project do |project|
        if @group = project.group
          @canManage = @group.users(true).exists?(user)
        end
      end
      unless @canManage
        can [:new, :show, :create], Project

      end
    end
    
    def define_group_access(user)
      unless user.groups.empty?
        can :manage, Group do |group|
          @canManage = group.users.exists?(user)
        end
        unless @canManage
          can :new, Group
          can :create, Group
          can :index, Group
        end
      else
        can :new, Group
        can :create, Group
        can :index, Group
      end
    end
    
    def define_user_access(user)
      can :manage, User do |u|
        user.equals(u) 
      end
    end
    
    def define_pad_access(user)
      can :manage, Pad do |p|
        if @project = p.project
          if @group = @project.group
            @group.users.exists?(user)
          end
        end
      end
      unless @canManage
        can [:new, :show, :create], Pad

      end
    end
end
