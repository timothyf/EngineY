require 'test_helper'

class ClassifiedTest < ActiveSupport::TestCase


  def test_title_validation
    assert classifieds(:one).valid? == true, 'Expected valid classified' 
    classifieds(:one).title = nil
    assert classifieds(:one).valid? == false, "Expected invalid classified" 
  end
  

  def test_user_id_validation
    assert classifieds(:one).valid? == true, 'Expected valid classified' 
    classifieds(:one).user_id = nil
    assert classifieds(:one).valid? == false, "Expected invalid classified" 
  end
  
end
