require 'test_helper'

class ClassifiedCategoryTest < ActiveSupport::TestCase


  def test_name_validation
    assert classified_categories(:one).valid? == true, 'Expected valid classified category' 
    classified_categories(:one).name = nil
    assert classified_categories(:one).valid? == false, "Expected invalid classified category" 
  end


end
