require 'fileutils'

Given /^a built test app$/ do
  target = File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "fixtures", "test-app")
  build_cmd = File.expand_path(File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "bin", "mm-build"))
  `cd #{target} && MM_DIR="#{target}" #{build_cmd}`
end

Given /^cleanup built test app$/ do
  target = File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "fixtures", "test-app", "build")
  FileUtils.rm_rf(target)
end

Then /^"([^"]*)" should exist and include "([^"]*)"$/ do |target_file, expected|
  target = File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "fixtures", "test-app", "build", target_file)
  File.exists?(target).should be_true
  File.read(target).should include(expected)
end

Then /^"([^"]*)" should not exist$/ do |target_file|
  target = File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "fixtures", "test-app", "build", target_file)
  File.exists?(target).should be_false
end



# require 'fileutils'
# 
# describe "Builder" do
#   def project_file(*parts)
#     File.expand_path(File.join(File.dirname(__FILE__), "..", *parts))
#   end
# 
#   before :all do
#     @root_dir = project_file("spec", "fixtures", "sample")
#   end
# 
#   before :each do
#     build_cmd = project_file("bin", "mm-build")
#     `cd #{@root_dir} && MM_DIR="#{@root_dir}" #{build_cmd}`
#   end
# 
#   after :each do
#     FileUtils.rm_rf(File.join(@root_dir, "build"))
#   end