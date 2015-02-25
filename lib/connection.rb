require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(
	:adapter  => "postgresql",
	:host => "localhost",
	:username => "AngeloMacBook",
	:database => "project_one")

ActiveRecord::Base.logger = Logger.new(STDOUT)