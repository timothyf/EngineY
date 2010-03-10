require 'test_helper'

class InviteTest < ActiveSupport::TestCase


  def test_generate_invite_code
    code = Invite.generate_invite_code
    assert code.length == 16
  end


  def test_accept_invite_code
    invite = Invite.find_by_invite_code('invite_code1')
    assert invite.accepted == false
    Invite.accept('invite_code1')
    invite = Invite.find_by_invite_code('invite_code1')
    assert invite.accepted == true
  end
  

end
