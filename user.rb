# frozen_string_literal: true

require 'byebug'

class User
  @@users = []
  attr_accessor :first_name, :last_name, :email, :pass, :type, :errors

  def initialize(first_name:, last_name:, email:, pass:)
    @type = self.class.to_s
    @errors = []
    @first_name = first_name
    @last_name = last_name
    @email = email
    @pass = pass
    validate!
  end

  def save
    if valid?
      @@users << self
      self
    else
      false
    end
  end

  def self.find_by_email_and_pass(email:, pass:)
    user = find_by_email(email)
    user.authenticat(pass)
  end

  def self.find_by_email(email)
    all.select { |user| user.email == email }.first
  end

  def authenticat(pass)
    self.pass == pass ? self : nil
  end

  def self.all
    @@users
  end

  def student?
    type == 'Student'
  end

  def admin?
    type == 'Admin'
  end

  def valid?
    validate!
    errors.none?
  end

  def validate_email?
    !!(email =~ /\A[a-z0-9+\-_.]+@[a-z\d\-.]+\.[a-z]+\z/)
  end

  def validate_pass?
    (pass =~ /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*\W).{8,}$/)
  end

  def validate!
    set_errors('Invalid Email') unless validate_email?
    set_errors('Invalid Password') unless validate_pass?
  end

  def set_errors(val)
    @errors << val
  end
end
