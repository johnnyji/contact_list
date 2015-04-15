
require 'pg'
require 'csv'
require 'pry'
require 'colorize'
require 'active_record'
require_relative 'contact'
require_relative 'phone'

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  host: 'ec2-54-163-225-82.compute-1.amazonaws.com',
  username: 'rpdpzqtjsmvnbv',
  password: 'cvuaKUHlD4wJ68QnHucjBNqQyx',
  database: 'd96rfcutpr7g5e'
)