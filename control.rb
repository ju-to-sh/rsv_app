class Control
  attr_accessor :reservations

  def initialize
    @reservations = []
    @id = 0
  end

  def disp
    puts <<~TEXT

           ----------------------------
                  予約管理アプリ
           ----------------------------
           番号を入力して下さい。
           1 : 予約一覧
           2 : 予約登録
           3 : 予約詳細
           4 : 予約更新
           5 : 予約削除
           6 : 予約完了

         TEXT
  end

  def selected_num_disp
    print "入力された番号:"
    selected_num = gets.chomp.to_i
  end

  def index
    if @reservations.empty?
      puts <<~TEXT

             登録された予約はありません
           TEXT
    else
      @reservations.each do |reservation|
        puts <<~TEXT

               【予約一覧】
                予約No.#{reservation.id}
                予約者  :#{reservation.user_name}
                予約日時:#{reservation.datetime}

             TEXT
      end
    end
  end

  def create
    @id += 1
    puts <<~TEXT

           予約を登録してください

         TEXT
    printf "予約者名:"
    @user_name = gets.chomp

    printf "予約年(YYYY):"
    year = valid_year

    printf "予約月(MM):"
    month = valid_month

    printf "予約日(DD):"
    day = valid_day

    printf "予約時間(時 HH):"
    hour = valid_hour

    printf "予約時間(分 MM):"
    minutes = valid_minutes

    @datetime = DateTime.new(year, month, day, hour, minutes).strftime("%Y年 %m月%d日 %H:%M")
    printf "予約内容:"
    @contents = gets.chomp

    @created_at = Date.today.strftime("%Y年 %m月%d日")

    @reservations << Reservation.new(@id, @user_name, @datetime, @contents, @created_at)
  end

  def show
    puts <<~TEXT

           詳細表示する予約Noを入力してください
         TEXT
    printf "予約No."
    index_num = gets.chomp.to_i
    reservation = find_reservation_id(index_num)

    if reservation.nil?
      puts <<~TEXT

             登録された予約はありません
           TEXT
    else
      puts <<~TEXT

             【予約詳細】
              予約者名:#{reservation.user_name}
              日時:#{reservation.datetime}
              内容:#{reservation.contents}
              登録日:#{reservation.created_at}

           TEXT
    end
  end

  def update
    puts <<~TEXT

           変更する予約Noを入力してください
         TEXT
    printf "予約No."
    index_num = gets.chomp.to_i

    if @reservations.empty?
      puts <<~TEXT

             登録された予約はありません
           TEXT
    else
      puts <<~TEXT

             予約を登録してください

           TEXT
      printf "予約者名:"
      @user_name = gets.chomp

      printf "予約年(YYYY):"
      year = gets.chomp.to_i
      printf "予約月(MM):"
      month = gets.chomp.to_i
      printf "予約日(DD):"
      day = gets.chomp.to_i
      printf "予約時間(時 HH):"
      hour = gets.chomp.to_i
      printf "予約時間(分 MM):"
      minutes = gets.chomp.to_i
      @datetime = DateTime.new(year, month, day, hour, minutes).strftime("%Y年 %m月%d日 %H:%M")

      printf "予約内容:"
      @contents = gets.chomp

      @created_at = Date.today.strftime("%Y年 %m月%d日")

      reservation = find_reservation_id(index_num)

      reservation.user_name = @user_name
      reservation.datetime = @datetime
      reservation.contents = @contents
      reservation.created_at = @created_at
    end
  end

  def delete
    puts <<~TEXT

           削除する予約Noを入力してください
         TEXT
    print "予約No."
    index_num = gets.chomp.to_i
    reservation = find_reservation_id(index_num)

    if reservation.nil?
      puts <<~TEXT

             登録された予約はありません
           TEXT
    else
      puts <<~TEXT

             以下の予約を削除しますか？

             予約者名:#{reservation.user_name}
             日時:#{reservation.datetime}
             内容:#{reservation.contents}
             登録日:#{reservation.created_at}

             はい => y
             いいえ => n

           TEXT

      loop do
        print "入力:"
        command = gets.chomp

        if command == "y"
          @reservations.delete_if do |reservation|
            reservation.id == index_num
          end

          puts "予約No.#{index_num}を削除しました"
          break
        elsif command == "n"
          puts "削除をキャンセルしました"
          break
        else
          puts <<~TEXT

                 無効なコマンドです
                 y もしくは n を入力してください

               TEXT
        end
      end
    end
  end

  def finish
    puts "アプリを終了します"
  end

  private

  def valid_year
    year = gets.chomp.to_i
    while year < Date.today.year
      puts "予約年が過ぎています。もう一度入力してください"
      printf "予約年(YYYY):"
      year = gets.chomp.to_i
    end
    year
  end

  def valid_month
    month = gets.chomp.to_i
    until 0 < month && month <= 12
      puts "1~12を入力してください"
      printf "予約月(MM):"
      month = gets.chomp.to_i
    end
    month
  end

  def valid_day
    day = gets.chomp.to_i
    until 0 < day && day <= 31
      puts "1~31を入力してください"
      printf "予約日(DD):"
      day = gets.chomp.to_i
    end
    day
  end

  def valid_hour
    hour = gets.chomp.to_i
    until 0 <= hour && hour <= 23
      puts "0~23を入力してください"
      printf "予約時間(時 HH):"
      hour = gets.chomp.to_i
    end
    hour
  end

  def valid_minutes
    minutes = gets.chomp.to_i
    until minutes == 0 || minutes == 30
      puts "0もしくは30を入力してください"
      printf "予約時間(分 MM):"
      minutes = gets.chomp.to_i
    end
    minutes
  end

  def find_reservation_id(index_num)
    @reservations.find do |reservation|
      reservation.id == index_num
    end
  end
end