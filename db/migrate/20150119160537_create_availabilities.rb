class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.references :coach,                   index: true
      t.datetime   :start_at
      t.datetime   :end_at
      t.time       :opening_time
      t.time       :closing_time
      t.integer    :duration
      t.boolean    :auto_confirmation,       default: false
      t.text       :unpermitted_weekdays,    array: true, default: []
      t.integer    :cancellation_period
      t.decimal    :late_cancellation_fee
      t.integer    :maximum_of_participants, default: 1
      t.integer    :priority,                default: 1
      t.timestamps
    end
  end
end
