class CreateHomeworksUsers < ActiveRecord::Migration
  def change
    create_table :homeworks_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :homework, index: true
      t.timestamps null: false
    end
  end
end
