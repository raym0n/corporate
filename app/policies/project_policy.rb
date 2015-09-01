class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if user.administrator?
      return scope.all if user.manager?
      return scope.for_worker(user) if user.worker?
      scope.none
    end
  end

  def index?
    ! user.guest?
  end

  def show?
    create?
  end

  def create?
    return true if user.administrator?
    return true if user.manager?
    false
  end

  def update?
    create?
  end

  def status?
    return true if user.administrator?
    return true if user.manager?
    false
  end

  def permitted_attributes
    [:title, :cost, :responsible_user_id, :contractor_id]
  end

  def readable_attributes
    attrs = [:id, :title, :responsible_user, :status, :updated_at, :created_at]
    attrs.push :cost if user.administrator? || user.manager?
    attrs
  end
end
