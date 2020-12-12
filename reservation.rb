class Reservation
  attr_accessor :id, :user_name, :datetime, :contents, :created_at

  def initialize(id, user_name, datetime, contents, created_at)
    @id = id
    @user_name = user_name
    @datetime = datetime
    @contents = contents
    @created_at = created_at
  end
end
