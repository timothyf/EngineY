#   Copyright 2009 Timothy Fisher
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

require 'hpricot'
require 'net/http'
require 'uri'

=begin
  This class represents an XML Gadget specification.
=end
class GadgetSpec
  
  attr_reader :source, :module_prefs, :user_prefs
  
  
  def initialize(src)
    @source = src
  end
  
  
  # Parse the XML specification and store data into object attributes
  def parse
    @data = Crack::XML.parse(@source)
    @module_prefs = @data['Module']['ModulePrefs']    
    @user_prefs = @data['Module']['UserPref']   
  end
  
end