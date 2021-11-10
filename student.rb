# frozen_string_literal: true

require_relative 'user'
require_relative 'book'
require_relative 'library'

class Student < User
  def self.all
    @@users.select { |user| user.type == to_s }
  end

  def self.operation
    puts Library.get_message[:student_operation][:welcome]
    # method_hash = Hash.new('operation')
    # send(method_hash[gets.chomp.to_s])
    method_hash = { '1' => 'Book.create_issue_book_request',
                    '2' => 'Book.create_return_book_request',
                    '3' => 'Book.my_issue_book_list',
                    '4' => 'Library.render_menu' }
    i = gets.chomp
    method_hash[i]
  end
end
