require 'test_helper'

class RoleTest < ActiveSupport::TestCase


  def test_get_creator
    role = Role.creator
    assert role.rolename == 'creator', 'Incorrect role name'
    assert role.id == 1
  end
  
  
  def test_get_admin
    role = Role.admin
    assert role.rolename == 'administrator', 'Incorrect role name'
    assert role.id == 2
  end
  
  
end
