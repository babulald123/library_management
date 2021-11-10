# frozen_string_literal: true

# Seed class
load 'admin.rb'
load 'student.rb'
load 'book.rb'

class Seed
  byebug
  def self.load_user
    # create automatic 5 Admin and 5 Student @@
    Admin.new('Admin', 'babulal', 'babulal@gmail.com', 'babulal@123')
    Admin.new('Admin', 'dangi', 'dangi@gmail.com', 'dangi@123')
    Admin.new('Admin', 'babulal', 'babulal1@gmail.com', 'babulal@123')
    Admin.new('Admin', 'dangi', 'dangi2@gmail.com', 'dangi@123')
    Admin.new('Admin', 'babulal', 'babulal3@gmail.com', 'babulal@123')

    Student.new('Student', 'babulal', 'babulal1@gmail.com', 'babulal@123')
    Student.new('Student', 'dangi', 'dangi2@gmail.com', 'dangi@123')
    Student.new('Student', 'babulal', 'babulal3@gmail.com', 'babulal@123')
    Student.new('Student', 'dangi', 'dangi4@gmail.com', 'dangi@123')
    Student.new('Student', 'babulal', 'babulal5@gmail.com', 'babulal@123')
  end
  byebug
  def self.load_books
    # name,id,author,
    Book.new('1', 'Ruby', 'Matz')
    Book.new('2', 'rails', 'David')
    Book.new('3', 'ruby', 'John ')
    Book.new('4', 'The Well', 'David A')
    Book.new('5', 'Ruby on Rails', 'Hansson')
  end
end
