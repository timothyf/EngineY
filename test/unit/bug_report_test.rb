require 'test_helper'

class BugReportTest < ActiveSupport::TestCase

  def test_title_validation
    assert bug_reports(:one).valid? == true, 'Expected valid bug' 
    assert bug_reports(:invalid_title).valid? == false, "Expected invalid bug" 
    bug_reports(:one).title = nil
    assert bug_reports(:one).valid? == false, "Expected invalid bug" 
  end
  
  
  def test_description_validation
    assert bug_reports(:one).valid? == true, 'Expected valid bug' 
    assert bug_reports(:invalid_desc).valid? == false, "Expected invalid bug" 
    bug_reports(:one).description = nil
    assert bug_reports(:one).valid? == false, "Expected invalid bug" 
  end
  
  
end
