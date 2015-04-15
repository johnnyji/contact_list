
require 'pg'
require 'csv'
require 'pry'
require 'colorize'
require 'active_record'
require_relative 'contact'
require_relative 'phone'

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  host: 'ec2-23-23-81-189.compute-1.amazonaws.com',
  username: 'ialdkhhdcbklat',
  password: 'O4UezuX1JDcu1QRaRT-S1JDA6F',
  database: 'd8mj58fuvafa0v'
)