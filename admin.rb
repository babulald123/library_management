# frozen_string_literal: true

load 'user'
load 'book.rb'
load 'library.rb'
load 'student.rb'

class Admin < User
  def self.all
    @@users.select { |user| user.type == to_s }
  end

  def self.operation
    puts Library.get_message[:admin_operation][:welcome]
    method_hash = Hash.new('operation')
    method_hash['1'] = 'Book.operation'
    method_hash['2'] = 'Library.sign_up'
    method_hash['3'] = 'delete_student'
    method_hash['4'] = 'student_list'
    method_hash['5'] = 'Library.render_menu'
    send(method_hash[gets.chomp])
  end

  def self.delete_student
    delete_stu_message = Library.get_message[:admin_operation]
    print delete_stu_message[:email]
    email = gets.chomp.to_s
    if @@users.delete_if { |student| student.email == email }
      print delete_stu_message[:deleted]
    else
      print delete_stu_message[:not_deleted]
    end
    Admin.operation
  end

  def self.student_list
    byebug
    print @@users.find_all { |student| student.type == 'Student' }
    operation
  end
end
