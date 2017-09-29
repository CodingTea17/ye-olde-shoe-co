class User < ActiveRecord::Base

  before_save(:hash_pass)


  def hash_pass()
    self.pass=(BCrypt::Password.create(pass).to_s)
  end

  def auth_pass(password, hash)
    BCrypt::Password.create("isarubyist") == password
  end
end
