require "./reservation"
require "./control"
require "date"
require "pry"

INDEX = 1
CREATE = 2
SHOW = 3
UPDATE = 4
DELETE = 5
FINISH = 6

@control = Control.new

loop do
  @control.disp

  case @control.selected_num_disp
  when INDEX
    @control.index
  when CREATE
    @control.create
  when SHOW
    @control.show
  when UPDATE
    @control.update
  when DELETE
    @control.delete
  when FINISH
    @control.finish
    break
  else
    puts "1~6を入力してください"
  end
end
