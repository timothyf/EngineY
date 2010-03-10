require 'test_helper'

class StateTest < ActiveSupport::TestCase


  def test_get_state_list
    State.init_states
    list = State.list
    assert list.length == 60, 'Incorrect state list length'
  end
  
  
  def test_verify_2_digit_state_codes
    State.init_states
    list = State.list
    list.each do |state|
      assert state[1].size == 2, 'Incorrect state code length' 
    end
  end
  
  
end
