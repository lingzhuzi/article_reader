class Task < ActiveRecord::Base
  belongs_to :reader_config

  ERROR = 1
  SAVED = 2
  WAITING = 3
  RUNNING = 4
  ENDED = 5

  STATUS_NAME = {
    ERROR => '发生错误',
    SAVED => '排队中',
    WAITING => '等待中',
    RUNNING => '执行中',
    ENDED => '已完成'
  }

  def status_name
    STATUS_NAME[status]
  end
end
