require 'test_helper'

class BugReportsControllerTest < ActionController::TestCase
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bug_reports)
  end


  test "should get new" do
    get :new
    assert_response :success
  end
  

  test "should create bug report" do
    assert_difference('BugReport.count') do
      post :create, :bug_report => {:title=>"Test Bug",
                                    :browser=>"IE",
                                    :user_id=>1,
                                    :description=>'This is a bug',
                                    :module=>'test module',
                                    :resolved=>false,
                                    :comment=>'test comment',
                                    :priority=>'high'}
    end
    assert_redirected_to bug_reports_url
  end


  test "should show bug report" do
    get :show, :id => bug_reports(:one).id
    assert_response :success
  end


  test "should get edit" do
    get :edit, :id => bug_reports(:one).id
    assert_response :success
  end


  test "should update bug report" do
    put :update, 
        :id => bug_reports(:one).id, 
        :bug_report => {
            :title=>'Test Bug Report',
            :browser=>'FIREFOX',
            :user_id=>nil,
            :description=>'I am reporting a bug',
            :resolved=>false,
            :comment=>'comment'}
    assert_redirected_to bug_report_path(assigns(:bug_report))
  end


  test "should destroy bug report" do
    assert_difference('BugReport.count', -1) do
      delete :destroy, :id => bug_reports(:one).id
    end
    assert_redirected_to bug_reports_path
  end
  
end
