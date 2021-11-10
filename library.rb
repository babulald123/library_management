# frozen_string_literal: true

load 'user'
require_relative 'admin'
require_relative 'student'
require_relative 'seed'
require_relative 'book'
require 'yaml'

class Library
  attr_accessor :language

  Language = { '1': 'en', '2': 'hn' }.freeze

  def self.render_menu
    puts get_message[:welcome]
    method_hash = Hash.new('render_menu')
    method_hash['1'] = 'sign_in'
    method_hash['2'] = 'sign_up'
    method_hash['3'] = 'exit'
    send(method_hash[gets.chomp])
  end

  def self.sign_in
    sign_in_message = get_message[:sign_in]
    print sign_in_message[:email]
    email = gets.chomp
    print sign_in_message[:password]
    pass = gets.chomp
    type = User.find_by_email_and_pass(email: email, pass: pass)
    Kernel.const_get(type.type).operation
  end

  def self.sign_up
    sign_up_message = get_message[:sign_up]
    print sign_up_message[:first_name]
    first_name = gets.chomp
    print sign_up_message[:last_name]
    last_name = gets.chomp
    print sign_up_message[:email]
    email = gets.chomp
    print sign_up_message[:password]
    pass = gets.chomp
    print sign_up_message[:type]
    type = gets.chomp
    user = Kernel.const_get(type).new(first_name: first_name, last_name: last_name, email: email, pass: pass)
    if user.save
      print get_message[:sign_up][:success]
    else
      print user.errors.join('\n ')
      render_menu
    end
  end

  def self.select_language
    puts "===Select Language=== \n 1.English \n 2.Hindi \n"
    @language = Language[gets.chomp.to_sym]
    Library.render_menu
  end

  def self.get_message
    YAML.safe_load(File.read("#{@language}.yml"))['messages']
  end
end

Library.select_language
