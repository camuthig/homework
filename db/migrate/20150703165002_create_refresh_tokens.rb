class CreateRefreshTokens < ActiveRecord::Migration
  def change
    create_table :refresh_tokens do |t|

      t.timestamps null: false
      t.belongs_to :user, index: true
      t.string :token, null: false
    end
  end
end
