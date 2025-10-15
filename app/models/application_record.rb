class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # UUIDを主キーとして使用することを明示的に指定
  self.implicit_order_column = :created_at
  self.primary_key = 'id'
end