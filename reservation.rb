class Reservation
  attr_accessor :id, :user_name, :datetime, :contents, :created_at

  def initialize(id, user_name, datetime, contents, created_at)
    @id = id
    @user_name = user_name
    @datetime = datetime
    @contents = contents
    @created_at = created_at
  end

  def self.valid_year
    year = gets.chomp.to_i
    while year < Date.today.year
      puts "予約年が過ぎています。もう一度入力してください"
      printf "予約年(YYYY):"
      year = gets.chomp.to_i
    end
    year
  end

  def self.valid_month
    month = gets.chomp.to_i
    until 0 < month && month <= 12
      puts "1~12を入力してください"
      printf "予約月(MM):"
      month = gets.chomp.to_i
    end
    month
  end

  def self.valid_day(year, month)
    initial_day = gets.chomp.to_i
    days_of_month = Date.new(year, month, -1).mday
    day = reenter_of_day(initial_day, days_of_month)
  end

  def self.valid_hour
    hour = gets.chomp.to_i
    until 0 <= hour && hour <= 23
      puts "0~23を入力してください"
      printf "予約時間(時 HH):"
      hour = gets.chomp.to_i
    end
    hour
  end

  def self.valid_minutes
    minutes = gets.chomp.to_i
    until minutes == 0 || minutes == 30
      puts "0もしくは30を入力してください"
      printf "予約時間(分 MM):"
      minutes = gets.chomp.to_i
    end
    minutes
  end

  def self.reenter_of_day(day, days_of_month)
    until 0 < day && day <= days_of_month
      puts "1~#{days_of_month}を入力してください"
      printf "予約日(DD):"
      day = gets.chomp.to_i
    end
    day
  end
end
