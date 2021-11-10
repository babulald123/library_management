# frozen_string_literal: true

require 'byebug'
require_relative 'user'
load '../library/admin.rb'
require_relative 'library'

class Book
  attr_accessor :id, :name, :author

  @@books = []
  @@issue_books = []
  @@issue_request_list = []
  @@return_request_list = []
  @@my_issue_book_list = []

  def initialize(id:, name:, author:)
    @id = id
    @name = name
    @author = author
    @@books << self
  end

  def self.operation
    puts Library.get_message[:book_operation][:welcome]
    method_hash = Hash.new('operation')
    method_hash['1'] = 'create_book'
    method_hash['2'] = 'delete_book'
    method_hash['3'] = 'issue_book'
    method_hash['4'] = 'return_book'
    method_hash['5'] = 'issue_request_list'
    method_hash['6'] = 'return_request_list'
    method_hash['7'] = 'all'
    method_hash['8'] = 'Admin.operation'
    send(method_hash[gets.chomp])
  end

  def self.create_book
    create_book_message = Library.get_message[:create_book]
    print create_book_message[:id]
    id = gets.chomp.to_i
    if @@books.find { |book| book.id == id }
      print create_book_message[:already]
    else
      print create_book_message[:name]
      name = gets.chomp
      print create_book_message[:author]
      author = gets.chomp
      Book.new(id: id, name: name, author: author)
      print create_book_message[:added]
    end
    operation
  end

  def self.find_by_name(name)
    @@books.select { |book| book.name == name.to_s }
  end

  def self.update!(id, author)
    self.id = id
    self.author = author
    self
  end

  def self.delete_book
    delete_book_message = Library.get_message[:delete_book]
    print delete_book_message[:id]
    id = gets.chomp.to_i
    if @@books.delete_if { |book| book.id == id }
      print delete_book_message[:deleted]
    else
      print delete_book_message[:not_exists]
    end
    operation
  end

  def self.issue_book
    issue_book_message = Library.get_message[:issue_book]
    if @@issue_request_list.empty?
      print issue_book_message[:empty]
    else
      @@issue_request_list.each do |i|
        if @@books.find { |book| book.id == i.to_i }
          @@my_issue_book_list.append(i)
          @@books.delete(i)
          print issue_book_message[:issued]
        else
          print issue_book_message[:not_exists]
        end
      end
    end
    operation
  end

  def self.return_book
    return_book_message = Library.get_message[:return_book]
    if @@issue_request_list.empty?
      print return_book_message[:empty]
    else
      @@issue_return_list.each do |i|
        if @@books.find { |book| book.id == i.to_i }
          print return_book_message[:already]
          @@my_issue_book_list.delete(i)
          @@return_request_list.delete(i)
        else
          @@books.append(i)
          @@my_issue_book_list.delete(i)
          @@return_request_list.delete(i)
          print return_book_message[:return]
        end
      end
    end
    operation
  end

  def self.create_issue_book_request
    issue_request_message = Library.get_message[:issue_request]
    print issue_request_message[:id]
    id = gets.chomp.to_i
    if @@books.find { |book| book.id == id }
      @@issue_request_list.append(id)
      print issue_request_message[:success]
    else
      print issue_request_message[:not_exists]
    end
    Student.operation
  end

  def self.create_return_book_request
    return_request_message = Library.get_message[:return_request]
    print return_request_message[:id]
    id = gets.chomp.to_i
    if @@books.find { |book| book.id == id }
      print return_request_message[:already]
      @@my_issue_book_list.delete(id)
    else
      @@return_request_list.append(id)
      print return_request_message[:success]
    end
    Student.operation
  end

  def self.issue_request_list
    issue_book_message = Library.get_message[:issue_book]
    if @@issue_request_list.empty?
      print issue_book_message[:empty]
    else
      print @@issue_request_list
    end
  end

  def self.return_request_list
    return_book_message = Library.get_message[:return_book]
    if @@return_request_list.empty?
      print return_book_message[:empty]
    else
      print @@return_request_list
    end
  end

  def self.destroy(id)
    @@books.delete_if { |book| book.id == id.to_i }
  end

  def self.my_issue_book_list
    print @@my_issue_books
    Student.operation
  end

  def self.all
    print @@books
    # Admin.book_operation#
  end
end
# book_id, book_author
